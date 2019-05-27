import rdflib, urllib
from rdflib import URIRef

# here's the item to be retrieved
item = 'Q42'

# instantiate a graph to hold the downloaded triples
itemGraph=rdflib.Graph()

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
  {?s ?p2 wd:''' + item + '''}
}
'''
print(query)
url = endpointUrl + '?query=' + urllib.parse.quote(query)
print(url)

# rdflib retrieves the results, parses the triples, and adds them to the graph
result = itemGraph.parse(url)

# use rdflib functions to learn some stuff about the graph
# see https://rdflib.readthedocs.io/ for details
print('There are ', len(result), ' triples about item ', item)
adams = URIRef('http://www.wikidata.org/entity/Q42')
englishName = itemGraph.preferredLabel(adams, lang='en')
print('English name: ', englishName[0][1])
russianName = itemGraph.preferredLabel(adams, lang='ru')
print('Russian name: ', russianName[0][1])

#serialize the graph as Turtle and save it in a file
r = itemGraph.serialize(destination='rdflibOutput.ttl', format='turtle')
