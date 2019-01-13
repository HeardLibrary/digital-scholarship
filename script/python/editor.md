---
permalink: /script/python/editor/
title: Using a code editor
breadcrumb: Editor
---

# Using a code editor to write Python

# Chosing a code editor

There are many excellent free code editors available that can help you more easily create Python scripts.  Some of them are described at the [Guru99 website](https://www.guru99.com/best-free-code-editors-windows-mac.html).  Two will be mentioned here: Atom and Visual Studio Code (not part of Microsoft’s Visual Studio IDE).  They are not necessarily better than all the others, but we have experience with them and can recommend them.  Both editors are available for Mac, Windows, and Linux, so if you get used to one, you can continue to use it if you change platforms at some time in the future.

## Syntax highlighting

All good code editors provide syntax highlighting based on the particular programming language of the file you are editing.  Editors generally figure out the language you are using from the file extension of the file. So if you open a file that has the extension .py (the usual file extension for Python scripts), the editor will provide highlighting specifically for Python.  If you open a new file and start typing, the editor will not know what kind of highlighting to use until the first time you save the file.  So usually, you will want to save the file (with the .py extension) as soon as you start writing the code.  

Here's what syntax highlighting looks like in Atom for a Python script:

<img src="../images/atom-highlighting.png" style="border:1px solid black">

Here's what the syntax highlighting looks like for the same script in Visual Studio Code:

<img src="../images/code-highlighting.png" style="border:1px solid black">

## Indentation!

An important feature of the Python language is that indentation is the primary means for designating structure in the program.  That is in contrast to other languages where characters such as curly brackets (`{ }`) are used to demarcate code blocks.  

The standard for Python is to indent code blocks four space characters.  However, the Python interpreter will allow any kind of indentation, as long as it is consistent within a block of code.  Unfortunately, it is possible to mix indintations using tab characters with indentations using multiple spaces with the two looking similar visually, but causing an error when the code is run.  

Fortunately, both Atom and Visual Studio Code are pretty smart about dealing with indentation.  When a file is opened, they detect whether the indentations were made consistently with tabs or spaces.  When the tab key is pressed they match the kind of character that was previously used in that file, inserting a tab character if tabs were previously used and inserting spaces if spaces were previously used.  They also will match the characters used in the previous line when auto-indenting after you press the return/enter key.  In a new Python file, pressing the tab key will automatically default to the preferred four spaces per indent.

If you have used a "dumb" editor to edit a script with inconsistent use of tabs and spaces, Atom and Code can't help you with that.  So it's best to start using a "smart" editor from the start.

## Pros and cons of the editors

Atom has a nice build-in Markdown previewer.  You can also install a package that enables GitHub integration within the editor.  (Atom was created by the GitHub people.) However, Atom also has an annoying navigator pane that sometimes appears when it opens (but can easily be closed by `Ctrl \`).

When editing Python, V.S. Code makes faint guidelines to make the indentation levels more apparent (see the screenshot above).  This can be helpful in long scripts.  It also shows a miniature view of the whole script at the right side of the screen, and you can click and drag on it to move rapidly through the script.  

Both editors have autocomplete features, which can be awesome or annoying depending on what you like.

# Installing the code editor

To install Visual Studio Code, go to <https://code.visualstudio.com/>.  You browser should detect your operating systme and suggest the correct download for it.

To install Atom, go to <https://atom.io/>.  You browser should detect your operating systme and suggest the correct download for it.

# Workflow for editing and testing Python code

1\. Start up your code editor and open a new window.

2\. Type or paste this code into the window:

```
number = 5
divisor = 6
print(number/divisor)
```

It should look something like this:

<img src="../images/code-snippet.png" style="border:1px solid black">

Notice that there's no syntax highlighting because the editor doesn't know what kind of file it is yet.

3\. We need to save this script as a file in a place where we can find it using the command line console.  The easiest way to accomplish this is to save the file in your user home directory.  

3a. Windows: In the Save As dialog, navigate to your hard drive (usually c:), then the Users directory, then the directory named after your username

<img src="../images/save-as-windows.png" style="border:1px solid black">

When you have navigated to your home directory, select Python as the file type and name the file `divide_numbers.py`.  

*Note: in Python, it is best not to use hyphens to separate words in file names. It's better to use underscores for that purpose.  Do not leave spaces in the file names, either.*

3b. Mac: In the Save As dialog, ...

4\. You should now see Python syntax highlighting (colored text) in the code editor:

<img src="../images/code-snippet-highlighted.png" style="border:1px solid black">

5\. Open the appropriate console for your operating system (Command Prompt for Windows or Terminal for Mac).  If you don't know how to do that, see [these instructions for mac](../install/#starting-python-on-a-mac) or [these instructions for Windows](../install/#starting-python-on-windows)).  However, do not launch the Python shell.  (If you do launch it accidentally, enter `quit()` to stop it.) 

6a. Windows: If you are using Windows, enter the command `dir` to do a listing of the home directory.  You should see the name of the file you just saved.  

<img src="../images/home-folder-cmd-prompt-windows.png" style="border:1px solid black">

6b. Mac: 

7\. If you don't see your file, you may not have actually saved the file in your home directory.  You can either figure out how to save the file in your home directory, or save the file to some other known directory and use the `cd` command line command to change to that directory.  Get help from someone if necessary.

8\. In the console, run the script.  In Windows, enter the command

```
python divide_numbers.py
```

On a Mac, enter the command

```
python3 divide_numbers.py
```

*Note: in all subsequent examples, when running the script, you will always need to put the "3" after the "python" if you are using a Mac, even if the example doesn't show it.*

The console should print the number `0.8333333333333334`, then show the command prompt again, like this in Windows:

<img src="../images/result-windows.png" style="border:1px solid black">

or this on a Mac:


Notice that the console does not output any information other than what the script said to print.  There is no indiction that any other lines of the code had executed.  Also note that unlike in the [Python shell](../install/#giving-commands-using-the-python-shell), you cannot execute individual Python commands, or examine the values of variables by printing them.

9\. To modify the script, return to the code editor, make changes to the code and save the file again.  *Note: simply changing lines in the code editor will not cause changes when the script is run unless the file is saved!*  In this example, change line 2 to

```
divisor = 2
```

10\. To see the effect of the changes, return to the console and run the file again as you did before.  *Note: in Windows, you can bring up the previous command by pressing the up arrow key once, then pressing Enter/Return.*  

Here's what should happen:

<img src="../images/result-modified-windows.png" style="border:1px solid black">

Again, only the results of the print command are displayed in the console output.  

This process of changing and re-running a script is one method of developing and testing code.  Usually, during development many intermediate results are printed so that it's possible to have a better understanding of whether the script is doing what you want.

The console output will also include error messages that may be helpful in debugging the program.  For example, if I change line 3 to 

```
pring(number/divisor)
```

the Python processor will provide an error message, since "pring" is not a valid Python command.

<img src="../images/error.png" style="border:1px solid black">


----
Revised 2019-01-12
