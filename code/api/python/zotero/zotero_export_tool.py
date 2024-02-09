# zotero_export_tool.py, a Python script for retrieving data from the Zotero API.

# (c) 2024 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf

version = '0.3.0'
created = '2024-02-08'

# Zotero API developer guide: https://www.zotero.org/support/dev/web_api/v3/start
# Example request URL: https://api.zotero.org/groups/2267085/items?format=json&amp;include=bib,data,coins,citation&amp;style=chicago-fullnote-bibliography

# -----------------------------------------
# Version 0.1.0 change notes:
# - This script does not currently support caching and conditional GET requests. If the dataset is large and changes
#   to it are small, this capability should be added. requests caching is enabled but that only caches HTTP requests for 5 minutes.
# - The script does not do any intrinsic throttling, since the API guide does not suggest any overall rate limits. However,
#   it does support Backoff and Retry-After headers from the server when it is overloaded or too many requests are made in a certain period of time.
# - The script does not handle every possible error condition, but if an agent ID is invalid (resulting in a 500 error), it 
#  does prompt the user to check the submitted ID.
# -----------------------------------------
# Version 0.2.0 change notes:
# - Add support for a command line argument (--start or -S) to start the paging at a number other than
#   the default 0 (i.e. the first page). This enables restart if the download crashes.
# - Change handling of 500 error code to allow the user to choose to abort or try again after they wait awhile. 
# -----------------------------------------
# Version 0.3.0 change notes:
# - Add support for a command line argument (--modpath or -M) to specify the path to a file that contains the last modified version of the library.
#   If this file is specified, the script will retrieve only records that have been modified since the last download. Otherwise, the entire dataset will be retrieved.
# - Change behavior of the 500 error code to wait 10 minutes before trying again.

# -----------------------------------------
# Import modules.
# -----------------------------------------

import requests
from typing import List, Dict, Tuple, Optional, Any
import requests_cache
import json
import xml.etree.ElementTree as ET
import sys
from time import sleep

# Set up cache for HTTP requests to prevent unnecessary repeat requests.
requests_cache.install_cache('zotero_cache', backend='sqlite', expire_after=300, allowable_methods=['GET', 'POST'])

# -----------------------------------------
# Support for command-line arguments.
# -----------------------------------------

arg_vals = sys.argv[1:]
if '--version' in arg_vals or '-V' in arg_vals: # provide version information according to GNU standards 
    print()
    print('Zotero export tool', version)
    print('Copyright ©', created[:4], 'Vanderbilt University')
    print('License GNU GPL version 3.0 <http://www.gnu.org/licenses/gpl-3.0>')
    print('This is free software: you are free to change and redistribute it.')
    print('There is NO WARRANTY, to the extent permitted by law.')
    print('Author: Steve Baskauf')
    print('Revision date:', created)
    print()
    sys.exit()

if '--help' in arg_vals or '-H' in arg_vals: # provide help information according to GNU standards
    print()
    print ('Example usage: ')
    print('python zotero_export_tool.py --id 2267085 --path ./data/')
    print('For help, see the documentation page at https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/zotero/README.md')
    print('Report bugs to: digital.lab@vanderbilt.edu')
    print()
    sys.exit()

opts = [opt for opt in arg_vals if opt.startswith('-')]
args = [arg for arg in arg_vals if not arg.startswith('-')]

no_id = True # To test wihout using the command line option and a hard-coded ID, set this to False and uncomment the next line.
#agent_id = '2267085'

if '--id' in opts: #  set Zotero ID
    agent_id = args[opts.index('--id')]
    no_id = False
if '-I' in opts: 
    agent_id = args[opts.index('-I')]
    no_id = False
if no_id:
    print('Error: no Zotero ID specified. Use the --id or -I command line option.')
    sys.exit()

data_path = '' # Default to current working directory.
if '--path' in opts: #  set path to output data file
    data_path = args[opts.index('--path')]
if '-P' in opts: 
    data_path = args[opts.index('-P')]

paging_start = 0 # Default to the first page.
if '--start' in opts: #  get the integer paging start value
    paging_start = int(args[opts.index('--start')])
if '-S' in opts: 
    paging_start = int(args[opts.index('-S')])

