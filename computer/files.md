---
permalink: /computer/files
title: Files
breadcrumb: Files
---

# Understanding my computer - Lesson 1: Files

## Your computer assumes that you are an idiot

One of the great advances in computing came about when computers were designed to be simpler and more intuitive.  With the creation of a graphical interface where users could point and click, it became possible for many people to use their computers without any real understanding of what they were doing.  The interface was a "desktop", and word-processing documents were placed in folders whose icons actually looked like little folders. 

As long as everything works as it should, this simplified interface is great and easy to use.  However, when things don't work as they should, your computer often hides the details that you need to be able to see in order to diagnose the problem.  Your computer assumes that if it let you see what was actually going on, you would do something stupid and mess things up.

In this workshop, we assume that you are NOT an idiot and that you should be able to see and understand what's actually going on with your computer without messing it up.  If the situation is not too complicated, you should be empowered to take action yourself.  If the problem is very technical, you should know enough to be able to seek out the help that you need. 

# The illusion of the desktop

![](images/mac-desktop.png)

When I look at the screen of my computer, I see what appears to be a flat surface.  There are some images that I've "saved to the desktop" and it appears that those little pictures are actually sitting on the surface of my desktop.  However, this is an illusion that my computer creates.

## Where actually is my desktop?

![](images/mac-desktop-path.png)

In reality, the two image files are somewhere on the hard drive of my computer.  The hard drive is organized in a hierarchical way, called the directory tree.  A parent directory can contain a number of child directories, and those child directories can be parents of other child directories.  From the diagram above, you can see that there is a directory many layers deep called "Desktop".  That directory is an index that keeps track of the part of the hard drive that actually contains the two image files that I saw on my graphical desktop.  There isn't really anything special about that directory other than that the computer is set up to display its contents in a special graphical way.

## What are users?

Long ago, personal computers could have only one user.  Now personal computers are set up to allow different users to log on and access their own files using personalized settings.  You may do some sort of login when you boot your computer, or your computer may be set up to log you in automatically.  

![](images/mac-system.png)

To see what 