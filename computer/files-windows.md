---
permalink: /computer/files-windows/
title: Files (Windows)
breadcrumb: Files (Windows)
---

# Understanding my computer - Lesson 1: Files

This is the Windows version of this page.  [Click for the Mac version of this page](../files-mac/)

## Your computer assumes that you are an idiot

One of the great advances in computing came about when computers were designed to be simpler and more intuitive.  With the creation of a *graphical interface* where users could point and click, it became possible for many people to use their computers without any real understanding of what they were doing.  The interface was a "desktop", and word-processing documents were placed in folders whose icons actually looked like little folders. 

As long as everything works as it should, this simplified interface is great and easy to use.  However, when things don't work as they should, your computer often hides the details that you need to be able to see in order to diagnose the problem.  Your computer assumes that if it lets you see what was actually going on, you would do something stupid and mess things up.

In this workshop, we assume that you are NOT an idiot and that you should be able to see and understand what's actually going on with your computer without messing it up.  If the situation is not too complicated, you should be empowered to take action yourself.  If the problem is very technical, you should know enough to be able to seek out the help that you need. 

**Tech tip: For many of the most common tasks that are done through menu choices, there is a shortcut key sequence that allows you to avoid having to go up to the menu and make a selection.  In many cases, you hold down on the `Ctrl` key and press some other key.  For example, the shortcut for print is usually to hold `Ctrl` then press `p`.  The shortcuts are often shown to the right of the menu item that they are equivalent to.**

# The illusion of the desktop

![Windows desktop](../images-1-pc/pc-desktop.png)

When I look at the screen of my computer, I see what appears to be a flat surface.  There are some images that I've "saved to the desktop" and it appears that those little pictures are actually sitting on the surface of my desktop.  However, this is an illusion that my computer creates.

## Where actually is my desktop?

<img src="../images-1-pc/pc-desktop-tree.png" style="border:1px solid black">

**Terminology tip: "directory" and "folder" mean the same thing.  We will use the terms interchangeably.**

In reality, the two image files are somewhere on the *hard drive* of my computer.  The hard drive is organized in a hierarchical way, called the *directory tree*.  A parent directory can contain a number of child directories, and those child directories can be parents of other child directories.  From the diagram above, you can see that there is a directory many layers deep called "Desktop".  That directory is an index that keeps track of the part of the hard drive that actually contains the two image files that I saw on my graphical desktop.  There isn't really anything special about that directory other than that the computer is set up to display its contents in a special graphical way that looks like a "desktop".

## What are users?

Long ago, personal computers could have only one user.  Now personal computers are set up to allow different users to log on and access their own files using personalized settings.  You may do some sort of login when you boot your computer, or your computer may be set up to log you in automatically.  

<img src="../images-1-pc/pc-settings.png" style="border:1px solid black">

To see what users are enabled on your computer, click on the Start icon (looks like a little window) at the lower left of your screen and click on the little gear. Click on Accounts.

![Logged on user account](../images-1-pc/my-account.png)

You will see a summary of the user that is logged in.  One important thing that you can see from this window is whether the current user is an *administrator user* or not.  If you are using your own computer, you generally should be logged on as an administrator user, otherwise you may be prevented from taking important actions like installing new software.  If you are using a work computer, you may not be an administator user.  In that case, there may be some changes that you won't be allowed to make on your computer.

![List of other user accounts](../images-1-pc/other-account.png)

Click on the item labeled `Family & other users`, then scroll down the screen to `Other users`.  You can see there if there are other users listed that are not currently logged in.

<img src="../images-1-pc/pc-other-desktop-tree.png" style="border:1px solid black">

