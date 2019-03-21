---
permalink: /computer/command-windows/
title: Command Line (Windows)
breadcrumb: Command Line (Windows)
---

# Understanding my computer - Lesson 6: The Command Line

This is the Windows version of this page.  [Click for the Mac version of this page, which covers the Unix shell.](../command-unix/)

[go back to Lesson 5: Backup](../backup-windows/)

Note: this lesson assumes that you have completed and understand lessons [1 (files)](../files-windows/) and [2 (directories)](../directories-windows/). 

## What is the command line and do I need to use it?

The "command line" is a generic term for using textual commands to perform operations on files.  It's an alternative to using a graphical interface like File Explorer to view directories, copy files, and run software.

For most users most of the time, using the command line is not necessary.  Most of the functions that can be done using the command line can also be done using the more familiar File Explorer graphical interface.  However, there are certain circumstances where it is difficult or impossible to accomplish a task without using the command line.   

Even if you don't routinely use the command line, it is useful to have a basic understanding of it so that you will know how to execute command line commands when a situation requires it.  

**What's a console?**

Although most users are used to interacting with a computer through a graphical interface involving windows and a mouse or trackpad, it is also possible to interact with a computer using a non-graphical interface.  That kind of interface is variously known as a *console*, *terminal*, *command prompt*, or *command line interface* (*CLI*) and we can use those terms more or less interchangeably.  In the old pre-windows day, the console was a physical device on which users typed text commands using a syntax particular to each operating system (sometimes known as the disk operating system, or DOS).  Now the console is a program that runs in a window in the graphical interface, but that window mimics the behavior of the old-fashioned console.  

Many advanced users favor using a command line interface because it may allow for options not available in the graphical interface, and may enable automating or scripting a series of commands in a way not easily accomplished using the graphical interface.    

**What's the shell?**

The *shell* is the program that takes the text commands from the console and makes them run.  There are two versions of shells for running Windows commands: Command shell and PowerShell.  We will be talking about the Command shell in this lesson.

## Starting the console in Windows

In Windows, the application for doing this is called "Command Prompt".  The easiest way to get to the command prompt is to start typing "command" in the search box next to the start button.  When Command Prompt shows up in the results, click on it to open a Command Prompt window.  

<img src="../images-6-pc/install5pc.png" style="border:1px solid black">

When you enter the Command Prompt window, you should see a line with the path to your user directory, followed by a ">" character.  This is the system prompt.  It means that you can issue any kind of command line command that Windows will understand.  

**Giving commands**

For your first command, enter

```
cd
```

On the line below the command, you should see the path leading from the root directory to the current directory in which you are working.  Because the shell isn't a graphical system, you can get disoriented about "where you are" and the `cd` command is a way to re-locate yourself.  The result of the `cd` command should show your unabbreviated path starting at the drive and root directory `C:\`.  Since the system prompt generally includes the path, you are reminded where you are after each time a command is completed.

Another useful command is the list directory command:

```
dir
```

The list command prints a list of files and directories that are in a directory.  When `dir` is given by itself, it lists the files in the current working directory.

# Exploring the directory tree

You might find it helpful to review the first section of the [lesson on directories](../directories-windows/) at this point.

## File paths

**Note: you might want to open a File Explorer window with the navigation pane open to compare what you see there with the results of the commands you give in this section.**

An important feature of the command line is specifying the location of a directory or file using a *path*.  A path can be either *relative* (relative to some directory) or *absolute* (stated with repect to the root directory).  

You can list the files (and directories) in a particular directory by including the path of the directory after the `dir` command.  Try listing the files in the directories designated by the following absolute paths:

```
dir c:\
dir \
dir c:\users
dir \users
dir c:%HOMEPATH%
``` 

Notice that you get the same result if you include the directory letter or not.  If no drive letter is given, it assumes the path is on the current drive (the most recent one to be designated).  You can designate a different drive by simply entering the drive letter, followed by a colon.  Scroll down the navigation pane of File Explorer to see if you have any drives other than C: attached.  If so, try changing to that other drive and back to the C: drive.

