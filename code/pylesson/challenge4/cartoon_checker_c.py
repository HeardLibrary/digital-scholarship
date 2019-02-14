import csv
import requests
from tkinter import *
from tkinter import ttk
import tkinter.scrolledtext as tkst

# User interface setup

# this sets up the characteristics of the window
root = Tk()
root.title("Latte maker")
mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

#set up array of labels, text entry boxes, and buttons
firstLabel = StringVar()
ttk.Label(mainframe, textvariable=firstLabel).grid(column=3, row=3, sticky=(W, E))
firstLabel.set('Enter all or part of character name: ')
firstInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
firstInputBox.grid(column=4, row=3, sticky=W)
firstInputBox.insert(END, 'George Jetson')

#set up action buttons
makeLatteButton = ttk.Button(mainframe, text = "Search for character", width = 30, command = lambda: getData() )
makeLatteButton.grid(column=4, row=15, sticky=W)

surpriseMeButton = ttk.Button(mainframe, text = "Look up on Wikidata", width = 30, command = lambda: printWikiData() )
surpriseMeButton.grid(column=4, row=16, sticky=W)

scrollingTextBox = tkst.ScrolledText(master=mainframe, width=100, height=20)
scrollingTextBox.grid(column=4, row=17, padx=8, pady=8)
#scrollingTextBox.insert(END, 'Search results:\n\n')

def getArray():
    # To use a local file, comment out this part, and uncomment the next part
    r = requests.get('https://github.com/HeardLibrary/digital-scholarship/raw/master/code/pylesson/challenge4/cartoons.csv')
    fileText = r.text.split('\n')
    if fileText[len(fileText)-1] == '':
        fileText = fileText[0:len(fileText)-1]
    readerObject = csv.DictReader(fileText)
    cartoon = []
    for row in readerObject:
        cartoon.append(row)

    '''
    fileObject = open('cartoons.csv', 'r', newline='', encoding='utf-8')
    readerObject = csv.DictReader(fileObject)
    cartoon = []
    for row in readerObject:
        cartoon.append(row)
    fileObject.close()
    '''
    return cartoon

def getWikidata(characterId):
    endpointUrl = 'https://query.wikidata.org/sparql'
    query = '''select distinct ?property ?value
    where {
      <''' + characterId + '''> ?propertyUri ?valueUri.
      ?valueUri <http://www.w3.org/2000/01/rdf-schema#label> ?value.
      ?genProp <http://wikiba.se/ontology#directClaim> ?propertyUri.
      ?genProp <http://www.w3.org/2000/01/rdf-schema#label> ?property.
      FILTER(substr(str(?propertyUri),1,36)="http://www.wikidata.org/prop/direct/")
      FILTER(LANG(?property) = "en")
      FILTER(LANG(?value) = "en")  
    }'''

    # The endpoint defaults to returning XML, so the Accept: header is required
    r = requests.get(endpointUrl, params={'query' : query}, headers={'Accept' : 'application/json'})
    data = r.json()
    statements = data['results']['bindings']
    return statements

def getData():
    inputCharacterName = firstInputBox.get()
    cartoon = getArray()

    found = False
    for characterIndex in range(1, len(cartoon)):
        if inputCharacterName.lower() in cartoon[characterIndex]['name'].lower(): 
            found = True
            responseString = '\n' + cartoon[characterIndex]['name'] + ' works for ' + cartoon[characterIndex]['company'] + '.'
            if cartoon[characterIndex]['nemesis'] != '':
                responseString += ' Its enemy is ' + cartoon[characterIndex]['nemesis']
            scrollingTextBox.insert(END, responseString + '\n')
            scrollingTextBox.see(END)
            
    if not found:
        print("Didn't find that character")
        scrollingTextBox.insert(END, "Didn't find that character\n")
        scrollingTextBox.see(END)

def printWikiData():
    inputCharacterName = firstInputBox.get()
    cartoon = getArray()

    found = False
    for characterIndex in range(1, len(cartoon)):
        if inputCharacterName.lower() in cartoon[characterIndex]['name'].lower(): 
            found = True
            wikidataText = '\n' # skip 1 line
            wikidataText += "Here's what WikiData knows about " + cartoon[characterIndex]['name'] + ':\n'
            statements = getWikidata(cartoon[characterIndex]['wikidataId'])
            for statement in statements:
                wikidataText += statement['property']['value'] + ': ' + statement['value']['value'] + '\n'
            scrollingTextBox.insert(END, wikidataText + '\n')
            scrollingTextBox.see(END)
    if not found:
        print("Didn't find that character")
        scrollingTextBox.insert(END, "Didn't find that character\n")
        scrollingTextBox.see(END)


def main():
    root.mainloop()
    
if __name__=="__main__":
    main()