#modules for GUI interface
import tkinter
from tkinter import *
from tkinter import ttk

# User interface setup

# this sets up the characteristics of the window
root = Tk()
root.title("Disney Checker")
mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

#set up array of labels, text entry boxes, and buttons
firstLabel = StringVar()
ttk.Label(mainframe, textvariable=firstLabel).grid(column=3, row=3, sticky=(W, E))
firstLabel.set('Character')
firstInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
firstInputBox.grid(column=4, row=3, sticky=W)
firstInputBox.insert(END, 'type name here')

#set up action button
def checkCharacterButtonClick():
    checkName()
doSomethingButton = ttk.Button(mainframe, text = "Check character", width = 30, command = lambda: checkCharacterButtonClick() )
doSomethingButton.grid(column=4, row=15, sticky=W)

# ------------------------------------------------------------------------------------------
# Function definitions

def checkName():  # This is the function that is invoked when the Do Something button is clicked
    name = firstInputBox.get()
    print(name)
    if name == 'Mickey Mouse':
        print('You are a Disney character')
        print('You are a mouse')
    elif name == 'Donald Duck':
        print('You are a Disney character')
        print('You are not a mouse')
    elif name == 'Minnie Mouse':
        print('You are a Disney character')
        print('Your boyfriend is getting old')
    else:
        print('You are not a Disney character')
    print("That's all folks!")

def main():
    root.mainloop()
    
if __name__=="__main__":
    main()