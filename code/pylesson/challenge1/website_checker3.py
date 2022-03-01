# modules for GUI interface
import tkinter
from tkinter import *
from tkinter import ttk

# module to make HTTP requests
import requests

# User interface setup

# this sets up the characteristics of the window
root = Tk()
root.title("Web Page Status Checker")
mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

#set up array of labels, text entry boxes, and buttons
firstLabel = StringVar()
ttk.Label(mainframe, textvariable=firstLabel).grid(column=3, row=3, sticky=(W, E))
firstLabel.set('Web page URL:')
firstInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
firstInputBox.grid(column=4, row=3, sticky=W)
firstInputBox.insert(END, 'http://bioimages.vanderbilt.edu/baskauf/24319.rdf')

#set up action button
def checkWebsiteButtonClick():
    checkWebsite()
doSomethingButton = ttk.Button(mainframe, text = "Check web page", width = 30, command = lambda: checkWebsiteButtonClick() )
doSomethingButton.grid(column=4, row=15, sticky=W)

# ------------------------------------------------------------------------------------------
# Function definitions

def checkWebsite():  # This is the function that is invoked when the Do Something button is clicked
    url = firstInputBox.get()
    # test with:
    # http://bioimages.vanderbilt.edu/baskauf/24319.rdf
    # http://bioimages.vanderbilt.edu/baskauf/24319.xdf
    # https://www.google.com/teapot

    r = requests.get(url)
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

def main():
    root.mainloop()
    
if __name__=="__main__":
    main()