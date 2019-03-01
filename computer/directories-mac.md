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

## Special directories on Macs



**Tech tip: Annoyingly, the Windows operating system separates parts of the path with backslashes (`\`) instead of forward slashes. Otherwise, the way of specifying a path in Windows is the same as in the Unix system that Mac use.**