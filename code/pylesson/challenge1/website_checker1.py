import requests

r = requests.get('http://bioimages.vanderbilt.edu/baskauf/2431')
responseCode = r.status_code

if responseCode == 200:
    print('The web page is up!')
else:
    print('The web page is down with response code: ')
    print(responseCode)
