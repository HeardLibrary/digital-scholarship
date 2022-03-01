# see https://www.wikidata.org/w/api.php for MediaWiki API help

import requests

# endpointUrl = 'https://test.wikidata.org' # use for the Wikidata test instance
endpointUrl = 'https://www.wikidata.org'
print('You can try this with the "Pleasant View", which is Q2800895.')
print('Check out https://www.wikidata.org/wiki/Q2800895 to see the GUI.')
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
        try:
            # print Q ID if the value is an item
            print('value: ', value['mainsnak']['datavalue']['value']['id'])
        except:
            try:
                # print the string value if the value is a literal
                print('value: ', value['mainsnak']['datavalue']['value'])
            except:
                # print the whole snak if the value is something else
                print('value: ', value['mainsnak'])
    print()