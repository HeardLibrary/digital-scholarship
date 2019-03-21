---
permalink: /computer/command-unix/
title: Command Line (Unix)
breadcrumb: Command Line (Unix)
---

# Understanding my computer - Lesson 6: The Command Line

This is the Mac version of this page, which covers the Unix Shell.  [Click for the Windows version of this page](../command-windows/)

Note: this lesson assumes that you have completed and understand lessons [1 (files)](../files-mac/) and [2 (directories)](../directories-mac/). 

## What is the command line and do I need to use it?

The "command line" is a generic term for using textual commands to perform operations on files.  It's an alternative to using a graphical interface like Finder to view directories, copy files, and run software.

For most users most of the time, using the command line is not necessary.  Most of the functions that can be done using the command line can also be done using the more familiar Finder graphical interface.  However, there are certain circumstances where it is difficult or impossible to accomplish a task without using the command line.   

Even if you don't routinely use the command line, it is useful to have a basic understanding of it so that you will know how to execute command line commands when a situation requires it.  

**What's a console?**

Although most users are used to interacting with a computer through a graphical interface involving windows and a mouse or trackpad, it is also possible to interact with a computer using a non-graphical interface.  That kind of interface is variously known as a *console*, *terminal*, *command prompt*, or *command line interface* (*CLI*) and we can use those terms more or less interchangeably.  In the old pre-windows day, the console was a physical device on which users typed text commands using a syntax particular to each operating system (sometimes known as the disk operating system, or DOS).  Now the console is a program that runs in a window in the graphical interface, but that window mimics the behavior of the old-fashioned console.  

Many advanced users favor using a command line interface because it may allow for options not available in the graphical interface, and may enable automating or scripting a series of commands in a way not easily accomplished using the graphical interface.  

**What's Linux?**

Linux is one of the most common operating systems and is the main alternative to Microsoft's Windows operating system.  Linux is the predominant operating system used by servers and for that reason, the syntax used on the Internet (such as URL patterns) are similar to Linux syntax.  Linux is also the underlying operating system for Macs, so the typical file directory patterns used by stand-alone Linux systems are also found on Macs.  

Linux is similar to the Unix operating system, which has been around for a very long time.  For that reason, it is favored by many computer "pros".  However, unlike Unix, Linux is free and open source. That is another reaons for its popularity.  Linux comes in various flavors, such as Fedora, Ubuntu, and Debian.  For our purposes, they are similar enough that we won't distinguish between them.  

**What's the shell?**

The *shell* is the program that takes the text commands from the console and makes them run.  There are various versions of the shell, but one of the most common is called *bash* (for "Bourne Again SHell"; named after Steve Bourne, creator of the original shell).  

## Starting the console on a Mac

On a Mac, the default application for running the shell is called "Terminal".  The easiest way to get to the command line via Terminal is to click on the Spotlight Search icon (small magnifying glass in the upper right of the screen) and start typing "terminal" in the search box.  When terminal.app shows up in the results, click on it to open a Terminal window.  

<img src="../images-6-mac/install6mac.png" style="border:1px solid black">

When you enter the Terminal window, you should see a line with the your computer name, a tilde (`~`) followed by your username, and finally a "$" character.  This is the system prompt.  It means that you can issue any kind of command line command that the Mac operating system will understand.  Commands that you give in the Terminal window are sometimes called "bash commands".  Hence you see "bash" listed in the header of the terminal window.

**What's root/superuser/sudo ?**

By default, when you run the terminal, you will assume the identity of the logged-in user.  Even if that user is an administrator, you won't automatically be able to carry out every administrative command in the shell.  The most powerful level in the system is known as the *root* level.  Linux does not automatically grant you access to root-level commands because you could easily wreak havoc on your system by executing them accidentally.  You can temporarily take on the role of "superuser" (operating on the root level) by adding "sudo" to shell commands (sudo = "superuser do").

You can also be logged on as the superuser.  In that case, the system prompt will end with `#` instead of `$` and you will need to be extra careful.

**Giving commands**

For your first command, enter

```
pwd
```

This command stands for "print working directory" (not "password" as you might expect).  On the line below the command, you should see the path leading from the root directory to the current directory in which you are working.  Because the shell isn't a graphical system, its easy to get disoriented about "where you are" and the `pwd` command is a good way to re-locate yourself.  Recall from the lesson on directories that tilde (`~`) is an abbreviation for the user's home directory.  When you start up Terminal, you should defalt to your working directory and that's why the system prompt includes `~`.  The result of the `pwd` command should show your unabbreviated path starting at the root directory `/`.

Another useful command is the list command:

```
ls
```

The list command prints a list of files and directories that are in a directory.  When `ls` is given by itself, it lists the files in the current working directory.

# Exploring the directory tree

You might find it helpful to review the first section of the [lesson on directories](../directories-mac/) at this point.

