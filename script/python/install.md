---
permalink: /script/python/install/
title: Installing Python 
breadcrumb: Install
---
# Installing Python

# Background

## Before starting

There are [many flavors of Python](https://www.infoworld.com/article/3267976/python/anaconda-cpython-pypy-and-more-know-your-python-distributions.html) and there is no way we could describe how to install all of them.  In the instructions here, we will install the reference implementation of Python: CPython.  It is the default and most widely used flavor.  The version of Python we will be installing is version 3. (For information about the distinction between Python 2 and 3, see the [Python resources page](../#python-2-vs-python-3))

If you think that you are going to want to exclusively use the Integrated Development Environment called Thonny, then you can skip thes instructions and the follow the [Thonny installation instructions](thonny) instead of these instructions. Thonny automatically installs a bundled implementation of CPython 3 as part of its installation.  However, if you want to also be able to run Python from the command line or edit scripts using a code editor, you should go ahead and install Python using these instructions. You can install stand-alone Python as described here and also install Thonny later if you wish.

## What's the console?

Although most users are used to interacting with a computer through a graphical interface involving windows and a mouse or trackpad, it is also possible to interact with a computer using a non-graphical interface.  That kind of interface is variously known as a *console*, *terminal*, or the *command line* and we'll use those terms more or less interchangeably.  In the old pre-windows day, the console was a physical device on which users typed text commands using a syntax particular to each operating system (sometimes known as the disk operating system, or DOS).  Now the console is a program that runs in a window in the graphical interface, but that window mimics the behavior of the old-fashioned console.  

Many advanced users favor using the command line because it may allow for options not available in the graphical interface, and may enable automating or scripting a series of commands in a way not easily accomplished using the graphical interface.  

## What's the shell?

In this lesson, we will show you how to run Python through a console using its interactive interpreter, also known as its *shell*.  When using the shell, you issue Python commands one at a time, they are executed immediately, and you can see the result immediately (if there is anything to see). Even though you may rarely run Python programs this way, examples are often shown as shell commands, so understanding how the shell works is important.  In most cases, the behavior of a line of code in the shell is the same as the behavior of that same line if the Python script were run from a multiline script from a file.  However, the Python shell also processes commands like 

```
2 + 2
```

that would not do anything useful in a multiline script.

## Getting started if you are a non-native English speaker

The OpenTechSchool has a nice [Introduction to Programming with Python](https://opentechschool.github.io/python-beginners/) that is available in English, Deutsch, Español, русский, 한국인, and Română.  So check that site out if it would be helpful to get a second explanation in one of those languages.

# Installation instructions

## Mac installation

1\. Go to the Python home page <https://www.python.org/>.  Click the Downloads tab.

2\. Your browswer should detect your operating system and show a download button for the latest version for your OS:

<img src="../images/install1mac.png" style="border:1px solid black">

3\. When the download finishes, double-click on the installer file, which should have a name something like python-3.7.2-m...pkg .  Here's what it looks like in the Chrome browser:

<img src="../images/install2mac.png" style="border:1px solid black">

4\. When the dialog box comes up, it should look something like this:

<img src="../images/install3mac.png" style="border:1px solid black">

Click on the Continue button.  The next window contains information about the installer variant that you should use and some other stuff.  

*Unless you have an old computer with an operating system older than OS 10.9 (Snow Leopard), then you should use the 64 bit-only variant.  To find out the OS version of your computer go to the Apple menu in the upper left corner and click on About This Mac.  You probably won't have to worry about this during the installation unless you have an old computer.*

Continue to click on the Continue button until you reach the Install stage.  A licensince agreement will also pop up, and you must click Agree to continue the installation.  

5\. At the Install screen, you will be prompted to enter you computer's password in order to continue the installation:

<img src="../images/install4mac.png" style="border:1px solid black">

6\. After you click Install, you should see the installation progress until you get to the window showing that the installation has been successfully completed.  

<img src="../images/install5mac.png" style="border:1px solid black">

At the end of the installation, you will be given an option to delete the Installer file from the Downloads folder.  You won't need it any more, so you can allow that.

## Starting Python on a Mac

1\. To run Python in the simplest way (using the shell), you will need to use the console/command line.  On a Mac, the application for doing this is called "Terminal".  The easiest way to get to the command line via Terminal is to click on the Spotlight Search icon (small magnifying glass in the upper right of the screen) and start typing "terminal" in the search box.  When terminal.app shows up in the results, click on it to open a Terminal window.  

<img src="../images/install6mac.png" style="border:1px solid black">

2\. When you enter the Terminal window, you should see a line with the your computer name, a tilde (`~`) followed by your username, and finally a "$" character.  This is the system prompt.  It means that you can issue any kind of command line command that the Mac operating system will understand.  

*Note: The Mac operating system is build on the Linux operating system.  So the commands that you give in this window are sometimes called "bash commands" (a type of Linux commands).  Hence you see "bash" listed in the header of the terminal window.*

Enter `python3`.  You should get a message, followed by `>>>`.  These three greater-than characters are the Python prompt.  When you see them instead of the system prompt, it means that the Python shell is running and you need to give commands that Python understands, not generic Linux commands.  

<img src="../images/install7mac.png" style="border:1px solid black">

If you do not see the Python message, but instead get a message like 

```
-bash: python3: command not found
```

then that means that something went wrong in the installation and the operating system can't find Python.  You will need to get help from someone with this.

3\. To continue testing out your Python installation, continue to the [Trying out Python section](#trying-out-python).

## Windows installation

1\. Go to the Python home page <https://www.python.org/>.  Click the Downloads tab.

2\. Your browswer should detect your operating system and show a download button for the latest version for your OS:

<img src="../images/install1pc.png" style="border:1px solid black">

3\. When the download finishes, double-click on the installer file, which should have a name something like python-3.7.2.exe .  Here's what it looks like in the Chrome browser:

<img src="../images/install2pc.png" style="border:1px solid black">

4\. When the dialog box comes up, be sure to check the box to add Python to the system PATH variable.  If you don't check this box now, it is possible to fix it later, but the process is much more complicated.  After checking the box, click the Install Now link.

<img src="../images/install3pc.png" style="border:1px solid black">

You will probably get a security warning - go ahead and accept it.

5\. After the installation has successfully completed, you should see something like this:

<img src="../images/install4pc.png" style="border:1px solid black">

Click Close.

## Starting Python on Windows

1\. To run Python in the simplest way (using the shell), you will need to use the console/command line.  On Windows, the application for doing this is called "Command Prompt".  The easiest way to get to the command prompt is to start typing "command" in the search box next to the start button.  When Command Prompt shows up in the results, click on it to open a Command Prompt window.  

<img src="../images/install5pc.png" style="border:1px solid black">

2\. When you enter the Command Prompt window, you should see a line with the path to your user directory, followed by a ">" character.  This is the system prompt.  It means that you can issue any kind of command line command that Windows will understand.  

Enter `python`.  You should get a message, followed by `>>>`.  These three greater-than characters are the Python prompt.  When you see them instead of the system prompt, it means that the Python shell is running and you need to give commands that Python understands, not generic Windows commands.  

<img src="../images/install6pc.png" style="border:1px solid black">

If you do not see the Python message, but instead get a message like 

```
'python' is not recognized as an internal or external command, operable program or batch file
```

then that means that Windows can't find Python from your home directory.  The solution to this problem is to add the Python installation directory to the system PATH command.  You will need to get help from someone with this.

3\. To continue testing out your Python installation, continue to the next section.


# Trying out Python 

*Important note: in the examples shown here, screenshots will only be shown for Macs.  That's because the operation of the Python shell in Windows and Mac is in most cases identical.  However, there is a critical difference in how you start Python applications in Mac and Windows.  In Windows, to start the shell you simply enter `python` at the command line, but on Macs, you must enter `python3`.  The "3" at the end of the command is present to allow a Mac user to be able to run both Python 2 and Python 3 on the same computer.  If you switch back and forth between Macs and PCs, it is important to remember this.*

*Adding a final "3" on Macs also applies to Python's package manager, PIP. To give a PIP command at the Windows command line, one types `pip` followed by the command.  On a Mac, one must type `pip3` followed by the same command.*

## Giving commands using the Python shell

1\. If you haven't already launched the Python shell (interactive interpreter) in the console, do it now.  (See the end of the appropriate section above (for [mac](#starting-python-on-a-mac) or [Windows](#starting-python-on-windows)) for details of the way to do that.)  You should see the Python command prompt `>>>` if Python is running.  

<img src="../images/try1.png" style="border:1px solid black">

2\. Enter each of the following lines at the Python prompt one at a time, pressing Enter/Return after each line.  Each time you enter a line, it is executed by the shell and and you should see the Python prompt again before you type the next line.

```
number = 5
divisor = 6
print(number/divisor)
```

After entering each of the first two lines you won't see anything happen except for the prompt reappearing.  That's because the first two commands tell Python to load a number into a named storage location (a *variable*), but they don't tell Python to actually show you anything.  The third line tells Python to divide the two numbers, then show the answer in the console.  It should look something like this:

<img src="../images/try2.png" style="border:1px solid black">

3\. When you execute Python commands in the shell like this, Python "remembers" what has happened before.  For example, after you loaded a 5 into the variable `number`, it's still there after you used the variable in a calculation.  To see what its value is, enter the following line:

```
print(number)
```

You should see the value (5) printed on the screen, like this:

<img src="../images/try3.png" style="border:1px solid black">

## Quitting the Python shell

1\. To quit the Python shell, hold on the Control key (labeled `control` or `Ctrl` depending on your keyboard) and press the Z key.  You may or may not have to press Enter after that.  The console window should now show the appropriate systen prompt for your operating system. 

<img src="../images/try4.png" style="border:1px solid black">

Alternatively, you can enter the command `quit()`, which has the same effect.

2\. You can now quit the console program in the usual way for your operating system (clicking the X at the top of the window).   In most cases with Python, you can probably get away with skipping step 1 and just closing the consloe program.  However, it's a good general practice to stop running processes before you close the console window because in some cases, just closing the window doesn't actually stop the program that is running.

# Effective develpment of Python scripts

Although issuing Python commands one line at a time is fine for learing how commands work, it is easier to develop Python scripts as a whole by writing them in a code editor, or using an integrated development environment (IDE).  The Thonny IDE was mentioned at the top of this page.  Instructions for developing code using a code editor are on [this page](../editor/).

----
Revised 2019-01-12
