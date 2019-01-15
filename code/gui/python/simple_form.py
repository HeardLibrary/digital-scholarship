#libraries for GUI interface
import tkinter
from tkinter import *
from tkinter import ttk

# User interface setup

# this sets up the characteristics of the window
root = Tk()
root.title("Graphical interface for input")
mainframe = ttk.Frame(root, padding="3 3 12 12")
mainframe.grid(column=0, row=0, sticky=(N, W, E, S))
mainframe.columnconfigure(0, weight=1)
mainframe.rowconfigure(0, weight=1)

#set up array of labels, text entry boxes, and buttons
firstLabel = StringVar()
ttk.Label(mainframe, textvariable=firstLabel).grid(column=3, row=3, sticky=(W, E))
firstLabel.set('Here is the first box')
firstInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
firstInputBox.grid(column=4, row=3, sticky=W)
firstInputBox.insert(END, 'default text for first box')

secondLabel = StringVar()
ttk.Label(mainframe, textvariable=secondLabel).grid(column=3, row=4, sticky=(W, E))
secondLabel.set('Here is the second box')
secondInputBox = ttk.Entry(mainframe, width = 60, textvariable = StringVar())
secondInputBox.grid(column=4, row=4, sticky=W)
secondInputBox.insert(END, 'default text for second box')


#set up action button
def doSomethingButtonClick():
	doTheThing()
doSomethingButton = ttk.Button(mainframe, text = "Do Something", width = 30, command = lambda: doSomethingButtonClick() )
doSomethingButton.grid(column=4, row=15, sticky=W)

# ------------------------------------------------------------------------------------------
# Function definitions

def doTheThing():  # This is the function that is invoked when the Do Something button is clicked
    print(firstInputBox.get())
    print(secondInputBox.get())


def main():	
	root.mainloop()
	
if __name__=="__main__":
	main()