## File paths

**Note: you might want to open a Finder window in columns mode to compare what you see there with the results of the commands you give in this section.**

An important feature of the command line is specifying the location of a directory or file using a *path*.  A path can be either *relative* (relative to some directory) or *absolute* (stated with repect to the root directory).  

You can list the files (and directories) in a particular directory by including the path of the directory after the `ls` command.  Try listing the files in the directories designated by the following absolute paths:

```
ls /
ls /users
ls ~
```

Notice that the path in the last command contains the absolute (but abbreviated) path to your home directory.  

**Note: the path to a directory can optionally include a trailing slash.**  So `/users` is the same as `/users/`.

If a path begins directly with a directory name rather than a slash or tilde, then that directory is assumed to be a child directory of the current working directory.  Assuming that you are still in your home directory, enter

```
ls Documents
```

You should see a listing of the files in the Documents directory that is a child directory of your home directory (currently your working directory).  Now try these commands:

```
ls documents
ls /Documents
```

The first command shows that paths in the shell are not case sensitive.  The second command should generate an error, because its path is absolute and there probably isn't any folder named "Documents" that is a child of your root directory.

You can include multiple levels in a relative path.  On my computer, I have a subdirectory of my Documents directory called `corp-b` and I could reference it from my home directory as

```
ls Documents/corp-b
```

**Special relative path prefixes**

There are two special prefixes that are sometimes useful.  A single dot represents the current working directory and two consecutive dots represents the parent directory of the current working directory.  Try these:

```
ls
ls .
ls /users
ls ..
```

The first command should produce the same result as giving the `ls` command without any path.  The second command should list the parent directory of your home folder (`users`).  These prefixes can be combined with other directory names to make more complicated paths.  For example:

```
ls ./Downloads
ls ../Guest
```

You can use multiple `..` symbols to go up more than one parent level.

## Wild cards

If you want the path expression to apply to only certain files in a directory, you can specify them using wild cards.  For example, if you only want to list Python scripts, you can say

```
ls *.py
```

If you only want to list files in the Shared folder whose name is `myfile`, but which can have any extension, you can say

```
ls ../Shared/myfile.*
```

`*.*` means every file.  You can use it if you want to include every file, but not directories.  For example:

```
ls ~/*.*
```

## Repeating a previous shell command

If you want to repeat an earlier command, you can use the up arrow key to move back to earlier commands and the down arrow key to move forward to later commands.  The command doesn't actually get executed until you press the `return` (or `Enter`) key.

## Changing the working directory

In all of the previous examples, the list command was executed from the home directory as the current working directory and any relative paths were relative to the home directory.  You can change the current working directory (i.e. move around within the directory tree) using the *change directory* (`cd`) command.  The `cd` command is followed by either a relative or absolute path.  Recall that you can use `pdw` to see where you are in the directory tree.  Try these:

```
cd /
pwd
cd ~
pwd
cd Documents
pwd
cd ..
pwd
cd ..
pwd
cd ~/Downloads
pdw
```

**Other shell commands**