# If the modification file path is specified, the query will retrieve only records that have
# been modified since the last download. Otherwise, the entire dataset will be retrieved.
modification_file_path = ''
LAST_MODIFIED_VERSION = 0
if '--modpath' in opts: #  get the path to the config XML file with the last modified version
    modification_file_path = args[opts.index('--modpath')]
if '-M' in opts: 
    modification_file_path = args[opts.index('-M')]

if modification_file_path != '':
    # Open the zotero-config.xml file and read it into a string.
    with open(modification_file_path, 'r') as file:
        xml_text = file.read()

    # Convert the XML text string to a data structure
    root_node = ET.fromstring(xml_text)
    # Get the last-modified-version from the XML.
    LAST_MODIFIED_VERSION = int(root_node.find('last-modified-version').text)
    print('last modified version:', LAST_MODIFIED_VERSION)

# Global variables.
BASE_URL = 'https://api.zotero.org'
VERSION_HTTP_HEADER = {'Zotero-API-Version': '3'}

# -----------------------------------------
# Define functions.
# -----------------------------------------

def get_zotero_data(agent_id: str, request_limit=100, paging_start=0, library_type='groups', what_to_include='bib,data,coins,citation', endpoint='items', citation_style='chicago-fullnote-bibliography') -> Tuple[int, str]:
    """Make a Zotero API request and return the JSON data.

    Parameters
    ----------
    agent_id : str
        Zotero user or group ID
    library_type : str
        "users" or "groups"
    what_to_include : str
        Text list of what to include in the response. Default is based on the example request URL.
        See https://www.zotero.org/support/dev/web_api/v3/basics for other options.
    endpoint : str
        Particular endpoint to query. Possible values are "collections", "items", "searches", and "tags".
    citation_style : str
        Citation style to use.

    Returns
    -------
    Tuple consisting of the HTTP status code, the response header, and the data in text format. 
        If status 200, the data are JSON. Otherwise they are probably an error message.
    """
    global BASE_URL, VERSION_HTTP_HEADER, LAST_MODIFIED_VERSION
    
    query_string_dict = {
        'format': 'json',
        'include': what_to_include,
        'style': citation_style,
        'limit': request_limit,
        'start': paging_start
    }

    # If the modification file path was specified, the query will retrieve only records that have
    # been modified since the last download. Otherwise, the entire dataset will be retrieved.
    if LAST_MODIFIED_VERSION > 0:
        query_string_dict['since'] = LAST_MODIFIED_VERSION

    url = BASE_URL + '/' + library_type + '/' + agent_id + '/' + endpoint
    r = requests.get(url, params=query_string_dict, headers=VERSION_HTTP_HEADER)
    
    return r.status_code, r.headers, r.text