Here is another view of the directory tree.  In the previous view, the `Desktop` folder was in the home folder of the logged in user (steve-bootcamp).  In this view, the `Desktop` folder was in the home folder of a non-logged in user (defaultuser1).  Both users have folders called "Desktop", but those folders are not the same.  As you can see, the defaultuser1 desktop folder is actually empty (vs. the steve-bootcamp user's desktop, which had the two image files).

Every user on the computer has its own Documents, Downloads, Music, etc. folders.  It can be confusing if you unknowingly log out from your normal user account and log on to a different one.  The graphical desktop and the contents of all of these familiar folders will be different because they aren't actually the same folders as your user folders (even though they have the same names).  

If you use your computer sometime and the desktop looks different, or folders and files appear to be missing, do not panic.  First, check whether you have accidentally logged in as a different user (then panic as necessary).

# Programs and files

**Tech tip: The usual way to work with files in Windows is with the *File Explorer*.  To launch File Explorer, click on the little file folder in the lower left of the screen.  It's usually the first icon after the search box.**

![Opening File Explorer](../images-1-pc/file-explorer.png)


## What is a file?

The fundamental unit of organization of information on a computer is a *file*.  A file is a set of *bytes* that are grouped together for some purpose and given a common name.  We will not worry about the details of what a byte is -- we can just imagine that it is some unit of information.  By itself, a byte doesn't have any meaning.  It is given meaning when we know the type of the file that it's included in.  For example, in a text file, a byte might represent a character like a number or letter.  In an MP3 file, a byte is a digital representation of some part of a sound.  In a JPEG image, a byte represents some component of the colored dots that are used to make an image. 

A file has several fundamental properties.  One is its size.  File sizes are measured in units of bytes.  The size of a tiny file may be measured directly in bytes.  The size of a small file can be measured in kilobytes (kb; approximately a thousand bytes).  A medium sized file's size can be measured in megabytes (Mb; approximately a million bytes).  A large file can have a size measured in gigabytes (Gb; approximately a billion bytes) or larger.  (What is considered "large" and "small" varies over time. Twenty years ago, a 1 Mb file would have been considered very large.)

Another property of a file is its last-modified date.  This is the last time that the file was changed.  The last-modified date can be really useful if you are searching for a file but don't remember its name, or for sorting files by how recently you worked on them.

File names and types are also important and will be discussed in detail below.

## File Properties

There are two ways in Windows that you can get information about a particular file.  

1. Right click on the file, then select `Properties` from the menu that opens.
2. Click on the file, then select `Properties` from the Home ribbon at the top of the File Explorer window.

<img src="../images-1-pc/file-properties.png" style="border:1px solid black">

The various tabs of the File Explorer window show all kinds of information about the file, including its kind, size, and modification date.  

## File names

Files are given names so that they can be found and recognized by humans or computer programs.  File names are a series of characters.  The rules about what characters can be used in file names vary among computer systems and programs that use the files.  In many cases, a computer system will let you get away with using unusual characters in a file name without complaining.  However, that same file name might cause a problem in another computer system.  Here are some good practices related to file names:

- The most "safe" characters to use in file names are letters, numbers, and underscore (`_`). Dashes (`-`) are almost always safe.
- It is not a good idea to put spaces in file names.  Most systems are fine with spaces, but there are infrequent circumstances when they cause problems.  Using spaces in file names is like not wearing your seat belt in a car.  99% of the time you can get away with it, but a small fraction of the time it causes problems.
- In many cases, systems that use file names are *case-insensitive*.  That means they don't distinguish between upper- and lower-case letters.  However, that is not always true. If you are sloppy about the case of file names (for example, naming a file "Myfile.docx", then referring to it as "myfile.docx"), you will usually get away with it, but on some occasions, the file won't be recognized if the case is wrong.  For that reason, it is a good general practice to use only lower-case letters in a file name unless you have a reason not to.  If you choose a system of capitalization that includes capital letters (such as [camelCase](https://en.wikipedia.org/wiki/Camel_case)), use it consistently.
- Usually it doesn't matter where you put numbers in a file name, but there are odd situations where having a file name that starts with a number could cause a problem.
- Don't use weird characters like parentheses in file names, even if the system you are using will let you.

Example of a "safe" file names:

```
my_little_pony_previous.xlsx
testing1234-old.png
userTrialResults-2018-03-27.csv
```

Examples of "unsafe" file names:

```
My little pony previous.xlsx
testing1234(old).png
27 March 2018 User trial Results.csv
```

## What is a program?

A *program* is a set of instructions that cause a series of actions to take place.  

**Terminology tip: An "application" is a program that can interact with a user.  In this context, we will use the terms "program" and "application" interchangeably.  The term "app" is more commonly used to describe programs on portable devices, but it's just short for "application".**

Programs are usually stored as files.  An *executable file* is a program that can run by itself and a *script* is often a file that contains commands that are carried out by some other program (sometimes called an *engine*). You can usually launch executable files by double-clicking on them.  Scripts have to be loaded into some other application after it is started up.

Here are some examples.  
- Microsoft Word is a program that is an application.  You double-click on an executable file to make it run.
- An R script can be stored in a text file.  When the text file is loaded into an application like RStudio, it can run and make things happen.  However, double-clicking on the script file itself won't generally make it run (although it might cause it to be opened for editing in RStudio).

## What does it mean for a application to be "running"?

In the olden days, a computer could only run one program at a time.  However, now computers routinely run many programs at once.  Many of those programs start running when the computer is booted up and you don't even know it.  The operating system itself is a big program that runs all the time when the computer is turned on.  

![Windows task bar](../images-1-pc/task-bar.png)

Applications that have been started up by the user are usually shown in the *task bar* at the bottom of the Windows desktop.  Icons of applications that are "pinned" to the task bar are there all the time, regardless of whether they are running or not.  Applications that are running have blue bars under them.  Applications that aren't pinned will show up in the task bar while they are running, but they will disappear when you exit them.

In Windows, to exit an application, all you need to do to exit an application is to click on the X in the last open window associated with that application.  Alternatively, you can right-click on its icon in the task bar, then select `Close window`.   

![Windows system tray](../images-1-pc/system-tray.png)

Some of the applications that started up automatically when the computer booted have icons in the *system tray* at the lower right of the Mac desktop. In this example, Dropbox and OneDrive (applications that started when the computer booted) are showing up there.  There are several other applications that were launched when the system booted that show up when you click on the up arrow on the left side of the system tray.  In most cases, clicking on these icons will bring up some kind of menu that tells you the status of the application, gives notifications, or allows you to change settings.  For example, clicking on the Dropbox icon will tell you whether file synching is up to date.

The most complete way to know about every program that is running on in Windows is to launch the Task Manager.  To start up the Task Manager, hold down on the `Ctrl` and `Alt` keys at the same time, then press the `Delete` key.  This key combination (sometimes called the Windows "three finger salute") is the method of last resort for getting your computer's attention when it's locked up.  From the menu that pops up, select `Task Manager`.  

![Windows task manager](../images-1-pc/task-manager.png)

Under normal circumstances, you are not likely to need to look at the Task Manager, but sometimes there are stubborn problems caused when a program won't finish quitting properly, or gets out of control and won't quit.  In the Task Manager, you can click on the name of the running App, then click on the `End task` button at the lower right of the window.  

**Note:** it is not advisable to use this as a routine way to quit programs, or to quit background processes whose purpose you don't understand.  However, the Task Manager is a way to discover if an application is a "hog" that is using up a lot of your system resources and slowing down other applications.  In other cases, you inadvertently run multiple copies of the same application, and one or more copies of the applications that are "stuck" may be preventing the applications that you see on your screen from running properly.  With Task Manager, you can shut down the multiple instances of the application, then restart it in the normal way.

# File associations and extensions

When discussing programs, we mentioned that script files generally can't run by themselves, but need to run within some other application.  Similarly, an image file can't display itself, an MP3 file can't make music by itself, and a Word document can't edit itself.  In all of these cases, the files are associated with some applcation that "knows" what to "do" with the file.  The connection between a type of file and the application that has been designated to handle it is called a *file type association*.  

The file type association is important, because it controls what happens when you double-click on the icon of a file that isn't an executable file (i.e. isn't a file that can run by itself).  "Opening" a file might mean opening it in an editor to change it, or it might mean making the file "do" something (like displaying an image, playing a sound file, or running a Python script).  In a lot of cases, whether opening a file allows you to edit it, or make the file do something may seem obvious.  Opening a word processing file generally means editing it, while opening a music file generally means playing it.  But in some cases, it isn't obvious.  You may be just as likely to want to edit a Python script as to run it when it's "opened".  We will learn how to control the behavior of "opening" files in a later section.

A *file extension* is a series of characters that follow the main part of a file name and are separated from it by a dot (`.`).  For example, if a file is named `gorilla.jpg`, then `.jpg` is the extension for that file.  File extensions are used to indicate the type of a file.  They are mostly (but not completely) standardized.

## How does my computer know what a file is "for"?

Windows computers track the type of a file by following the convention used by most of the computing world: use a file extension to know what kind of file it is.

Despite this, by default Windows computers hide the file extensions from their users.  Perhaps Microsoft thinks that file extensions will be too confusing to new users.  In the spirit of "you are not an idiot and don't need to be treated like one", we are going to learn how to turn off the hiding of file extensions.

## Unhiding file extensions

<img src="../images-1-pc/open-folder-options.png" style="border:1px solid black">

The easiest way to get to the File Explorer Options is to start typing "folder" in the search box at the lower left of the screen.  (Why "folder" and not "file explorer"? Dunno.)  When File Explorer Options appears, click on it.  When the window opens up, click on the View tab. 

In the Advanced settings section of the tab, there are a number of checkboxes for controlling how files and folders are displayed. 

Notice how icon labels look when the extension is being hidden:

<img src="../images-1-pc/hide-extensions.png" style="border:1px solid black">

Click to uncheck the `Hide extensions for known file types` checkbox, then click `Apply`. Notice that the labels under icons now show the file extension: 

<img src="../images-1-pc/show-file-extensions.png" style="border:1px solid black">

It is really pretty difficult to do anything very complex on your computer without being able to see file extensions, so you should leave them as visible.  

**Tech tip: It is also an insult to your intelligence that your computer hides files from you.  So while you have this dialog open, you should click the `Show hidden files, folders, and drives` radio button, then hit Apply.  Hidden folders often contain files that you shouldn't mess with, but there is definitely no harm in you being able to see them.  They show up as gray in File Explorer.**

Here are some common file extensions and the type of file they represent

| extension | type |
|----|----|
| .txt | plain text files |
| .csv | fielded text files (usually comma-separated values); generically spreadsheets |
| .jpg or .jpeg | Joint Photography Experts Group (JPEG) image files |
| .png | Portable Network Graphics (PNG) image files |
| .docx | Microsoft Word documents |
| .xlsx | Microsoft Excel spreadsheets |
| .pptx | Microsoft PowerPoint presentations |
| .json | Javascript Object Notation (JSON) data files |
| . xml | eXtensible Markup Language (XML) data files |
| .htm or .html | Hypertext Markup Language (HTML) web pages |
| .md | Markdown formatted documents |
| .mp3 | MP3 sound files |
| .wav | WAV sound files |

Notes:
- Notice that in some cases there are two commonly used file extensions for a format.
- In the case of files from Microsoft Office products, there is in each case an older format whose extension lacks the final "x".  For example: `.docx` and `.doc` are both used for Word documents.

## File type associations

On a particular computer, a part of the system settings is a list of applications that are associated with particular file types (and extensions).  Generally, file type associations get set as the part of the process of installing an application.  For example, when you install Microsoft Office, the file types typically associated with Office applications (.docx, .xlsx, pptx, etc.) are associated with the appropriate Office application.

However, sometimes a newly-installed application may "hijack" a file association by associating a previously assigned filetype to the new application.  For example, installing an open-source office suite might change the file associations to it instead of to Microsoft Office.  If the application is graceful, it will ask you whether you want to change the association before it makes the change.  However, sometimes applications make the change without consulting with you, which can be really annoying.

## Changing file associations

In Windows, it's relatively easy to look at the file type association list.  To get to the list, click the Start button in the lower left, then click on the settings gear.  

<img src="../images-1-pc/settings-apps.png" style="border:1px solid black">

Click on the `Apps` item.

<img src="../images-1-pc/default-apps.png" style="border:1px solid black">

Click on the `Default apps` option.

<img src="../images-1-pc/default-choices.png" style="border:1px solid black">

Scroll down the screen until you see a list of ways to choose default apps.  

<img src="../images-1-pc/pick-default-method.png" style="border:1px solid black">

Click on the `Choose default apps by file type` option.  It may take a few moments for the window to be populated with all of the file types.

<img src="../images-1-pc/default-app-by-extension.png" style="border:1px solid black">

Eventually, you will see a list of file extensions, with a description of the file type below them.  At the right of the screen, you can select what application should be associated with that file type.  If there is already an application, you can click on the option to change it.  If it says "Choose a default", you may have trouble finding an application that will work for that kind of file. 

Once you have changed the file type association, you have changed what happens when you double-click on a file of that kind.  For example, if you associate `.png` images with Photos, the file will be opened with the typical viewing options, such as setting up a slideshow.  However, if you associate `.png` images with Adobe Photoshop, double-clicking on `.png` images will launch Photoshop (if it isn't already running), then open the file in the Photoshop application.

When you are at the screen for selecting how to choose the default app, alternatively, you can click on `Set defaults by app`.  In that case, you will be presented with a list of applications installed on your computer.  Select an application, then click `Manage`.  That will present you a list of file types that could potentially be handled by that app.  In some cases, the file type might already be associated with the app, but in other cases, you might want to change the file type to the application that you are managing.  For example, CSV files may automatically have been associated with Microsoft Excel, but you might want to open them instead with OpenOffice Calc. 

## A final note on opening files

You should keep in mind that setting a file association only changes the application that opens a file type when you double click on the file icon.  You can always open an application first, then go to the file menu and select the `open` option.  The application will open the file if it's able, regardless of whether the type of that file is associated with it.  

This method is good if you usually open CSV files with a spreadsheet program, but want to actually look at the raw characters in the file by opening it in a text editor.

[go on to Lesson 2: Directories](../directories-windows/)

----
Revised 2019-02-28
