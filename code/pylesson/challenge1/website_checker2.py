import requests

# test with:
# http://bioimages.vanderbilt.edu/baskauf/24319.rdf
# http://bioimages.vanderbilt.edu/baskauf/24319.xdf
# https://www.google.com/teapot

r = requests.get('http://bioimages.vanderbilt.edu/baskauf/24319.rdf')
responseCode = r.status_code

if responseCode == 200:
    print('The web page is up!')
elif responseCode == 301:
    print('The web page moved permanently. Response code: 301.')
elif responseCode == 302:
    print('The web page was found, but moved temporarily. Response code: 302.')
elif responseCode == 303:
    print('The web page moved permanently. Response code: 303.')
elif responseCode == 403:
    print('Forbidden. You probably need access rights. Response code: 403.')
elif responseCode == 404:
    print('The web page was not found. Response code: 404.')
# IETF April Fool's joke !
elif responseCode == 418:
    print('The web page is a teapot. Seriously! Response code: 418.')
elif responseCode == 500:
    print('Internal server error. Response code: 500.')
elif responseCode == 501:
    print('Not implemented by the server. Response code: 501.')
else:
    print('Something unusual is going on! Response code: ')
    print(responseCode)