def retrieve_page_of_data(agent_id: str, backoff_time: int, request_limit=100, paging_start=0, library_type='groups', what_to_include='bib,data,coins,citation', endpoint='items', citation_style='chicago-fullnote-bibliography') -> List[Dict[str, Any]]:
    """Retrieve a page of Zotero data and handle a variety of error conditions.

    Parameters
    ----------
    agent_id : str
        Zotero user or group ID
    backoff_time : int
        Number of seconds to wait before trying again if the server is overloaded.
    library_type : str
        "users" or "groups"
    what_to_include : str
        Text list of what to include in the response. Default is based on the example request URL.
        See https://www.zotero.org/support/dev/web_api/v3/basics for other options.
    endpoint : str
        Particular endpoint to query. Possible values are "collections", "items", "searches", and "tags".
    citation_style : str
        Citation style to use.

    Returns
    -------
    Tuple consisting of a list of dictionaries with each dictionary representing one reference, 
    an integer indicating the number of seconds to wait before trying again if the server is overloaded,
    an integer indicating the total number of results available, and an integer indicating
    # the last modified version of the library.
    """
    try_again = True
    max_tries = 10
    tries = 0
    while try_again:
        tries += 1

        if backoff_time > 0:
            print('Server overloaded. Waiting', backoff_time, 'seconds before trying again.')
            sleep(backoff_time)

        # Make HTTP request to API.
        code, headers, data_string = get_zotero_data(agent_id, request_limit=request_limit, paging_start=paging_start, library_type=library_type, what_to_include=what_to_include, endpoint=endpoint, citation_style=citation_style)
        #print(headers)

        # Get the library version to save to use in the "since" parameter in the next request. 
        if 'Last-Modified-Version' in headers:
            latest_modified_version = int(headers['Last-Modified-Version'])
            #print('latest modified version:', latest_modified_version)

        # Check whether the server is overloaded and has requested the client to back off. The request is not handled here
        # because if there is only one page requested, or if this is the last page, we don't want to make the user wait.
        # Instead, the backoff time is returned to the calling function, which will implement the delay before the next
        # page request (if any).
        if 'Backoff' in headers:
            backoff_time = int(headers['Backoff'])
        else:
            backoff_time = 0

        # Handle HTTP response codes.
        if code == 200:
            data_structure = json.loads(data_string)
            try_again = False
        # !!! NOTE: The script does not currently support caching, so this response code should not be issued and isn't handled.
        # If cache support is desired there would be a lot more code that needs to be written.
        elif code == 304:
            try_again = False
            pass # Use the cached data.
        elif code == 429: # Too many requests. Wait the indicated number of seconds and try again.
            if tries >= max_tries + 1:
                print('Too many tries. Giving up.')
                sys.exit(0)
            else:
                print('Too many requests. Waiting', headers['Retry-After'], 'seconds and trying again.')
                delay = int(headers['Retry-After'])
                sleep(delay)
        elif code == 500:
            if tries >= max_tries + 1:
                print('Too many tries. Giving up.')
                sys.exit(0)
            else:
                print('500 status code.')
                print('message:', data_string)
                print('This error occurs when the provided ID is invalid, but may occur for')
                print('other unknown reasons.')
                print()
                print('Waiting 10 minutes before trying again.')
                #user_response = input('To quit the download, enter "Q". To try again, press the Enter key.')
                #if user_response != '':
                #    sys.exit(0)
                delay = 600
                sleep(delay)
            
        elif code == 503: # Service unavailable. Wait the indicated number of seconds and try again.
            if tries >= max_tries + 1:
                print('Too many tries. Giving up.')
                sys.exit(0)
            else:
                print('Service unavailable. Waiting', headers['Retry-After'], 'seconds and trying again.')
                delay = int(headers['Retry-After'])
                sleep(delay)
        else:
            print(code, 'status code, message:', data_string)
            sys.exit(0) # Exit the program if there is an undetermined error.

    # Get the total number of records that are available. This is not known prior to the first page request, but
    # but will be used prior to the next loop to determine whether to request additional pages or not.
    total_results = int(headers['Total-Results'])

    #print(json.dumps(data_structure, indent=2))
    return data_structure, backoff_time, total_results, latest_modified_version

# -----------------------------------------
# Main program.
# -----------------------------------------

backoff_time = 0 # Set the initial backoff time to zero. It will be updated after each page is retrieved if the server is overloaded.
# paging_start is set at the start of the program either by a command line argument or defaulting to 0.
#paging_start = 0 # Start retrieving records from the first one. This will be incremented by the request_limit after each page is retrieved.
request_limit = 100 # Maximum number of records to retrieve in one request.

total_results = 1000000 # Set to a high value to force the first retrieval. Actual value will be set in the while loop.

while paging_start < total_results:
    print('paging start index:', paging_start)

    # If there is a backoff time, I'm handling it before the next request is made, since I don't want to 
    # make the user wait after the last request is made. NOTE: backoff requests may be made even if the request was successful.
    if backoff_time > 0:
        print('Server overloaded. Waiting', backoff_time, 'seconds before trying again.')
        sleep(backoff_time)

    data_structure, backoff_time, total_results, latest_modified_version = retrieve_page_of_data(agent_id, backoff_time, request_limit=request_limit, paging_start=paging_start)

    # For testing, hard code the total_results value.
    #total_results = 100

    # Print the number of records to be retrieved in the first loop only.
    if paging_start == 0:
        print('total results to be retrieved:', total_results)

    # Save the acquired JSON data into a file.
    with open(data_path + 'zotero_' + str(paging_start) + '.json', 'w') as outfile:
        json.dump(data_structure, outfile, indent=2)
    paging_start += request_limit # Increment the paging start value for the next request.

print('The number of the latest modified version is:', latest_modified_version)

print('Download completed successfully')
