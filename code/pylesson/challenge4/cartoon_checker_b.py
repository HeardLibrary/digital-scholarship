import csv
import requests

def getArray():
    # To use a local file, comment out this part, and uncomment the next part
    r = requests.get('https://github.com/HeardLibrary/digital-scholarship/raw/master/code/pylesson/challenge4/cartoons.csv')
    fileText = r.text.split('\n')
    if fileText[len(fileText)-1] == '':
        fileText = fileText[0:len(fileText)-1]
    readerObject = csv.DictReader(fileText)
    cartoon = []
    for row in readerObject:
        cartoon.append(row)

    '''
    fileObject = open('cartoons.csv', 'r', newline='', encoding='utf-8')
    readerObject = csv.DictReader(fileObject)
    cartoon = []
    for row in readerObject:
        cartoon.append(row)
    fileObject.close()
    '''
    return cartoon

def getWikidata(characterId):
    endpointUrl = 'https://query.wikidata.org/sparql'
    query = '''select distinct ?property ?value
    where {
      <''' + characterId + '''> ?propertyUri ?valueUri.
      ?valueUri <http://www.w3.org/2000/01/rdf-schema#label> ?value.
      ?genProp <http://wikiba.se/ontology#directClaim> ?propertyUri.
      ?genProp <http://www.w3.org/2000/01/rdf-schema#label> ?property.
      FILTER(substr(str(?propertyUri),1,36)="http://www.wikidata.org/prop/direct/")
      FILTER(LANG(?property) = "en")
      FILTER(LANG(?value) = "en")  
    }'''

    # The endpoint defaults to returning XML, so the Accept: header is required
    r = requests.get(endpointUrl, params={'query' : query}, headers={'Accept' : 'application/json'})
    data = r.json()
    statements = data['results']['bindings']
    return statements

# Main routine
cartoon = getArray()
inputCharacterName = input("What's the name of the character? ")

found = False
for characterIndex in range(1, len(cartoon)):
    if inputCharacterName.lower() in cartoon[characterIndex]['name'].lower(): 
        found = True
        print('\n') # skip 2 lines
        responseString = cartoon[characterIndex]['name'] + ' works for ' + cartoon[characterIndex]['company'] + '.'
        if cartoon[characterIndex]['nemesis'] != '':
            responseString += ' Its enemy is ' + cartoon[characterIndex]['nemesis']
        print(responseString)
        
        # Here's where we get the data from the WikiData API
        print() # skip 1 line
        print("Here's what WikiData knows about " + cartoon[characterIndex]['name'] + ':')
        statements = getWikidata(cartoon[characterIndex]['wikidataId'])
        for statement in statements:
            print(statement['property']['value'] + ': ' + statement['value']['value'])
if not found:
    print("Didn't find that character")