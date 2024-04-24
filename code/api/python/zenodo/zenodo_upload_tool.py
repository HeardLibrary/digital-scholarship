# zenodo_upload_tool.py, a Python script for uploading resources through the Zenodo API.

# (c) 2024 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf

version = '0.1.0'
created = '2024-04-23'

# Zenodo API developer guide: https://developers.zenodo.org/#quickstart-upload

# To request an access token from the website, drop down "Applications" in the user menu.
# On the Applications page, click "New token" and fill out the form, checking the actions and write scopes.
# Copy the access token and save it in a plain text file in your home directory. 
# The file must contain only the key and no other text.

# -----------------------------------------
# Version 0.1.0 change notes: 
# - There is at least one untrapped error contition that does not seem to be detected. If the deposition record is created
#   but the upload does not complete, there will be a metadata record for the user that is not published and therefore
#   does not have a registered DOI. I'm not sure which stage in the process this is happening or how to detect and trap it.
#   I'm logging an error for failure to return an access_url, which seems to be a detectable effect of this problem.
# -----------------------------------------

# -----------------------------------------
# Import modules.
# -----------------------------------------

import requests
import json
from pathlib import Path
from time import sleep
from typing import List, Dict, Tuple, Optional, Union, Any
import logging # See https://docs.python.org/3/howto/logging.html
import pandas as pd

# -----------------------------------------
# Global variables
# -----------------------------------------

# NOTE: The access tokens for the sandbox and production Zenodo instances are different. To use the sandbox, you need
# to log in to the sandbox instance and create a new access token.

#BASE_URL = 'https://zenodo.org/api'
BASE_URL = 'https://sandbox.zenodo.org/api' # for testing
HTTP_HEADER = {
    'Content-Type': 'application/json'
    }
#API_ACCESS_TOKEN_FILENAME = 'zenodo_bioimages_upload_access_token.txt'
API_ACCESS_TOKEN_FILENAME = 'zenodo_sandbox_access_token.txt'

HOME = str(Path.home()) # gets path to home directory; supposed to work for both Win and Mac

# These may vary among users, so make them mutable here rather than hardcoding in the script.
FILENAME_COLUMN_HEADER = 'fileName'
ACCESS_URL_COLUMN_HEADER = 'ac_hasServiceAccessPoint'
METADATA_FILENAME = 'images.csv'
OUTPUT_FILENAME = 'modified_image.csv'

# -----------------------------------------
# Idiosyncratic functions
# -----------------------------------------

# Due to variation among user file organization and file structure, the following functions may need to be customized.

def construct_home_subpath(metadata: Dict[str, Any]) -> str:
    """Construct the subpath to where the file is located relative to the home directory."""
    # Images are stored in a subdirectory named after the image owner. The subdirectory is after the subdomain 
    # in the dcterms_identifier field.
    subdirectory = metadata['dcterms_identifier'].split('/')[3] # e.g. http://bioimages.vanderbilt.edu/usn/PDSUSNPB6-036
    home_subpath = '/bioimages-highres/' + subdirectory + '/'
    return home_subpath

