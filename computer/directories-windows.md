---
permalink: /computer/directories-windows/
title: Directories (Windows)
breadcrumb: Directories (Windows)
---

# Understanding my computer - Lesson 2: Directories

This is the Mac version of this page.  [Click for the Mac version of this page](../directories-mac/)

[go back to Lesson 1: Files](../files-windows/)

# Directories

**Reminder: "directory" means the same thing as "folder"**

## The directory tree

The operating system works with the hard drive of your computer to manage a complex system for tracking the location of all of the bytes of data stored there.  Fortunately, we generally don't have to worry about that. The operating system has a built-in file management system that helps you keep track of where files are located.

In the first lesson, a directory was described as an index telling the computer where the data included in files were located on the hard drive of your computer.  That index also keeps track of the file names, sizes, modified dates, etc. -- all of the information we saw in the File Properties box in the first lesson.  Although as a practical matter there isn't a limit to the number of files you can put in a directory, it is difficult to manage a large number of files in a single directory.  For that reason, a hard drive can have many directories.

![directory tree](../images-2-pc/file-tree.png)

To help humans keep track of directories and files, the file management system lets users nest directories inside of other directories in a hierarchical manner.  There are a number of ways you can visualize this hierarchical structure, but the diagram above is typical.  Because of the branching nature of the directories, this organizational system is called the *directory tree*.  When organized in this way, the "tree" is upside-down, since its branches point down (unless you want to envision the branches as roots!).  But this arrangement is probably better since we refer to directories lower down on the diagram as *subdirectories* and talk about moving "up" the tree when we move towards the top of the diagram.

On Windows systems, file storage drives are assigned *drive letters*.  The typical drive letter assigned to a computer's hard drive is `c`.  The drive letter is followed by a colon, so we would refer to the c drive as `c:`.  

The very top of the directory tree is called the *root directory*.  You can think of it as sitting directly on the hard drive. It can contain first-level directories, and there can be second-level directories nested inside the first-level ones. There is theoretically no limit to the number of levels of nesting of directories within directories. Files can be located inside any directory, including the root directory.  

