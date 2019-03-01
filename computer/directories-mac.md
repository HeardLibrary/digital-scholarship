---
permalink: /computer/directories-mac/
title: Directories (Mac)
breadcrumb: Directories (Mac)
---

# Understanding my computer - Lesson 2: Directories

This is the Mac version of this page.  [Click for the Windows version of this page](../directories-windows/)

[go back to Lesson 1: Files](../files-mac/)

# Directories

**Reminder: "directory" means the same thing as "folder"**

## The directory tree

The operating system works with the hard drive of your computer to manage a complex system for tracking the location of all of the bytes of data stored there.  Fortunately, we generally don't have to worry about that. The operating system has a built-in file management system that helps you keep track of where files are located.

In the first lesson, a directory was described as an index telling the computer where the data included in files were located on the hard drive of your computer.  That index also keeps track of the file names, sizes, modified dates, etc. -- all of the information we saw in the Get Info box in the first lesson.  Although as a practical matter there isn't a limit to the number of files you can put in a directory, it is difficult to manage a large number of files in a single directory.  For that reason, a hard drive can have many directories.

![directory tree](../images-2-mac/file-tree.png)

To help humans keep track of directories and files, the file management system lets users nest directories inside of other directories in a hierarchical manner.  There are a number of ways you can visualize this hierarchical structure, but the diagram above is typical.  Because of the branching nature of the directories, this organizational system is called the *directory tree*.  When organized in this way, the "tree" is upside-down, since its branches point down (unless you want to envision the branches as roots!).  But this arrangement is probably better since we refer to directories lower down on the diagram as *subdirectories* and talk about moving "up" the tree when we move towards the top of the diagram.

The very top of the tree is called the *root directory*.  You can think of it as sitting directly on the hard drive. It can contain first-level directories, and there can be second-level directories nested inside the first-level ones. There is theoretically no limit to the number of levels of nesting of directories within directories. Files can be located inside any directory, including the root directory.  

We can describe the position of a file within the directory tree using an expression called the *path* to the file.  The path describes the position of the file by listing all of the directories from the root to the file, in order and separated by forward slashes (`/`).  This system is also used by the Linux operating system (based on Unix), which is actually the underlying system on Macs.  

The root directory is simply a slash by itself, so the path to a file in the root directory (like file2 in the diagram) would be:

```
/file2
```

The path to files 3, 5, and 8 would be:

```
/b/file4
/b/c/file5
/b/c/e/file8
```

Note: for simplicity, the names used for the directories are a single letter, but they generally have the same naming rules as the rules for files.  The guidelines given for "safe" file names in the first lesson also apply to directory names.

