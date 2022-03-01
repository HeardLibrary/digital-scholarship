# Freely available under a CC0 license. Steve Baskauf 2019-05-25
# See https://www.wikidata.org/w/api.php for MediaWiki API help
# For general information about MediaWiki tokens, see https://www.mediawiki.org/wiki/API:Tokens
# Tor testing new API functions, use the Wikidata test instance sandbox:
# https://test.wikidata.org/wiki/Special:ApiSandbox
# This is what I used to figure out what was going on and to see example query parameters.  You can safely write to
# https://test.wikidata.org without having to worry about messing up the real WikiData.
# Note: writing directly like this to a Wikibase API on AWS is approximately 60 times faster than pywikibot with built-in throttling

import requests

# This is the default API resource URL when a Wikibase/Wikidata instance is installed.
resourceUrl = '/w/api.php'

# Instantiate session outside of any function so that it's globally accessible.
session = requests.Session()

# See https://heardlibrary.github.io/digital-scholarship/host/wikidata/bot/#create-your-bot
# for information about creating a bot and getting its username and password.

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
def retrieveCredentials():
    with open('credentials.txt', 'rt') as fileObject:
        lineList = fileObject.read().split('\n')
    endpointUrl = lineList[0].split('=')[1]
    username = lineList[1].split('=')[1]
    password = lineList[2].split('=')[1]
    credentials = [endpointUrl, username, password]
    return credentials

# The loginToken is a random generated string associated with the session
# See example at https://www.mediawiki.org/wiki/API:Login
def getLoginToken(apiUrl):    
    parameters = {
        'action':'query',
        'meta':'tokens',
        'type':'login',
        'format':'json'
    }

    r = session.get(url=apiUrl, params=parameters)
    data = r.json()
    return data['query']['tokens']['logintoken']

# The result of this function is a successful session login.  
# See example at https://www.mediawiki.org/wiki/API:Login
def logIn(apiUrl, token, username, password):
    parameters = {
        'action':'login',
        'lgname':username,
        'lgpassword':password,
        'lgtoken':token,
        'format':'json'
    }

    r = session.post(apiUrl, data=parameters)
    data = r.json()
    # The response looks like this:
    # {'login': {'result': 'Success', 'lguserid': 4, 'lgusername': 'Baskauf'}}
    # This information isn't actually needed for anything - it's just an indication of a successful session login
    return data

# The CSRF (edit) token is an edit token that is actually used to authorize particular write actions
# It is used to prevent cross-site request forgery (csrf) attacks. I think it's primarily relevant when web forms are used
# Here's the page that shows how to get an edit token
# https://www.mediawiki.org/wiki/API:Edit
def getCsrfToken(apiUrl): # nothing gets passed in because the session instance is already authenticated
    parameters = {
        "action": "query",
        "meta": "tokens",
        "format": "json"
    }

    r = session.get(url=apiUrl, params=parameters)
    data = r.json()
    # The response looks like this:
    # {'batchcomplete': '', 'query': {'tokens': {'csrftoken': '6bc490bb0d2e78cb3f8a2b94e8159da85cdc2484+\\'}}}
    return data["query"]["tokens"]["csrftoken"]

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

# ******* main script **********
# comment out the print statements when you have confirmed that it's working
credentials = retrieveCredentials()
print('Credentials: ', credentials)
print()
url = credentials[0] + resourceUrl
user = credentials[1]
pwd = credentials[2]

loginToken = getLoginToken(url)
print('Login token: ',loginToken)
print()

data = logIn(url, loginToken, user, pwd)
print('Confirm login: ', data)
print()

csrfToken = getCsrfToken(url)
print('CSRF token: ', csrfToken)
print()

sub = 'Q188427' # the universe
prop = 'P82' #instance of
obj = 'Q1917' # cat
data = writeStatement(url, csrfToken, sub, prop, obj)
print('Write confirmation: ', data)



