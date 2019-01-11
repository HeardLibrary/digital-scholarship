---
permalink: /script/python/install/
title: Installing Python 
breadcrumb: Install
---

# Installing Python

## Before starting

There are [many flavors of Python](https://www.infoworld.com/article/3267976/python/anaconda-cpython-pypy-and-more-know-your-python-distributions.html) and there is no way we could describe how to install all of them.  In the instructions here, we will assume the reference implementation of Python: CPython.  It is the default and most widely used flavor.  We will be installing Python 3. (For information about the distinction between Python 2 and 3, see the [Python resources page](../#python-2-vs-python-3))

If you think that you are going to want to exclusively use the Integrated Development Environment called Thonny, then you can skip thes instructions and the follow the [Thonny instalation instructions](thonny) instead of these instructions. Thonny automatically installs a bundled implementation of CPython 3 as part of its installation.  However, if you want to also be able to run Python from the command line or edit scripts using a code editor, you should go ahead and install Python using these instructions. You can install stand-alone Python and also install Thonny later if you wish.

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

7\. To run Python in the simplest way, you will need to use the command line.  On a Mac, the application for doing this is called "Terminal".  The easiest way to get to the command line via Terminal is to click on the Spotlight Search icon (small magnifying glass in the upper right of the screen) and start typing "terminal" in the search box.  When terminal.app shows up in the results, click on it to open a Terminal window.  

<img src="../images/install6mac.png" style="border:1px solid black">

8\. When you enter the Terminal window, you should see a line with the your computer name, a tilde ("~") followed by your username, and finally a "$" character.  This is the system prompt.  It means that you can issue any kind of command line command that the Mac operating system will understand.  

*Note: The Mac operating system is build on the Linux operating system.  So the commands that you give in this window are sometimes called "bash commands" (a type of Linux commands).  Hence you see "bash" listed in the header of the terminal window.*

Enter `python3`.  You should get a message, followed by `>>>`.  These three greater-than characters are the Python prompt.  When you see them instead of the system prompt, it means that Python is running and you need to give commands that Python understands, not generic Linux commands.  

<img src="../images/install7mac.png" style="border:1px solid black">

If you do not see the Python message, but instead get a message like 

```
-bash: python3: command not found
```

then that means that something went wrong in the installation and the operating system can't find Python.  You will need to get help from someone with this.



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

6\. To run Python in the simplest way, you will need to use the command line.  On Windows, the application for doing this is called "Command Prompt".  The easiest way to get to the command prompt is to start typing "command" in the search box next to the start button.  When Command Prompt shows up in the results, click on it to open a Command Prompt window.  

<img src="../images/install5pc.png" style="border:1px solid black">

7\. When you enter the Command Prompt window, you should see a line with the path to your user directory, followed by a ">" character.  This is the system prompt.  It means that you can issue any kind of command line command that Windows will understand.  

Enter `python`.  You should get a message, followed by `>>>`.  These three greater-than characters are the Python prompt.  When you see them instead of the system prompt, it means that Python is running and you need to give commands that Python understands, not generic Windows commands.  

<img src="../images/install6pc.png" style="border:1px solid black">

If you do not see the Python message, but instead get a message like 

```
'python' is not recognized as an internal or external command, operable program or batch file
```

then that means that Windows can't find Python from your home directory.  The solution to this problem is to add the Python installation directory to the system PATH command.  You will need to get help from someone with this.

# Trying out Python 