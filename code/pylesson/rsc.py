import requests

# Part 1: Present choices
print('Type f for formula, w for molecular mass, c for common name, and 3 for 3D structure')
optionString = input('Enter up to four characters for the options you want: ')
print('You entered: ', optionString)

# Part 2: Check whether the user typed anything
if optionString == '':
    print('No options chosen!')
    quit()
compound = input('Enter the name of the compound: ')
if compound == '':
    print('No compound entered!')
    quit()

print('Compound entered: ', compound)
print('Options chosen: ', optionString)

# Part 3: Create the list of fields to return
fieldGetList = []
optionList = ['f', 'w', 'c', '3']
fieldList = ['Formula', 'MolecularWeight', 'CommonName', 'Mol3D']
for index in range(0,len(optionList)):
    if optionList[index] in optionString:
        fieldGetList.append(fieldList[index])
print(fieldGetList)

# Part 4: Create the JSON to send to the API for the name search
dataDict = {
    "name": compound,
    "orderBy": "",
    "orderDirection": ""
}

print(dataDict['name'])

# Part 5: Sending the first search request (POST) to the API
key = 'k0G8CqhdclhPd04BA1cFmWgOS2EgEMa5'
searchUrl = 'https://api.rsc.org/compounds/v1/filter/name'
r = requests.post(searchUrl, headers={'apikey' : key}, json = dataDict)
responseData = r.json()
print('response: ', responseData)
queryIdString = responseData['queryId']

# Part 6: Sending the second request (GET) to retrieve the search results
resultsGetUrl = 'https://api.rsc.org/compounds/v1/filter/' + queryIdString + '/results'
r = requests.get(resultsGetUrl, headers={'apikey' : key})
data = r.json()
print('response: ', data)
resultsList = data['results']
compoundIdNumber = resultsList[0]

# Part 7: Sending the third request (GET) to retrieve the compound data fields
joinedList = ','.join(fieldGetList)
print(joinedList)
detailsGetUrl = 'https://api.rsc.org/compounds/v1/records/' + str(compoundIdNumber) +'/details'
r = requests.get(detailsGetUrl, headers={'apikey' : key}, params={'fields': joinedList})
data = r.json()
print('response: ', data)

# Part 8: Print the final results
for field in data:
    print(field, data[field])
