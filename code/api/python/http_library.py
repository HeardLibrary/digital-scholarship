import requests   # best library to manage HTTP transactions
import csv        # library to read/write/parse CSV files
import json       # library to convert JSON to Python data structures

# performs a generic HTTP GET
def httpGet(baseUri,acceptMime):
    if acceptMime == '':
        acceptMime = '*.*'                         # if no mime type specified, accept anything
    headerDict = {'Accept' : acceptMime}           # headers are sent as a dictionary
    r = requests.get(baseUri, headers=headerDict)
    return [r.status_code, r.text]                 # status code is an integer, response body is a string

# requests tabular data from an API and returns a table consisting of a list of lists.  If GET fails, the list is empty
def retrieveData(baseUri, responseType, param1):    # For CSV, param1 is the delimiter character.  For JSON, param1 is the key of the data array.
    if responseType == 'csv':
        acceptMime = 'text/csv'
    elif responseType == 'json':
        acceptMime = 'application/json'
    elif responseType == 'xml':
        acceptMime = 'text/xml'
    else:
        acceptMime = '*.*'

    response = httpGet(baseUri, acceptMime)
    table = list()                                 # create an empty table
    if response[0] == 200:                         # process data only if GET is successful

        if responseType == 'csv':
            tableRows = response[1].split('\n')    # split the response string into lines at the newline character to make a list
            tableReader = csv.reader(tableRows, delimiter=param1, quotechar='"')  # csv.reader can operate on any iteratible object including a list
            for row in tableReader:                # need to convert the _csv.reader object into an actual list
                if len(row) != 0:
                    table.append(row)
                    
        if responseType == 'json':
            responseDict = json.loads(response[1]) # response string converted to a dictionary
            dataArray = responseDict[param1]       # param1 is the key of the dictionary item that contains the data array
            aggregationDict = {}
            for item in dataArray:                 # this loop updates a dictionary with every dictionary in the data array, resulting in a dictionary that conatins all keys used in any of the individual dictionaries
                aggregationDict.update(item)
            keyList = list(aggregationDict.keys()) # now generate a list of all of the keys that were found
            table.append(keyList)                  # create the header list (item 0 in list of lists)
            for item in dataArray:                 # step through each of the dictionaries in the data array and find the value for each key in the key list
                tableRowList = list()
                for key in keyList:
                    try:                           # need to error trap the case where a dictionary is missing one of the keys
                        tableRowList.append(item[key])
                    except:
                        tableRowList.append('')
                table.append(tableRowList)
            
        return table                               # returns a table consisting of a list of rows that consist of a list of fields