**Tech tip: Annoyingly, the Windows operating system separates parts of the path with backslashes (`\`) instead of forward slashes. Otherwise, the way of specifying a path in Windows is the same as in the Unix system that Mac use.**

## Special directories on Macs

In the first lesson, we saw that several special folders in a Mac (Documents, Downloads, Pictures, etc.) were duplicated for each user of the computer.  These special folders (a.k.a. directories) are kept sorted out by placing them in what is known as the *home directory* for the user.  When a user logs onto the computer, the operating system takes note of which user home directory is appropriate, and uses that home directory as the basis of reference for the other special folders (Documents, Downloads, etc.).  

Because of the special status of the home folder, it has a special abbreviation in Linux: a tilde (`~`).  In the diagram above, the full path of `file6` would be:

```
/users/user1/file6
```

but it can be abbreviated as:

```
~/file6
```

This tilde shorthand can be thought of as "the home directory of whatever user is logged on".  If we want to refer to "file9 in the Documents directory of whatever user is logged on", we could say:

```
~/Documents/file9
```

This is convenient if we want to indicate, for example, that a file is in the Downloads folder of the current user, but don't actually want to have to specify who that user is.  If we used the full path starting with the root directory, we would have to include the user's home directory name in the path, and that would change if a different user logged in.

# Making Finder work the way you want

When you open a Finder window, its exact appearance is going to depend on how you've used Finder in the past, since it usually remembers how you had it set up the last time you used it.  There are certain modifications that you can do to make Finder easier to use based on how you like to organize things.  

![finder with sidebar and toolbar](../images-2-mac/finder-with-tool-sidebar.png)

## Sidebar and toolbar

There are two parts of the Finder window that you can choose to display or not.  The *toolbar* is at the top of the window.  It's most useful features are the back button, which allows you to go back to previous directories that you've viewed, and the set of four buttons that contol how the files are displayed (as icons, list, columns, or gallery).  The *sidebar* allows you to quickly jump to folders that you frequently use.  

You can control whether the toolbar and sidebar are visible or not by going to the Finder View menu and toggling `show toolbar`/`hide toolbar` option.  Unless you are really hard up for screen space, I recommend leaving them visible.  (You can also show or hide just the sidebar, but toggling the toolbar shows or hides both).  

Once the sidebar is visible, you can control what "favorite" folders are there in two ways.  To control which of the "special" folders are visible, click on a Finder window (or the Finder icon in the dock), then from the Finder menu, select `Preferences".  Click on the Sidebar tab.

<img src="../images-1-mac/sidebar-preferences.png" style="border:1px solid black">

Uncheck the boxes of any items you don't want to see and check any that you think you may use.  For these exercises, make sure that your home folder is checked (the icon that looks like a little house) as well as the Location that has your computer name (in this case, `erebus's MacBook Pro`).  When you are done, close the window by clicking on the red dot.  **Note: you can always go to any of the special folders by dropping down the Finder `Go` menu, then selecting the folder you want.**

<img src="../images-1-mac/add-favorite.png" style="border:1px solid black">

You can also add favorite "regular" folders to the sidebar.  Click and drag the folder over to the sidebar until a line shows up in the position where you want the folder to be, then drop it.  **Note: be careful that you see the line where the folder will be inserted between other folders on the list.  If you hold the folder *over* a folder in the list, you'll actually move the folder you were dragging *into* the folder on the list.**  If you add a folder to the favorites list, it is still in its original location in the directory tree as well.

To remove a "regular" folder from the sidebar, just click and drag it somewhere out of the sidebar so that an X shows up next to its icon.  Drop it and it will be removed.  (If you drop it from the sidebar into a directory that is being displayed, it won't be moved there.) 

## Finder display modes

If you don't have very many files on your computer, it doesn't matter much what display mode you chose to use.  The classice Mac viewing system is *icon view*.  The icon view is most useful when looking for images because you can see tiny thumbnails.  I find icon view the most annoying because it takes so many clicks to navigate.  When you double-click on a folder, you enter that nested folder.  To back out of that deeper level, you have to use the back button.  It is very easy to get lost if you are deep into the directory tree, but there is a feature that can help you.  

<img src="../images-1-mac/icon-view-and-path-bar.png" style="border:1px solid black">

In the Finder View menu, there is an option for `Show Path Bar`.  When you enable the path bar, you will see a little list of your path, from the highest level to the folder you are in.  This option is available in any display mode.

The gallery view is again mostly useful if you need to sort through images.

If you have a lot of files and many nested levels of directories, then you probably will either want to use the column or list view.  

<img src="../images-1-mac/column-view.png" style="border:1px solid black">

The column view is nice because it makes it easy to tell what level you are in on the file hierarchy. Because each level is shown in a different column, it is easy to jump up several level in the hierarchy with a single mouse click.  You can also scroll up and down at each level to see what's in the various levels without changing what's selected. The column view also has a nice preview feature that for certain file types can show you what's in the file without you having to open it.  The most annoying feature of the column view is that it shortens long file names and there is no way to adjust the column width to make the full names show up.  This can be a problem if you have a lot of files with long and similar names.

<img src="../images-1-mac/list-view.png" style="border:1px solid black">

You can avoid some of these problems with the list view. In the list view, you can always see the full file name -- if necessary, you can click and drag the column divisions at the top of the window to make the column wide enough to see the whole name.  You can navigate to deeper layers in the file hierarchy by clicking on the little triangles at the left of the folder names to expand that folder.  Each level in the hierarchy is indented to the right of the previous level.  An advantage over the column view is that you can see deeper into several folders at once by expanding each of them. The disadvantage of this viewing option is that it requires a lot of vertical space on your computer. If you have a lot of files or folders in a folder, you may not be able to see other parts of the directory tree without doing a lot of scrolling up and down the page, particularly if you have a wide screen that is not very tall.  Another disadvantage of this view is that there is no file preview.  However, the view does show you detailed metadata about the files and folders, such as when they were last modified and their size.  This is the only view that allows you to see these metadata, and you can quickly sort what's visible on the screen by clicking on the column header for the characteristic that you want to sort by.  For example, you can easily tell which files were most recently modified.

## Exploring the entire directory tree

<img src="../images-1-mac/finder-entire-directory-tree.png" style="border:1px solid black">

If you enabled display of your computer in the sidebar menu, click on it and select columns view.  If not, drop down the Finder `Go` menu and select `Computer`. From this point, you can dive down into the directory, starting with the root directory in your hard drive (probably named `macOS`), to the `users` directory, then to your home folder, and finally to your `Documents` folder.

<img src="../images-1-mac/documents-level.png" style="border:1px solid black">

Now for contrast, click on the Documents favorite in the sidebar.  You will go directly to your Documents folder.  Although if you've enabled the Show Path Bar, you'll know where you are in the directory tree, there is no simple way to go to a higher level than the one you chose from the sidebar Favorites.  This can be very annoying, so it's best to start your navigation in either the column or list view at the highest level in the directory tree in which you think you are likely to operate.

# Save file dialog

# Copying and moving files