We can describe the position of a file within the directory tree using an expression called the *path* to the file.  The path describes the position of the file by listing all of the directories from the root to the file, in order and separated by backslashes (`\`).   

The root directory is simply a backslash by itself.  When writing full paths in Windows, the directory path is written following the drive letter, so the full path to a file in the root directory (like file2 in the diagram) would be:

```
c:\file2
```

The path to files 3, 5, and 8 would be:

```
c:\b\file4
c:\b\c\file5
c:\b\c\e\file8
```

If there are other drives connected to the system, they are assigned different drive letters, such as `d:` or `z:`.  There is a directory tree within each of these drives, so

```
c:\b\c\file5
d:\b\c\file5
z:\b\c\file5
```

could all be paths to different files that were located on different drives.  Often, if we are only concerned with a particular drive, we will omit the drive letter from the path and the system will assume that the drive letter is the one for the current (most recently designated) drive.  A path like

```
\b\c\file5
```
would be valid, and would assume whatever drive letter was in current use.

Note: for simplicity the names used for the directories in this example are a single letter.  Normally, they would have longer names. In general, directories have the same naming rules as files.  The guidelines given for "safe" file names in the first lesson also apply to directory names. Although Windows generally supports spaces in directory names, using spaces in directory names is a **bad idea**!  In some programming languages and applications, spaces in file and directory names are NOT supported, so using spaces can "break" scripts and programs.  So don't use them!

**Tech tip: Annoyingly, the Mac operating system, which is based on Linux, separates parts of the path with forward slashes (`/`) instead of backslashes. Otherwise, the way of specifying a path on a Mac or Linux is the same as in the Windows system.**

## Special directories in Windows

In the first lesson, we saw that several special folders in Windows PC (Documents, Downloads, Pictures, etc.) were duplicated for each user of the computer.  These special folders (a.k.a. directories) are kept sorted by placing them in what is known as the *home directory* for the user.  When a user logs onto the computer, the operating system takes note of which user home directory is appropriate, and uses that home directory as the basis of reference for the other special folders (Documents, Downloads, etc.).  

A user's home directory is located in the `Users` directory, a first-level directory on the default hard drive of the computer (usually drive `c:`).  If the user's name is `user1`, this could be a path to the file `file6` in the user's home directory:

```
c:\users\user1\file6
```

# Making File Explorer work the way you want

When you open a File Explorer window, its exact appearance is going to depend on how you've used it in the past, since it usually remembers how you had it set up the last time you used it to look at a particular directory.  There are certain modifications that you can do to make File Explorer easier to use based on how you like to organize things.  

<img src="../images-2-pc/file-explorer.jpg" style="border:1px solid black">

## Navigation pane

There are two parts of the File Explorer window that you can choose to display or not.  The *ribbon* is at the top of the window.  The Home and View tabs are the most useful ones.  The Home tab allows you to perform tasks such as creating new folders and deleting files.  The View tab has many useful features and we will focus on it.

<img src="../images-2-pc/nav-pane-options.jpg" style="border:1px solid black">

The first item in the View tab is a dropdown that controls whether the second part (the *navigation pane*) is visible or not, and how it works.  You should check the `Navigation pane` checkbox if it isn't already checked.  Also check the `Expand to open folder` checkbox.  

The second set of items (`Preview pane` and `Details pane`) open and close panes at the right of the window that provides a preview of the contents or gives details of the selected file, respectively.  

The third set of items allows you to select how you want to view the files.  The two most useful view styles are `Details` and the various sizes of icons.  

<img src="../images-2-pc/large-icons.jpg" style="border:1px solid black">

The *Large icons* option is mostly useful for directories that contain images, since it presents reasonably sized thumbnails of images in the folder.  It's probably the easiest way to find a particular image from a large collection.  

<img src="../images-2-pc/details.jpg" style="border:1px solid black">

The *Details* option is probably the most useful of the remaining views. This view displays columns of metadata about the files, including the time when it was last modified and the file size.  You can sort by any of the columns, which is particularly useful for finding the most recently modified, or the oldest files.  

There is also a set of buttons in the lower right of the window that allows you to switch between displying item info and just displaying the icons.  It's best to just leave it selected to display item info and control the view style using the view ribbon options.

<img src="../images-2-pc/nav-pane.jpg" style="border:1px solid black">

The navigation pane is extremely useful for navigating around in the directory tree.  Near the top of the navigation pane is `This PC`, which is sort of the imaginary root of every file storage thing in the directory tree.  Located under it hierarchically are the "imaginary" places: Desktop, Documents, Downloads, Pictures, etc. that actually are located within the user's home directory.  Below them is the actual hard drive of the computer.  It might have various names, but can be recognized by its labeling as `(C:)`.  

<img src="../images-2-pc/expand-tree-view.png" style="border:1px solid black">

Any of these items can be expanded or collapsed by clicking on the arrow to the left of the folder icon.  The arrow points to the right for collapsed directories and points down for expanded directories.  At any point in the process of expanding the dirctory tree, you can click on a folder and its contents will be displayed on the pane to the right and the hierarchy will be displayed in the path bar below the ribbon.  If you checked the `Expand to open folder` option in the Navigation pane options, then double-clicking on a folder at the right will also automatically expand it in the navigation pane on the left.  

After you have gone down into deeper subdirectories of the directory tree, you can go back up the tree in two ways.  You can click the back button (left-facing arrow at the upper left) and it will return you to previous directories you have viewed.  You can also jump to any higher level in the path by single-clicking on a folder in the path bar.

***********

## Exploring the entire directory tree

<img src="../images-2-mac/finder-entire-directory-tree.png" style="border:1px solid black">

If you included your computer in the sidebar, click on it and select columns view.  If your computer isn't in the sidebar, drop down the Finder `Go` menu and select `Computer`. Starting on the level of your whole computer, you can dive down into the directory, starting with the root directory in your hard drive (probably named `macOS`), to the `users` directory, then to your home folder, and finally to your `Documents` folder.

<img src="../images-2-mac/documents-level.png" style="border:1px solid black">

Now for contrast, click on the Documents favorite in the sidebar.  You will go directly to your Documents directory.  Although if you've enabled the Show Path Bar, you'll know where you are in the directory tree, and you can easily jump to a higher level than the one you chose from the sidebar Favorites by simply double-clicking on the higher level in the path bar.  This feature is useful if you start exploring at a low level in the directory tree but later realize that you need to jump up to a higher level.

# Save file dialog

As a relatively new Mac user, I was somewhat horrified to discover the large number of users who seem to mostly save documents to their desktop instead of in some organized place in the directory tree.  I think part of the reason for that is that they weren't aware of the features available in the `Save as...` (or `Save...`) dialog from the `File` menu.  Fortunately, that dialog has many of the same features as Finder, so understanding how to navigate Finder will also help you do understand how to use the `Save as...` dialog effectively.

<img src="../images-2-mac/unexpanded-save-as.png" style="border:1px solid black">

By default, the `Save as...` dialog is in its abbreviated form.  Dropping down the `Where` list will let you choose any location that normally appears on your Finder sidebar.  But to navigate to other locations, you need to click on the small down arrow to the right of the `Where` dropdown. 

<img src="../images-2-mac/expanded-save-as.png" style="border:1px solid black">

The expanded `Save as...` dialog box allows you to navigate in a manner nearly identical to Finder.  To save space, the display style options are in a dropdown.  You can create a new folder in the current directory if you want to develop the directory tree in a way that makes sense for storing the file.  You can also drop down the `Where` option to jump to a higher position in the directory tree.  

# Copying and moving files

A very important aspect of working with files in Finder is understanding the effect of drag-and-drop.  In some cases, dragging and droping a file or folder causes it to be moved to the new location (moving), while in other cases, it causes a copy of the file to be created in the nwe location (copying).  Whether drag-and-drop results in copying or moving depends primarily on the place where the file is dropped relative to its starting location.

<img src="../images-2-mac/move.png" style="border:1px solid black">

In the example above, I'm dragging and dropping a file from the `Documents` directory to a subdirectory of `Documents` called `output`.  Both directories are located on my hard drive (called `macOS` by default), so Finder assumes that I want to *move* the file.  

<img src="../images-2-mac/move-result.png" style="border:1px solid black">

After I drop the file, I see that it has been moved to the new folder and is no longer in the old one.

<img src="../images-2-mac/copy.png" style="border:1px solid black">

In the second example, I'm dragging and dropping a file from my Documents folder to an external drive that I've connected to my system, called `oldbuffalo1`.  There are two ways I can see that Finder considers this to be a different drive rather than just a folder within my `macOS` drive.  To the left of the drive name, I see a little hard drive icon instead of a folder icon.  To the right of the drive name, I see an `eject` symbol that I should use when I want to remove the drive from the system.  Because I'm moving a file from one drive to another, Finder assumes that I want to *copy* the file.

This time, when I drag and drop, I see that a green circle with a plus sign inside it appears under the icon when I hover over the drive where I want to drop the file.  That means that the file I'm dragging will be added to the other drive as a copy.

<img src="../images-2-mac/copy-result.png" style="border:1px solid black">

Once I've dropped the file, I can see that Finder did indeed do a copy operation because the original file is still where it was before I did the drag and drop.

The plus sign appears regardless of the display style you've chosen for Finder.  

The bottom line is that if you are ever unsure about whether you are copying or moving a file, **look to see whether there is a green plus sign**.

## Dropbox and Box

Dropbox and Box are two common and similar systems used to synch local files on a computer with an analogous directory tree in the cloud.  You can use either system entirely by uploading and downloading files using a web interface, but it is far more convenient to set up folders in the cloud to by synched directly with directories on your local computer.  This section assumes that you have enabled this kind of synch to your local computer.

<img src="../images-2-mac/box-copy.png" style="border:1px solid black">

A very confusing thing happens when I compare what happens when I drag and drop to a Dropbox folder and a Box folder.  When I drag and drop to a Box folder, I see the plus sign (indicating that I'm performing a copy), but when I drag and drop to a Dropbox folder, I don't see the plus sign (indicating that I'm performing a move).  

<img src="../images-2-mac/box-as-drive.png" style="border:1px solid black">

I can get to the bottom of this apparent contradiction by scrolling down my Finder sidebar to the Locations section.  I see that Box is listed there (with an eject symbol), but Dropbox is not.  This tells me that the two systems are set up to operate in different ways.  Box folders are considered to live in a sort of virtual external drive, while Dropbox folders are just considered to be a sort of magical "regular" folder located on my hard drive.  

<img src="../images-2-mac/boxes-in-home.png" style="border:1px solid black">

I can understand the true situation by clicking on my home folder.  I see that actually both the root Box folder and the root Dropbox folder are subdirectories of my home folder.  The difference between them is some feature of the way that the synch application is set up to keep those folders synched with the server in the cloud - the operating system just considers them to be regular directories, more or less.  Locating them in the user directory makes sense because different users of a computer might have different Box/Dropbox accounts and putting them in the user directory allows the operating system to distinguish between the different user accounts.

## Alternatives to drag and drop

Dragging and dropping files is OK for moving single files, but selecting and moving/copying a particular set of files (or a large number of files) can be a bit unnerving.  Most people have probably had the experience of dropping files in the wrong place and struggling with how to undo the damage, particularly if a bunch if copied files get mixed in with a bunch of other files.  (A quick answer to the problem is to hold the `Command` key and press the `Z` key, which nearly always will undo the last action you've taken.)  The other issue we will deal with here is what to do if you actually want to copy (NOT move) files within a drive, or move (NOT copy) files between drives.

The best way to handle this situation is to select the files you want to copy, then copy and paste them.  You can select files by clicking and dragging, but you can get better control using shift-click or command-click.  

To select a *range* of files in a list, click on the first file in the list, then hold down on the `shift` key and click on the final file in the list.  To select *particular* files, click on the first one, then hold down on the `command` key and click on each of the other files to select them (or click a second time to de-select them).  You can also hold on the `command` key, then press on the `A` key to select *all* of the files in a directory.  

<img src="../images-2-mac/copy-items.png" style="border:1px solid black">

Once you have selected the set of files you want to copy, right-click on one of the files and select `Copy x Items` (where `x` is the number of items).  Alternatively, you can select `Copy x Items` from the Edit menu.

To **copy** the files, click on or in the directory where you want the files to be copied to, then right-click and select `Paste x Items` (or select `Paste x Items` from the Edit menu).  The files you selected should be copied (not moved) to the new folder. The sortcut for this action is holding on the `command` key, then pressing the `V` key.

To **move** the selected files to the new location instead of copying them, select and copy the files you want to move as described above, then click in the folder where you want them to go.  Hold down on the `command` and `option` keys at the same time, then press the `V` key.  (On a PC external keyboard, press the `command` key that looks like a window and the `alt` key at the same time, then press the `V` key.)

Note: using the copy and paste method distinguishes between moving and copying **solely based on how you do the paste**.  It does not depend on whether the operation is done within or between drives.  

[go on to Lesson 3: Installing software](../installation-windows/)

----
Revised 2019-03-18