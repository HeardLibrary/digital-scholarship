# Freely available under a CC0 license. Steve Baskauf 2019-05-25

# This script is built upon a more basic bot script for writing to Wikidata/Wikibase.
# It contains many more comments and returns intermediate results. 
# If how this script works isn't apparent to you, you should play with the basic script first. It's at
# https://github.com/HeardLibrary/digital-scholarship/blob/master/code/wikibase/api/write-statements.py

import requests, csv, json

# This is the default API resource URL when a Wikibase/Wikidata instance is installed.
resourceUrl = '/w/api.php'
session = requests.Session()

# -------------------------------------------------------------------
# The username and password should be in a file called credentials.txt located in the same directory as the script.
# The file should contain three lines of text formatted like this:
'''
endpointUrl=https://test.wikidata.org
username=User@bot
password=465jli90dslhgoiuhsaoi9s0sj5ki3lo
'''
# where the bot username is after the equals sign on the first line and the bot password
# is after the equals sign on the second line. Make sure there are no extraneous spaces,
# no trailing slash after the URL, and that the lines are in this exact order.
# It doesn't matter whether there is a trailing newline or not.

# authenticate() performs the authentication sequence using the credentials in the credentials.txt file 
# returns a list consisting of the CSRF token and the full API URL

def authenticate():
    # get credentials from file
    with open('credentials.txt', 'rt') as fileObject:
        lineList = fileObject.read().split('\n')
    endpointUrl = lineList[0].split('=')[1]
    username = lineList[1].split('=')[1]
    password = lineList[2].split('=')[1]
    apiUrl = endpointUrl + resourceUrl

    # get login token
    parameters = {
        'action':'query',
        'meta':'tokens',
        'type':'login',
        'format':'json'
    }
    r = session.get(url=apiUrl, params=parameters)
    data = r.json()
    loginToken =  data['query']['tokens']['logintoken']

    # perform a secure login for the session
    parameters = {
        'action':'login',
        'lgname':username,
        'lgpassword':password,
        'lgtoken':loginToken,
        'format':'json'
    }
    r = session.post(apiUrl, data=parameters)

    # get a CSRF (edit) token
    parameters = {
        "action": "query",
        "meta": "tokens",
        "format": "json"
    }
    r = session.get(url=apiUrl, params=parameters)
    data = r.json()
    csrfToken = data["query"]["tokens"]["csrftoken"]
    return [csrfToken, apiUrl]

# -------------------------------------------------------------------
# read in a CSV file as a list of dictionaries
def readDict(filename):
    fileObject = open(filename, 'r', newline='', encoding='utf-8')
    dictObject = csv.DictReader(fileObject)
    dictList = []
    for row in dictObject:
        dictList.append(row)
    fileObject.close()
    return dictList

# -------------------------------------------------------------------
# pass in the local names including the initial letter as strings, e.g. ('Q3345', 'P6', 'Q1917')
def writeStatement(apiUrl, editToken, subjectQNumber, propertyPNumber, objectQNumber):
    strippedQNumber = objectQNumber[1:len(objectQNumber)] # remove initial "Q" from object string
    parameters = {
        'action':'wbcreateclaim',
        'format':'json',
        'entity':subjectQNumber,
        'snaktype':'value',
        'bot':'1',  # not sure that this actually does anything
        'token': editToken,
        'property': propertyPNumber,
        # note: the value is a string, not an actual data structure.  I think it will get URL encoded by requests before posting
        'value':'{"entity-type":"item","numeric-id":' + strippedQNumber+ '}'
    }
    r = session.post(apiUrl, data=parameters)
    data = r.json()
    return data

# -------------------------------------------------------------------
# create an entity and return the Q identifier assigned to it
# A list of labels to be assigned to the new entity is passed into the createEntity() function as listOfLabels.
# It is a list of dictionaries, with each dictionary containing values for 'language' and 'string', like this:
'''
listOfLabels = [
    {'language': 'en', 'string': 'Fred Pig'}, 
    {'language': 'es', 'string': 'Puerco Frederico'}
    ]
'''
# The listOfDescriptions has the same format.

def createEntity(apiUrl, editToken, listOfLabels, listOfDescriptions):
    # the data passed to the API must be JSON in string form.  Because of Python's use of curly braces in format strings, it's
    # best to create the data to be passed as a dictionary, then use json.dumps to convert it into string form. 
    # Here's what we are building:
    '''
    dataDict = {
        "labels":{
            "en":{"language":"en","value":"Fred Pig"},
            "es":{"language":"es","value":"Puerco Frederico"}
            },
        "descriptions":{
            "en":{"language":"en","value":"a fake superhero character"}
            }
        }
    '''
    dataDict = {}

    innerDict = {}
    for label in listOfLabels:
        innerDict[label['language']] = {"language": label['language'], "value": label['string']}
    dataDict['labels'] =  innerDict

    innerDict = {}
    for description in listOfDescriptions:
        innerDict[description['language']] = {"language": description['language'], "value": description['string']}
    dataDict['descriptions'] =  innerDict

    dataString = json.dumps(dataDict)
    parameters = {
        'action': 'wbeditentity',
        'format': 'json',
        'new': 'item',
        'token': editToken,
        # note: the data value is a string.  I think it will get URL encoded by requests before posting
        'data': dataString
    }
    r = session.post(apiUrl, data=parameters)
    response = r.text
    if response[2:7] == 'error':
        print(r.response)
        return "error"
    else:
        data = r.json()
        return data["entity"]["id"]

# ******* main script **********
loginInfo = authenticate()
csrfToken = loginInfo[0]
apiUrl = loginInfo[1]
print()

# The list of properties to be assigned must correspond to column headers in the CSV file
# The properties and values (if items) must already have been created
propertyList = ['P6', 'P9']

# assumes source file is in the same directory as script. Use full or relative path if not.
sourceCsvFile = 'cartoons.csv'
listOfItems = readDict(sourceCsvFile)

for item in listOfItems:
    # print(item)
    labelList = [
        {'language': 'en', 'string': item['enLabel']}, 
        {'language': 'es', 'string': item['esLabel']}
        ]
    descriptionList = [
        {'language': 'en', 'string': item['enDescription']}
        ]
    idOfNewEntity = createEntity(apiUrl, csrfToken, labelList, descriptionList)
    if idOfNewEntity != 'error':
        print("created item: " + item['enLabel'])
        print("assigned ID: " + idOfNewEntity)
        
        # step through each property in the property list and add a claim about the newly created entity
        for prop in propertyList:
            sub = idOfNewEntity
            obj = item[prop]
            data = writeStatement(apiUrl, csrfToken, sub, prop, obj)
            if data['success'] == 1:
                print('added claim for: ' + prop)
            else:
                print('failed to add claim for: ' + prop)

    print()
