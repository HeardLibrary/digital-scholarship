# see https://www.wikidata.org/w/api.php for MediaWiki API help

import requests

endpointUrl = 'https://test.wikidata.org'
print('You can try this with the "Universe", which is Q188427.')
print('Check out https://test.wikidata.org/wiki/Q188427 to see the GUI.')
entity = input("What's the Q number (including the 'Q')? ")
resourceUrl = '/w/api.php?action=wbgetclaims&format=json&entity='+entity
uri = endpointUrl + resourceUrl
r = requests.get(uri)
data = r.json()
claims = data['claims']
print('subject: ', entity)
print()
for property, values in claims.items():
    print('property: ', property)
    for value in values:
        print('value: ', value['mainsnak']['datavalue']['value']['id'])
    print()
