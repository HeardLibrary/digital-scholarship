import requests

# here's the item to be retrieved
item = 'Q42'

# construct the URL for the HTTP GET call
endpointUrl = 'https://query.wikidata.org/sparql'
query = '''
PREFIX wd: <http://www.wikidata.org/entity/>
CONSTRUCT {
  wd:''' + item + ''' ?p1 ?o.
  ?s ?p2 wd:''' + item + '''.
}
WHERE {
  {wd:''' + item + ''' ?p1 ?o.}
  UNION
  {?s ?p2 wd:''' + item + '''.}
}
'''
print(query)

# The endpoint defaults to returning XML, so the Accept: header is required
r = requests.get(endpointUrl, params={'query' : query}, headers={'Accept' : 'text/turtle'})
#r = requests.post(endpointUrl, data=query, headers={'Content-Type': 'application/sparql-query', 'Accept' : 'text/turtle'})
print(r.url)

with open('requestsOutput.ttl', 'wt', encoding='utf-8') as fileObject:
    fileObject.write(r.text)