Also notice that the path in the last command contains the absolute (but abbreviated) path to your home directory.  (Note: `%HOMEPATH%` is the *environmental variable* for your home directory.  It doesn't include the drive letter, so if you want to specify the drive letter, you must write it.)

**Note: the path to a directory can optionally include a trailing backslash.**  So `c:\users` is the same as `c:\users\`.

If a path begins directly with a directory name rather than a drive letter and a backslash or backslash alone, then that directory is assumed to be a child directory of the current working directory.  Assuming that you are still in your home directory, enter

```
dir Documents
```

You should see a listing of the files in the Documents directory that is a child directory of your home directory (currently your working directory).  Now try these commands:

```
dir documents
dir \Documents
```

The first command shows that paths in the shell are not case sensitive.  The second command should generate an error, because its path is absolute and there probably isn't any folder named "Documents" that is a child of your root directory.

You can include multiple levels in a relative path.  On my computer, I have a subdirectory of my Documents directory called `Arduino` and I could reference it from my home directory as

```
dir Documents/Arduino
```

**Special relative path prefixes**

There are two special prefixes that are sometimes useful.  A single dot represents the current working directory and two consecutive dots represents the parent directory of the current working directory.  Try these:

```
dir
dir .
dir \Users
dir ..
```

The first command should produce the same result as giving the `dir` command without any path.  The second command should list the parent directory of your home folder (`Users`).  You may have noticed in directory listings that `.` and `..` are included in the directory listing.

These prefixes can be combined with other directory names to make more complicated paths.  For example:

```
dir .\Downloads
dir ..\Public
```

You can use multiple `..` symbols to go up more than one parent level.

## Wild cards

If you want the path expression to apply to only certain files in a directory, you can specify them using wild cards.  For example, if you only want to list Python scripts, you can say

```
dir *.py
```

If you only want to list files in the Shared folder whose name is `duck`, but which can have any extension, you can say

```
dir ..\..\temp\duck.*
```

`*.*` means every file.  You can use it if you want to include every file (including directories).  For example:

```
dir *.*
```

## Repeating a previous shell command

If you want to repeat an earlier command, you can use the up arrow key to move back to earlier commands and the down arrow key to move forward to later commands.  The command doesn't actually get executed until you press the `Enter` (or `return`) key.

## Changing the working directory

In all of the previous examples, the list command was executed from the home directory as the current working directory and any relative paths were relative to the home directory.  You can change the current working directory (i.e. move around within the directory tree) using the *change directory* (`cd`) command.  

We saw earlier how issuing the `cd` command by itself would print the path to the current working directory.   When the `cd` command is followed by either a relative or absolute path, it changes the current working directory to the directory described by that path.  You can see where you are in the directory tree by looking at the path that is shown as part of the prompt.  Try these:

```
cd \
cd %HOMEPATH%
cd Documents
cd ..
cd ..
```

**Other shell commands**

There are many other shell commands beyond the few we have used here.  For a complete list, see the [Windows Commands web page](https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/windows-commands)

# Applications of the command line

The general rules that we have learned about absolute and relative paths for Windows also apply to Unix-style paths. Unix-style paths are important because they are the basis of Internet URLs and are used in HTML. There are two primary differences between Unix-style paths and Windows paths:

- The direction of the slash is reversed in Unix-style paths. Forward slashes (`/`) are used instead of backslashes (`\`) to separate the parts of the path.
- Unix-style paths do not include a drive letter.  The root directory is simply `/`.

**HTML**

If you ever need to write HTML, you should note that references to images and pages use Unix-style paths.  So for example, an image tag might have this path

```
<img src="imagefolder/part1/cats.jpg> alt="My cat">
```

The cat picture would be located in a directory two levels below the directory where the web page resides (in the `part1` subdirectory of the `imagefolder` subdirectory of the current directory).  Here's another example from this website:

```
<a href="../files-windows/">Go to the Windows file page</a>
```

This goes to the parent of the current web page and moves to the `files-windows` page.  Note that the dot system is also used in Unix-style commands.

**Saving a list of files to a file**

You can easily create a text file containing a list of files using *output redirection*.  Redirection sends the output of a command to a file instead of to a screen.  Try this:

```
dir /b ..\Public\*.* > Documents/files.txt
```

**Note:** The `/b` in the command is called a *switch* and will be discussed later.

This command lists the files in the public directory and redirects the listing to a file called `files.txt` located in the Documents subdirectory of the current working directory.  If you ran this command, you can open your Documents folder and open the `files.txt` file in a text editor.  Notice that adding `/b` following the command creates a brief directory listing that includes only the file names.

Note that if the file already exists, it will be overwritten with the new output.  If there is no output, the file will still be created -- it will just be empty.

## Running a program using the command line

You are probably used to launching software by double-clicking on an icon in File Explorer or on your desktop.  Applications can also be launched by executing them at the command line.  In some cases, the application will run and communicate with you through the terminal window.  In other cases, the application will open a new window on your desktop.  

A text editor called Notepad with a graphical graphical user interface (GUI) comes pre-installed with Windows.  To run a program like notepad from the command line, you just enter its name.

```
notepad
```

**Note:**  When Notepad is run, a seperate window with the GUI opens up.  When some other applications (for example Python) are running, they continue to use the console window.  Those applications often change the prompt so that you know you aren't issuing generic Command Prompt commands.  To exit an application that runs directly in the console, often you hold on the `Control` or `Ctrl` key, then press the `C` key.  This isn't always the way to quit -- some programs are quit by pressing `Control` and `X`, `Control` and `Z`, or some other key combination. 

When you run a program at the command line, you can specify some things about how the program should work by following its name with other characters.  For example, you can tell Notepad what text file you want to edit by following its name with the path of the file.  (If you only put a filename without a path, it will look for the file in the current working directory.)  Here's an example:

```
notepad Documents\diagram.txt
```

pico will open the text file `diagram.txt` from the `Documents` subfolder of the current working directory.  

Putting the path to a file upon which the program should operate (called the *argument*) after the program command is a general pattern.  For example, if you have Python 3 installed on your computer, you can run the script `myProg.py` in the Downloads folder by giving this command:

```
python Downloads\myProg.py
```

Arguments aren't always file paths.  Sometimes they are used to pass other kinds of information to the application when it starts running.

**Flags and switches**

The behavior of a program can be controlled by adding *flags* between the command and the argument. Flags begin with either a single dash or two dashes.  Often flags with two dashes are unabbreviated and flags with a single dash are abbreviated.  

A typical flag is `--help`.  You can use it to get help with a program (including finding out what all the flags are that you can use with it!).  For example:

```
python --help
python -h
```

Sometimes the flags have their own arguments separated from them by a space.  Here's an example:

```
docker --config \apps\cf ps
```

Let's break it down:
1. `docker` is the command that runs the Docker application
2. `--config` is a flag that specifies the location of the configuration file
3. `\apps\cf` is the argument for the config flag.  It's the path to the directory containing the configuration file.
4. `ps` is the argument for the Docker application.  It indicates that the Docker program should list available containers.

Notice that if flags have arguments, they come immediately after the flag, while arguments for the main command come at the end of the line.

Flags are a common feature of the Windows command line and the Linux shell.  So if you are a current or former Mac or Linux user, they should be familiar.  Windows has another way to control the behavior of an application that is NOT found in the Linux command line: *switches*.  Switches behave an a similar manner to flags, but their syntax is different.  

In the Windows shell, switches are generally a single letter and are preceeded with a forward slash.  We saw the "bare listing" switch `/b` in an `dir` command example above.  The behaviors of switches and flags are similar. You can follow a command by multiple switches separated by spaces. Switches can also have arguments, but their use is somewhat inconsistent.  Sometimes switch arguments come immediately after the switch with no space and sometimes they are separated by a space.  Sometimes switches come before the argument of the main command and sometimes they come after it. 

Because of the inconsistent use of switches, you need to look at the documentation to see the exact syntax for how switches are used for a particular command. For many Windows commands, you can get help by following the command with `/?`.  You can also usually find the syntax easily by doing a web search.

You may have noticed that the syntax for running programs is similar to the shell commands.  That's because at their hearts, shell commands are really just programs.  

## The system path

One of the really annoying and insidious problems that you can encounter is to try to run program X and to get the error `X is not recognized as an internal or external command, operable program or batch file`.  This error happens when the shell doesn't know where to look to find the program you are trying to run.

When the shell tries to run a program, it first looks in the current working directory.  So one solution to this problem is to just navigate to the directory where the program was installed or saved, then execute the command to run it from that directory.  Another somewhat annoying way to solve the problem is to write out the full path of the command instead of just typing it.  For example, if the program `doSomething` is in the `\Applications` directory, you could give this command:

```
\Applications\doSomething
```

However, you'd often like to be able to run a program from any working directory.  In that case, you need to add the location of the program to the system PATH variable.  The system PATH is a list of paths where the shell will look if it can't find the program in the current working directory.  If an application is well-designed, during the installation process, the installer will either add the necessary path to the PATH variable, or ask you if you want it to add the path to the PATH variable (you should say "yes").  However, some sloppier installers don't do this.

You can see the paths of all directories currently in the system PATH variable by entering this command:

```
PATH
```

Because all of the paths are crammed together and separated by semicolons, it can be a bit difficult to pick apart all of the paths.  But if you look carefully and don't see the path of the place where your program is installed, you may need to add it to the system PATH.

**Note:** if you aren't comfortable making this modification, ask for help from a more advanced user.

1\. In the search box, enter `control panel`, then click on the item when it's found.

<img src="../images-5-pc/control-panel.png" style="border:1px solid black">

2\. *Note: the appearance of this window may vary depending on the state of the `View by:` dropdown.  If necessary, change the value of the dropdown to `small icons`.*  Click on the `System` option. 

<img src="../images-5-pc/system-choices.png" style="border:1px solid black">

3\.  Click on the `Advanced system settings` option at the left of the window.

<img src="../images-5-pc/system-properties.png" style="border:1px solid black">

4\. In the `System properties` window that pops up, click on `Environment variables...`

<img src="../images-5-pc/environmental-variables.png" style="border:1px solid black">

5\. In the `Environmental variables` dialog box, go to the bottom pane and scroll down to `Path`.  Click to select it, then click on the `Edit...` button below the pane.

<img src="../images-5-pc/edit-environmental-variable.png" style="border:1px solid black">

6\. In the popup dialog window, click on the `New` button. 

<img src="../images-5-pc/save-new-path.jpg" style="border:1px solid black">

7\. Type the path to the directory where the executable file is located, then click OK.

8\. Click OK in the previous dialog boxes until they all go away.  Close the System window by clicking on its `X` in the upper right.

After you have completed these steps, try re-executing the application that did not previously run.

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

I have a Jupyter notebook in my Documents folder that I want to run called `python-turtle.ipynb`.  I open Command Prompt, then enter 

```
cd Documents
```

to move from my home folder to the Documents subfolder.  Then I enter

```
dir *.ipynb
```

to list all of the files with the `.ipynb` extension.  I see that the notebook I want is there.

<img src="../images-5-pc/turtle-notebook-listing.png" style="border:1px solid black">

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

I get a message in the browser saying that the server is stopped and that I can close the tab.  When I look at my Command Prompt window, I see some messages related to the shutdown.

If I forget to shut down the server from the browser, I can still shut it down using the shell.  If I hold the `Control` key and press `C`, I'll see a question in the shell asking if I want to shut down the server.

**Note: Just closing the Command Prompt window does NOT stop the server.**

## Example workflow for Blazegraph

Note: console screenshots show the Mac Terminal application, but the behavior in Windows Command Prompt should be identical.

Assuming that Blazegraph has already been installed using Docker, I open Command Prompt and enter

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

1. Open a Command Prompt window.
2. Execute a command line command to start the server.
3. Enter an appropriate localhost URL in the browser URL bar.
4. Work
5. Execute a command line command to stop the server.
6. Close the brower.

Sometimes parts of this procedure will happen automatically (such as starting a server after double-clicking on an icon for OpenRefine, or automatically opening the correct browser page when running a Jupyter notebook), but in general, these steps always happen in a server-based application. 

Understanding what's going on here is important because often just closing the browser or the console window doesn't stop the server.  It will continue running in the background on your computer until the next time you shut the computer down.  That may slow down other applications and failing to shut down the server properly could cause data loss.  

----
Revised 2019-03-21