def construct_metadata_dict(metadata: Dict[str, Any]) -> Dict[str, Any]:
    """Construct the metadata dictionary for the file to be sent to the Zenodo API.
    The keys of the source metadata dictionary are the column headers from the source CSV file.
    The keys of the output metadata_dict are the keys used by the Zenodo API.
    """
    # Format the creation date as a string in the format 'YYYY-MM-DD'
    if len(metadata['dcterms_created']) == 4:
        creation_date = metadata['dcterms_created'] + '-01-01'
    elif len(metadata['dcterms_created']) == 7:
        creation_date = metadata['dcterms_created'] + '-01'
    elif len(metadata['dcterms_created']) > 10:
        creation_date = metadata['dcterms_created'][:10]
    else:
        creation_date = metadata['dcterms_created']

    # Format the publication date as a string in the format 'YYYY-MM-DD'
    if len(metadata['dcterms_dateCopyrighted']) == 4:
        publication_date = metadata['dcterms_dateCopyrighted'] + '-01-01'
    else:
        publication_date = '2015-01-01' # Public domain images from Vanderbilt sources

    # Reverse the order of the creator name to family name, given name
    creator_name = metadata['xmpRights_Owner']
    if creator_name == 'public domain': # In Bioimages, none of the public domain images have a creator name
        reversed_name = 'unknown'
    elif ',' in creator_name:
        reversed_name = creator_name
    else:
        creator_name_parts = creator_name.split(' ')
        if len(creator_name_parts) > 1:
            reversed_name = creator_name_parts[-1] + ', ' + ' '.join(creator_name_parts[:-1])
        else:
            reversed_name = creator_name_parts[0]
    
    # Determine the license based on the usageTermsIndex value
    if metadata['usageTermsIndex'] == '0':
        license_id = 'cc0-1.0'
    elif metadata['usageTermsIndex'] == '4':
        license_id = 'cc-by-nc-sa-4.0'
    else:
        license_id = 'cc-by-4.0'

    # Construct the location description
    location_description = metadata['dwc_georeferenceRemarks']
    if metadata['dwc_informationWithheld'] != '':
        location_description += ' ' + metadata['dwc_informationWithheld']
    if metadata['dwc_dataGeneralizations'] != '':
        location_description += ' ' + metadata['dwc_dataGeneralizations']

    # Construct custom metadata based on Darwin and Audiovisual Core properties
    # In order to allow for multiple values, the values are stored as lists.
    custom_metadata = {}
    custom_metadata['dwc:geodeticDatum'] = [metadata['dwc_geodeticDatum']]
    custom_metadata['dwc:coordinateUncertaintyInMeters'] = [metadata['dwc_coordinateUncertaintyInMeters']]
    if metadata['dwc_occurrenceRemarks'] != '':
        custom_metadata['dwc:occurrenceRemarks'] = [metadata['dwc_occurrenceRemarks']]
    if metadata['ac_caption'] != '':
        custom_metadata['ac:caption'] = [metadata['ac_caption']]

    # Construct the metadata dictionary
    metadata_dict = {}
    metadata_dict['title'] = metadata['dcterms_title']
    metadata_dict['upload_type'] = 'image'
    metadata_dict['image_type'] = 'photo' # Required for images
    metadata_dict['publication_date'] = publication_date
    metadata_dict['description'] = metadata['dcterms_description']
    metadata_dict['creators'] = [{'name': reversed_name}]
    metadata_dict['contributors'] = [{'name': 'Baskauf, Steven J.', 'affiliation': 'Vanderbilt University', 'type': 'DataCurator'}]
    metadata_dict['access_right'] = 'open'
    metadata_dict['license'] = license_id
    metadata_dict['keywords'] = ['bioimages', 'biodiversity']
    metadata_dict['notes'] = 'This image is part of the Bioimages collection of live organism images at <a href="https://bioimages.vanderbilt.edu/">https://bioimages.vanderbilt.edu/.</a> Full metadata at <a href="https://doi.org/10.5281/zenodo.594019">https://doi.org/10.5281/zenodo.594019</a>.'
    metadata_dict['related_identifiers'] = [
        {'relation': 'isIdenticalTo', 'identifier': metadata['dcterms_identifier'], 'resource_type': 'image-photo'},
        {'relation': 'documents', 'identifier': metadata['foaf_depicts'], 'resource_type': 'physicalobject'},
        {'relation': 'isPartOf', 'identifier': 'https://bioimages.vanderbilt.edu/', 'resource_type': 'dataset'},
        {'relation': 'hasMetadata', 'identifier': '10.5281/zenodo.594019', 'resource_type': 'dataset'}
        ]
    metadata_dict['locations'] = [{'lat': metadata['dwc_decimalLatitude'], 'lon': metadata['dwc_decimalLongitude'], 'place': metadata['dwc_locality'] + ', ' + metadata['dwc_county'] + ', ' + metadata['dwc_stateProvince'] + ', ' + metadata['dwc_countryCode'], 'description': location_description}]
    metadata_dict['dates'] = [{'start': creation_date, 'end': creation_date, 'type': 'Collected', 'description': 'Date of organism occurrence.'}]
    metadata_dict['custom'] = custom_metadata
    #print(json.dumps(metadata_dict, indent = 2))

    return metadata_dict 

# -----------------------------------------
# Functions
# -----------------------------------------