There are many other shell commands beyond the few we have used here.  For a complete lesson, see the [Software Carpentry lesson on the Unix Shell](https://swcarpentry.github.io/shell-novice/)

# Applications of the command line

**HTML**

If you ever need to write HTML, you should note that references to images and pages use unix-style paths.  So for example, an image tag might have this path

```
<img src="imagefolder/part1/cats.jpg> alt="My cat">
```

The cat picture would be located in a directory two levels below the directory where the web page resides (in the `part1` subdirectory of the `imagefolder` subdirectory of the current directory).  Here's another example from this website:

```
<a href="../files-windows/">Go to the Windows file page</a>
```

This goes to the parent of the current web page and moves to the Windows files page.

**Saving a list of files to a file**

You can easily create a text file containing a list of files using *output redirection*.  Redirection sends the output of a shell command to a file instead of to a screen.  Try this:

```
ls ../Guest/*.* > Documents/files.txt
```

This command lists the files (but not directories) in the Guest directory and redirects the listing to a file called `files.txt` located in the Documents subdirectory of the current working directory.  If you ran this command, you can open your Documents folder and open the `files.txt` file in a text editor.

Note that if the file already exists, it will be overwritten with the new output.  If there is no output, the file will still be created -- it will just be empty.

## Running a program using the shell

You are probably used to launching software by double-clicking on an icon in Finder or Launchpad.  Applications can also be launched by executing them at the command line.  In some cases, the application will run and communicate with you through the terminal window.  In other cases, the application will open a new window on your desktop.  

A text editor called `pico` comes pre-installed with Linux.  To run a program like pico, you enter its name at the command line

```
pico
```

To quit pico, hold on the `Control` or `Ctrl` key, then press the `X` key.  (This is not a general behavior.  Some programs are quit by pressing `Control` and `C`, `Control` and `Z`, or some other key combination. Generally the `Command` key is not used in the shell.)

When you run a program at the command line, you can specify some things about how the program should work by following its name with other characters.  For example, you can tell pico what text file you want to edit by following its name with the path of the file.  (If you only put a filename without a path, it will look for the file in the current working directory.)  Here's an example:

```
pico Documents/diagram.txt
```

pico will open the text file `diagram.txt` from the `Documents` subfolder of the current working directory.  

Putting the path to a file upon which the program should operate (called the *argument*) after the program command is a general pattern.  For example, if you have Python 3 installed on your computer, you can run the script `myProg.py` in the Downloads folder by giving this command:

```
python3 ~/Downloads/myProg.py
```

**Flags**

The behavior of a program can be controlled by adding *flags* (also known as options) between the command and the argument. Flags usually begin with either a single dash or two dashes.  Often flags with two dashes are unabbreviated and flags with a single dash are abbreviated.  

A typical flag is `--help`.  You can use it to get help with a program (including finding out what all the flags are that you can use with it!).  Try this:

```
pico --help
pico -h
```

Sometimes the flags have their own arguments separated from them by a space.  Here's an example:

```
pico -o ~/Documents diagram.txt
```

Let's break it down:
1. `pico` is the command that runs the program
2. `-o` is the flag that sets the operating directory. It's an `o` (oh), not a `0` (zero).
3. `~/Documents` is the argument for the operating directory flag.  It's the directory to be used by default.
4. `diagram.txt` is the file to be opened.  Since `~/Documents` has been set as the operating dirctory, pico will look for `diagram.txt` there.

You may have noticed that the syntax that we've been using is similar to the shell commands.  That's because at their hearts, shell commands are really just programs.  So they can have switches and arguments just as described for other programs.

## The system path

One of the really annoying and insidious problems that you can encounter is to try to run a program and to get the error `Command not found`.  This error happens when the shell doesn't know where to look to find the program you are trying to run.

When the shell tries to run a program, it first looks in the current working directory.  So one solution to this problem is to just navigate to the directory where the program was installed or saved, then execute the command to run it from that directory.  Another somewhat annoying way to solve the problem is to write out the full path of the command instead of just typing it.  For example, if the program `doSomething` is in the `/Applications` directory, you could give this command:

```
/Applications/doSomething
```

However, you'd often like to be able to run a program from any working directory.  In that case, you need to add the location of the program to the system PATH variable.  The system PATH is a list of paths where the shell will look if it can't find the program in the current working directory.  If an application is well-designed, during the installation process, the installer will either add the necessary path to the PATH variable, or ask you if you want it to add the path to the PATH variable (you should say "yes").  However, some sloppier installers don't do this.

You can see the paths of all directories currently in the system PATH variable by entering this command:

```
echo "$PATH"
```

Because all of the paths are crammed together and separated by colons, it can be a bit difficult to pick apart all of the paths.  But if you look carefully and don't see the path of the place where your program is installed, you may need to add it to the system PATH.

The following method will work for recent versions of Mac OSX.  There are actually several ways to modify the system PATH variable on a Mac -- you can find others by Googling.

**Note:** if you aren't comfortable making this modification, ask for help from a more advanced user.

1\. Open Finder and navigate to your home folder.

2\. The file you need is hidden by default.  To make it visible, hold on the `command` and `shift` keys, then press the period (`.`) key.  

3\.  Look through the files until you find a grayed out one called `.bash_profile`.  

<img src="../images-6-mac/bash-profile.png" style="border:1px solid black">

For safe keeping, right click on it and select `Duplicate`. Then change its name by removing the initial dot.

4\. Right-click on the file again and select `Open With > TextEdit.app`.

5\. Add a line to the end of the existing file in this form:

```
export PATH=$PATH:newfilepath
```

where `newfilepath` is the additional file path where the system should look to find programs.  Here is an example:

```
export PATH=$PATH:~/Library/Python/3.7/bin
```

Including the `$PATH:` part means to take the existing path and add the new path to it.  This should be relatively harmless because even if your new path doesn't work, the existing paths will still be included in the system PATH variable.  

6\. Save the file and close the TextEdit application.

# Localhost web servers

On of the major reasons for making you suffer through the complexities of dealing with the command line is because there are an increasing number of very important software packages that operate as localhost web servers on your local computer.  A localhost web server is accessed just like any other web server: through a web browser.  The difference here is that the connection to the server isn't through the Internet, but through an IP address (usually 127.0.0.1) that loops back to a port on your own computer rather than a remote remote computer somewhere else.  This special IP address has been given an abbreviation `localhost` that can be used instead of typing out the IP address numbers.  So a localhost URL looks like this:

```
http://localhost/someURL/
```

More commonly, the localhost server is accessed through some port other than the web port 80 (the default port you get if you don't specify one in a browser).  In that case, the port number follows a colon after `localhost`.  Here's an example:

```
http://localhost:8889/bigdata/
```

**Why ???**

The reason applications are built this way is because when an application is designed as web servers, it's really easy to just install them on a cloud service with the same settings and data that have been worked out on the local computer version and voilà, you have a program that can be used by anyone anywhere on the web!  

There are also an increasing number of applications that run using the Docker system.  Docker containers essentially behave like separate computers from the one on which they are running.  Although it's possible to communicate directly between a Docker container and a console, it's more common for the container to "talk" with the user through a port.  If the Docker container is running on your local computer, that port will be accessed through the localhost. For more information about Docker and its various flavors, visit [this page](../../host/)

**Example applications**

Here are some examples of software used at Vanderbilt that operate as web servers:

**OpenRefine** for data cleaning (operates as a localhost server but doesn't have to be launched from the command line)

**Jupyter notebooks** for Python and R

XQuery: **BaseX** server and **eXistdb**

Linked Data: **Blazegraph** and **Stardog**

**Wikibase** (usually installed using Docker)

## Example workflow for a Jupyter notebook

I have two Jupyter notebooks in my Documents folder and want to run the one called `python-turtle.ipynb`.  I open Terminal, then enter 

```
cd Documents
```

to move from my home folder to the Documents subfolder.  Then I enter

```
ls *.ipynb
```

to list all of the files with the `.ipynb` extension.  I see that the notebook I want is there.

<img src="../images-6-mac/find-jupyter-notebook.png" style="border:1px solid black">

Then I enter

```
jupyter notebook
```

I get some text in the console window and my browser automatically opens to localhost port 8888:

<img src="../images-6-mac/jupyter-notebook-directory.png" style="border:1px solid black">

I click on the notebook I want to run and it opens in another tab:

<img src="../images-6-mac/jupyter-notebook-page.png" style="border:1px solid black">

When I'm done with it, I need to save it using the save button.  I can then close the tab.  Howerver, I also need to shut down the localhost server.  In the case of Jupyter notebooks, I can do that by clicking on the Quit button on the Files tab.

<img src="../images-6-mac/jupyter-shutdown.png" style="border:1px solid black">

I get a message in the browser saying that the server is stopped and that I can close the tab.  When I look at my Terminal window, I see some messages related to the shutdown.

If I forget to shut down the server from the browser, I can still shut it down using the shell.  If I hold the `Control` key and press `C`, I'll see a question in the shell asking if I want to shut down the server.

**Note: Just closing the Terminal (shell) window does NOT stop the server.**

## Example workflow for Blazegraph

Assuming that Blazegraph has already been installed using Docker, I open Terminal and enter

```
docker restart blazegraph
```

<img src="../images-6-mac/start-blazegraph.png" style="border:1px solid black">

In this case, the path to the `docker` program is in the system PATH variable, so it doesn't matter where I am in the directory tree within the shell.  If that weren't the case, I'd need to use the `cd` command to move to the appropriate directory first.

The Blazegraph server is communicating through port 8889, so to talk to the server, I open any web browser and enter this in the browser URL bar:

```
http://localhost:8889/bigdata/
```

I can then use the Blazegraph interface to do what I want.  

<img src="../images-6-mac/blazegraph-browser.png" style="border:1px solid black">

To shut down the server, I enter in the console:

```
docker container stop blazegraph
```

<img src="../images-6-mac/stop-blazegraph.png" style="border:1px solid black">

Nothing very intersting shows up on the console window, but now if I try to load

```
http://localhost:8889/bigdata/
```

in the browser, I get an error:

<img src="../images-6-mac/blazegraph-browser-fail.png" style="border:1px solid black">

because the server isn't running any more.  There are more detailed instructions about the inital setup and running of Blazegraph using Docker [here](https://heardlibrary.github.io/digital-scholarship/lod/install/#using-docker-to-create-an-instance-of-blazegraph-on-your-local-computer)

## General comments

Although the commands illustrated here are ideosyncratic to the particular cases of Jupyter notebooks and Blazegraph, the workflow is similar for many applications of this type:

1. Open a Terminal window.
2. Execute a command line command to start the server.
3. Enter an appropriate localhost URL in the browser URL bar.
4. Work
5. Execute a command line command to stop the server.
6. Close the brower.

Sometimes parts of this procedure will happen automatically (such as starting a server after double-clicking on an icon for OpenRefine, or automatically opening the correct browser page when running a Jupyter notebook), but in general, these steps always happen in a server-based application. 

Understanding what's going on here is important because often just closing the browser or the terminal window doesn't stop the server.  It will continue running in the background on your computer until the next time you shut the computer down.  That may slow down other applications and failing to shut down the server properly could cause data loss.  
