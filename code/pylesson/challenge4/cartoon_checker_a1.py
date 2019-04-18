import csv
import requests

r = requests.get('https://github.com/HeardLibrary/digital-scholarship/raw/master/code/pylesson/challenge4/cartoons.csv')
fileText = r.text.split('\n')
fileRows = csv.DictReader(fileText)
cartoon = []
for row in fileRows:
    cartoon.append(row)

inputCharacterName = input("What's the name of the character? ")

found = False
for characterIndex in range(1, len(cartoon)):
    if inputCharacterName.lower() in cartoon[characterIndex]['name'].lower(): 
        found = True
        responseString = cartoon[characterIndex]['name'] + ' works for ' + cartoon[characterIndex]['company'] + '.'
        if cartoon[characterIndex]['nemesis'] != '':
            responseString += ' Its enemy is ' + cartoon[characterIndex]['nemesis']
        print(responseString)
if not found:
    print("Didn't find that character")