def read_access_token() -> str:
    """Read the API access token from a file in the home directory."""
    try:
        with open(HOME + '/' + API_ACCESS_TOKEN_FILENAME, 'r') as file:
            api_access_token = file.read().strip() # remove any leading or trailing white space or newlines
        return api_access_token
    except FileNotFoundError:
        print('The access token file', API_ACCESS_TOKEN_FILENAME, 'is not in the home directory.')
        # Kill the program since it cannot function without an access token.
        exit()

def create_new_deposition(api_access_token: str) -> Tuple[str, str]:
    """Create a new deposition on Zenodo.

    Returns a tuple containing the deposition ID and the upload bucket URL.
    """
    request_url = BASE_URL + '/deposit/depositions'
    request_params = {'access_token': api_access_token}
    payload = {}
    response = requests.post(request_url, params=request_params, json=payload, headers=HTTP_HEADER)

    # There should be no error in creating a new deposition unless the access token is invalid or the site is down.
    # So kill the script if there is an error.
    if response.status_code != 201:
        print('Error creating new deposition:', response.status_code)
        print(response.json())
        exit()

    response_data = response.json()
    #print(json.dumps(response_data, indent = 2))

    # Extract the bucket URL and deposition ID from the response data
    bucket_url = response_data['links']['bucket']
    deposition_id = response_data['id']

    return deposition_id, bucket_url

def upload_file_to_bucket(api_access_token: str, bucket_url: str, filename: str, home_subpath: str) -> Union[str, None]:
    """Upload a file to the Zenodo bucket created for the deposition.

    Parameters
    ----------
    api_access_token : str
        API access token loaded from hard drive.
    bucket_url : str
        URL of the upload bucket URL retrieved when the deposition was created (no trailing slash).
    filename : str
        Name of the file to upload.
    home_subpath : str
        Subpath of the home directory where the file is located (leading and trailing slashes required).
    
    Returns
    -------
    A string for the access URL if successful or None if unsuccessful.
    """
    local_file_path = HOME + home_subpath + filename
    bucket_file_url = bucket_url + '/' + filename
    request_params = {'access_token': api_access_token}

    try:
        with open(local_file_path, "rb") as file_object:
            response = requests.put(bucket_file_url, data=file_object, params=request_params)

        if response.status_code != 201:
            logging.warning('Error ' + str(response.status_code) + ' uploading file', filename)
            return None
        else:
            data = response.json()
            file_access_url = data['links']['self']
            return file_access_url
    except FileNotFoundError:
        logging.warning('File ' + local_file_path + ' not found')
        return None

def add_metadata_to_deposition(api_access_token: str, deposition_id: str, metadata: Dict[str, Any]) -> Union[str, None]:
    """Add metadata to a deposition on Zenodo.

    Parameters
    ----------
    api_access_token : str
        API access token loaded from hard drive.
    deposition_id : str
        ID of the deposition to which metadata will be added.
    metadata : dict
        Metadata to add to the deposition.

    Returns
    -------
    A string 'success' if successful or None if unsuccessful.
    """
    deposition_url = BASE_URL + '/deposit/depositions/' + str(deposition_id)
    request_params = {'access_token': api_access_token}
    payload = {'metadata': metadata}

    response = requests.put(deposition_url, params=request_params, data=json.dumps(payload),headers=HTTP_HEADER)
    if response.status_code != 200:
        logging.warning('Error ' + str(response.status_code) + ' when adding metadata')
        return None
    else:
        return 'success'
    
def publish_deposition(api_access_token: str, deposition_id: str) -> Tuple[Union[str, None], int]:
    """Publish a deposition on Zenodo.

    Parameters
    ----------
    api_access_token : str
        API access token loaded from hard drive.
    deposition_id : str
        ID of the deposition to publish.

    Returns
    -------
    A tuple consisting of a concept DOI string if successful or None if unsuccessful, and the record ID.
    """
    publication_url = BASE_URL + '/deposit/depositions/' + str(deposition_id) + '/actions/publish'
    request_params = {'access_token': api_access_token}

    response = requests.post(publication_url, params=request_params)
    if response.status_code != 202:
        logging.warning('Error ' + str(response.status_code) + ' when publishing')
        return None
    else:
        # Capture the conceptdoi, which always refers to the latest version rather than doi, which is version-specific.
        try:
            concept_doi = response.json()['conceptdoi']
        except KeyError:
            logging.warning('Error: conceptdoi not found in response.')
            concept_doi = None
        # Also capture the record ID, which is needed to build the permanent access URL for the file (i.e. image).
        record_id = response.json()['id']

        return concept_doi, record_id

