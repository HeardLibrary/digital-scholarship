import requests

r = requests.get('http://bioimages.vanderbilt.edu/baskauf/24319.rdf')
print('HTTP status code: ', r.status_code)
# print(r.text)
