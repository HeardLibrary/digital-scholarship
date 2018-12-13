import requests   # best library to manage HTTP transactions
import csv # library to read/write/parse CSV files
from bs4 import BeautifulSoup # web-scraping library

acceptMime = 'text/html'

cikList = []
cikPath = 'cik.txt'
cikFileObject = open(cikPath, newline='')
cikRows = cikFileObject.readlines()

for cik in cikRows:
    cikList.append(cik.strip())

# create a list of dictionaries for appropriate results
resultsList = []
for cik in cikList:
    # this query string selects for 10-K forms, but also retrieves forms whose code start with 10-K
    baseUri = 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK='+cik+'&type=10-K&dateb=&owner=exclude&start=0&count=40&output=atom'
    print(baseUri)
    r = requests.get(baseUri, headers={'Accept' : 'application/xml'})
    soup = BeautifulSoup(r.text,features="html5lib")
    # this search string limits results to only category elements with the attribute that's exactly equal to"10-K"
    # the select function returns a list of soup objects that can each be searched
    for cat in soup.select('category[term="10-K"]'):
        # can't use cat.filing-href because hyphen in tag is interpreted by Python as a minus
        # also, couldn't get .strings to work, so used first child element (the string content of the tag)
        date = cat.find('filing-date').contents[0]
        year = date[:4]
        print(year)
        # create a dictionary of an individual result
        searchResults = {'cik':cik,'year':year,'uri':cat.find('filing-href').contents[0]}
        if year <= "2018" and year >= "2015":
            # append the dictionary to the list of results
            resultsList.append(searchResults)
print(resultsList)

form10kList = []
#for hitNumber in range(0,1):  #for do only one hit for testing purposes
for hitNumber in range(0,len(resultsList)):
    print(hitNumber)
    r = requests.get(resultsList[hitNumber]['uri'], headers={'Accept' : 'text/html'})
    soup = BeautifulSoup(r.text,features="html5lib")
    for row in soup.select('tr'):
        is10k = False
        for cell in row.select('td'):
            try:
                testString = cell.contents[0]
                if cell.contents[0] == "10-K":
                    is10k = True
            except:  # handle error caes where the cell doesn't have contents
                pass
        if is10k:
            form10kList.append('http://www.sec.gov' + row.a.get('href'))

print(form10kList)

#for form10kNumber in range(0,1):
for form10kNumber in range(0,len(form10kList)):
    print(form10kNumber)
    r = requests.get(form10kList[form10kNumber], headers={'Accept' : 'text/html'})
    soup = BeautifulSoup(r.text,features="html5lib")
    for row in soup.select('tr'):
        hasSlashS = False
        for cell in row.select('font'):
            try:
                testString = cell.contents[0]
                if "/s/" in cell.contents[0]:
                    hasSlashS = True
            except:  # handle error caes where the cell doesn't have contents
                pass
        if hasSlashS:
            tableItems = row.select('font')
            if len(tableItems)>=5:
                noLeft = tableItems[2].contents[0].replace('(','')
                cleanName = noLeft.replace(')','')
                print(cleanName)
                print(tableItems[4].contents[0])


