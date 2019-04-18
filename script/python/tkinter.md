---
permalink: /script/python/tkinter/
title: TkInter graphical interface
breadcrumb: TkInter
---

Note: this is an addendum lesson to a beginner's introduction to Python.  For the whole schedule, see the [Vanderbilt Python Working Group homepage](../wg/)

[prevous lesson on data from the Internet](../internet/)

# TkInter Graphical Interface
 
 Although Python isn't the greatest platform for building applications with graphical user interfaces (GUIs), it does include the tkinter module creating GUIs.  In a number of previous lessons, we've played around with using tkinter to create GUI versions of the scripts we wrote.  Here we'll present a brief overview since it's a significant possible method of user input and output.

 The primary object of tkinter is an instance of the `Tk` class.  A `Tk` instance is usually the main *window* of an application.  The various items in the window (buttons, text boxes, dropdown lists, etc.) are called *widgets*.  Within the main window, widgets are organized in *frames*. 

 As with everything else in Python, widgets are objects.  So they are usually created by assigning an instance of their class to a variable.  Since a window is likely to have more than one button or more than one text box, the different instances can be disginguished by their different variable names.  

 Just instantiating a widget does not make it appear in the window.  The widgets are placed into a frame in one of two ways.  They can be *packed*, which basically means they are stuck into the frame in the order in which they are packed, or they can be assigned to a position in a *grid*.  The grid positions are referenced by their row and column and are relative.  Column 5 is to the right of column 3, but there doesn't have to be any column 0, 1, or 2, nor does there need to be a column 4.  The widths and heights of the columns and rows are determined by the size of the largest widget in that position.  A particular frame must either be populated by packing or by a grid -- you can't mix the two.

 Each widget has a number of attributes and methods.  Some attributes are standard across widgets, such as `.width`, and can be assigned when the widget is instantiated by including them as arguments.  However, generally you need to read the documentation about each particular widget to know how to set it up.  The documentation can be complex, so it is often helpful to find an example to see how the widget is used in actual practice. 

 Note that the TkInter interface is event-driven.  That means that while the program is running, it waits for an action on the part of the user (such as clicking a button) before executing code.  That requires associating functions with particular objects so that the function is triggered when something happens to the object.  The details of this are beyond the scope of this tutorial, so having an example template is helpful.

 The documentation for TkInter is at [this page](https://docs.python.org/3/library/tkinter.html)


-----
Revised 2019-04-18
