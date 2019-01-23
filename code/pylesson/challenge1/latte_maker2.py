#modules for GUI interface
import tkinter
from tkinter import *
from tkinter import ttk

#module for random functions
import random

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
firstLabel.set('beans (decaf, regular, or dark roast)')
firstInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
firstInputBox.grid(column=4, row=3, sticky=W)
firstInputBox.insert(END, 'regular')

secondLabel = StringVar()
ttk.Label(mainframe, textvariable=secondLabel).grid(column=3, row=4, sticky=(W, E))
secondLabel.set('milk (whole, skim, or soy)')
secondInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
secondInputBox.grid(column=4, row=4, sticky=W)
secondInputBox.insert(END, 'soy')

thirdLabel = StringVar()
ttk.Label(mainframe, textvariable=thirdLabel).grid(column=3, row=5, sticky=(W, E))
thirdLabel.set('flavor (vanilla, pumpkin spice, or none)')
thirdInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
thirdInputBox.grid(column=4, row=5, sticky=W)
thirdInputBox.insert(END, 'vanilla')

fourthLabel = StringVar()
ttk.Label(mainframe, textvariable=fourthLabel).grid(column=3, row=6, sticky=(W, E))
fourthLabel.set('water (yes or no)')
fourthInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
fourthInputBox.grid(column=4, row=6, sticky=W)
fourthInputBox.insert(END, 'yes')

#set up action buttons
def makeLatteButtonClick():
    useTextBoxes()
makeLatteButton = ttk.Button(mainframe, text = "Make Latte", width = 30, command = lambda: makeLatteButtonClick() )
makeLatteButton.grid(column=4, row=15, sticky=W)

def surpriseMeButtonClick():
    useRandomIngrediants()
surpriseMeButton = ttk.Button(mainframe, text = "Surprise Me!", width = 30, command = lambda: surpriseMeButtonClick() )
surpriseMeButton.grid(column=4, row=16, sticky=W)

# ------------------------------------------------------------------------------------------
# Function definitions

def makeLatte(beans, milk, extras, water):
    if water == 'yes':
        if beans == 'decaf':
            beanAdjective = 'decaf'
        elif beans == 'regular':
            beanAdjective = 'regular'
        elif beans == 'dark roast':
            beanAdjective = 'dark'
        else:
            beanAdjective = 'bean unavailable'

        if milk == 'whole':
            milkAdjective = 'fat'
        elif milk == 'skim':
            milkAdjective = 'skinny'
        elif milk == 'soy':
            milkAdjective = 'vegan'
        else:
            milkAdjective = 'milk unavailable'

        if extras == 'none':
            extraAdjective = ''
        elif extras == 'pumpkin spice':
            extraAdjective = 'pumpkin spice'
        elif extras == 'vanilla':
            extraAdjective = 'vanilla'
        else:
            extraAdjective = 'flavor unavailable'
        euphamism = beanAdjective + ' ' + milkAdjective + ' ' + extraAdjective + " latte"
    else:
        euphamism = 'Sorry, the latte machine is broken!'

    return euphamism

def useTextBoxes():  # This is the function that is invoked when the Make Latte button is clicked
    bean = firstInputBox.get()
    milk = secondInputBox.get()
    extras = thirdInputBox.get()
    water = fourthInputBox.get()

    myLatte = makeLatte(bean, milk, extras, water)
    print(myLatte)

def useRandomIngrediants():  # This is the function that is invoked when the Surprise Me! button is clicked
    beanList = ['decaf', 'regular', 'dark roast']
    milkList = ['whole', 'skim', 'soy']
    extrasList = ['none', 'pumpkin spice', 'vanilla']

    myLatte = makeLatte(random.choice(beanList), random.choice(milkList), random.choice(extrasList), 'yes')
    print(myLatte)

def main():
    root.mainloop()
    
if __name__=="__main__":
    main()