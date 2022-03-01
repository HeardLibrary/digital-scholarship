import requests

isoLanguage = input('Enter the code of the language you want: ')
if isoLanguage == '':
    isoLanguage = 'en'

# construct the URL for the HTTP GET call
endpointUrl = 'https://query.wikidata.org/sparql'
query = '''
PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
PREFIX wd: <http://www.wikidata.org/entity/>
PREFIX wdt: <http://www.wikidata.org/prop/direct/>
SELECT DISTINCT ?name ?iri WHERE {
?iri wdt:P106 wd:Q188784.
?iri wdt:P1080 wd:Q931597.
?iri rdfs:label ?name.
FILTER(lang(?name)="''' + isoLanguage + '''")
}
ORDER BY ASC(?name)
'''
print(query)

# The endpoint defaults to returning XML, so the Accept: header is required.
# application/sparql-results+json is the official Internet Media Type for JSON results.
# However, endpoints typically will also respond to application/json
r = requests.get(endpointUrl, params={'query' : query}, headers={'Accept' : 'application/sparql-results+json'})
#r = requests.post(endpointUrl, data=query, headers={'Content-Type': 'application/sparql-query', 'Accept' : 'application/sparql-results+json'})

print(r.url)
print()
#print(r.text)

resultsList = r.json()['results']['bindings']
for result in resultsList:
    name = result['name']['value']
    iri = result['iri']['value']
    print(iri, ': ', name)