# -----------------------------------------
# Main routine
# -----------------------------------------

# Print starting time
print('Starting at', pd.Timestamp.now())

# Set up log for warnings
# This is a system file and hard to look at, so its data are harvested and put into a plain text log file later.
logging.basicConfig(filename='warnings.log', filemode='w', format='%(message)s', level=logging.WARNING)

# Initiate error logging file object
error_log_object = open('log_error.txt', 'wt', encoding='utf-8') # direct the output of log_object to log file instead of sys.stdout

api_access_token = read_access_token()

# Load file metadata from CSV spreadsheet
files_metadata = pd.read_csv(METADATA_FILENAME, na_filter=False, dtype = str)

# Set up a list to hold the modified metadata dictionaries for each file (for eventual output as CSV).
modified_metadata_list = []

# Loop through each file to be uploaded
for index, file_series in files_metadata.iterrows():
    print(index)
    # Convert the file_series to a vanilla dictionary
    metadata = file_series.to_dict()

    # Clear the warnings log
    with open('warnings.log', 'wt'):
        pass

    deposition_id, bucket_url = create_new_deposition(api_access_token)
    print('Deposition ID:', deposition_id)
    print('Bucket URL:', bucket_url)

    # The home subpath is ideosyncratic to the particular user, so put it in a function rather than hardcoding it here.
    home_subpath = construct_home_subpath(metadata)

    # The access_url actually isn't the one that should be used as the service access point for the original image,
    # since I don't know if the uploaded file is maintained in that bucket indefinitely. However, it is useful for
    # as a test to know that the upload was successful. 
    access_url = upload_file_to_bucket(api_access_token, bucket_url, metadata[FILENAME_COLUMN_HEADER], home_subpath)
    if access_url is not None:
        # Add metadata to the deposition
        metadata_dict = construct_metadata_dict(metadata)
        metadata_response = add_metadata_to_deposition(api_access_token, deposition_id, metadata_dict)
        if metadata_response is not None:
            print('Metadata added')

            # Publish the deposition

            # Something weird is going on here. Sometimes the previous publication_doi is returned, which it should
            # be None if the deposition publication fails. This results in two rows in the metadata file with the same
            # publication DOI.
            publication_doi, record_id = publish_deposition(api_access_token, deposition_id)
            if publication_doi is not None:
                print('Deposition published with DOI:', publication_doi)
            else:
                print('Error publishing deposition')
        else:
            print('Error adding metadata')
    else:
        logging.warning('Error uploading file: ' + metadata[FILENAME_COLUMN_HEADER])
        print('Error uploading file:', metadata[FILENAME_COLUMN_HEADER])

    # Read the warnings log and write to the error log file if there are any warnings.
    # For some reason, the log is considered considered a binary file. So when it is read in as text, 
    # it contains many null characters. So they are removed from the string read from the file.
    with open('warnings.log', 'rt') as file_object:
        warnings_text = file_object.read().replace('\0', '')
    if warnings_text != '':
        print('File:', metadata[FILENAME_COLUMN_HEADER], file=error_log_object) # Print the file name to the log file for each loop
        print(warnings_text, file=error_log_object)
        print('', file=error_log_object) # Skip a line in the log file between loop iterations

    # Construct the access_url and insert it into the original metadata as the ac_hasServiceAccessPoint value.
    # The form of the access_url is https://zenodo.org/records/[record_id]/files/[filename]
    access_url = 'https://zenodo.org/records/' + str(record_id) + '/files/' + metadata[FILENAME_COLUMN_HEADER]
    metadata[ACCESS_URL_COLUMN_HEADER] = access_url

    # Add the doi to the metadata dict.
    if publication_doi is not None:
        metadata['doi'] = publication_doi
    else:
        metadata['doi'] = ''

    # Add the metadata dict to the modified_metadata_list.
    modified_metadata_list.append(metadata)

    # Write the modified metadata list to a CSV file in each loop in case the script aborts.
    modified_metadata_df = pd.DataFrame(modified_metadata_list)
    modified_metadata_df.to_csv(OUTPUT_FILENAME, index=False)
    print()

error_log_object.close()
# Print ending time
print('Ending at', pd.Timestamp.now())

print('done')
