---
permalink: /script/python/
title: Python resources
breadcrumb: Python
---

# About Python

## Python basics

There are several features of Python that make it extremely popular.  One of the most important is that it is open source.  That means that anyone can download the software necessary to create and run Python programs for free.  

Another consequence of Python's open source status is that versions of Python have been created for most of the common platforms, including PC, Mac, and Linux.  There are also specialized varieties of Python that are designed to run faster, or work better with certain types of data.  So Python is very widely applicable.

A third important feature of Python is that it is relatively simple to learn and use.  Python is a relatively forgiving language that provides you with useful information about the errors that you've made and allows you to easily test your code as you write it.  That makes it very friendly to beginners.

A final significant aspect of Python is that many people have created add-ons, called packages, that can easily be installed to add functionality to the language.  That makes Python extremely versatile.

## Python 2 vs. Python 3

Version 2 of Python has been in wide use for many years.  So although it is no longer in development there is still a large amout of code out in the wild that is written in Python 2.  Since our focus is on helping new users who will primarily be using Python 3 in the future, our focus is on that version of the language.  Fortunately, most Python 3 code will also run as Python 2 (and vice versa) with minimal modification.

## The Anaconda option

Anaconda is an umbrella system for data science that includes many of the most important tools used in data science. Anaconda includes Python, several ways to use Python (Jupyter notebooks and the Spyder IDE), and it automatically installs many of the commonly used Python packages.  

If you want to start off with many major data science tools at once, you should consider [installing Anaconda](https://docs.anaconda.com/anaconda/install/).  However, since Anaconda includes so much stuff, it can eventually sprawl to gigabytes in size.  So if you are new to Python, you might start with a simpler Python distribution and upgrade to Anaconda later. (Note: if you upgrade to Anaconda, it reinstalls Python and may use a slightly earlier version than what is currently provided as the latest version at python.org.)

For more information about Anaconda, see [this page](../anaconda/)

# Ways to write and run Python

## Installing a Python distribution

The most basic way to run Python is to install a distribution on your computer, then issue commands one line at a time using the terminal (or "command prompt" on Windows).  

[Instructions for installing Python](install) (see also the note about Thonny below)

## Using an Integrated Development Environment (IDE)

An Integrated Development Environment is an auxillary program that makes it easier to write, test, debug, and run a programming language.  An IDE called IDLE is installed automatically when Python is installed.  Another IDE designed specifically for beginners is [Thonny](https://thonny.org/). Installing Thonny also installs Python 3.7 at the same time.  

[Instructions for getting started with Thonny](thonny)

## Using a code editor

A code editor is a specialized text editor that comes with tools that make it easier to write code in particular languages.  A very useful feature of a code editor is *syntax highlighting*, a feature that color-codes different elements of the program to make it easier to see the structure of the code and to notice errors.  Some code editors also provide features like error checking and automatic closing of tags like parentheses and quotes.  Two well known code editors suitable for use with Python are **Atom** and **Visual Studio Code**.  If you are a Github user, you may already be using [Atom](https://atom.io/) since it is commonly used to edit Markdown.  [Visual Studio Code](https://code.visualstudio.com/) (which is different from Microsoft's Visual Studio IDE) is a very full-featured editor with Python support.  It's included in the Anaconda distribution, so if you install Anaconda, you can easily install VS Code as well.  Both Atom and VS Code are free and both have Python plugins to handle Python-specific features.

When writing and testing Python code with a code editor, the code is written in the editor window and run separately by the command line in the terminal/command prompt window.  When a change is made in the editor and saved, re-running the code at the command line shows the effects of the changes that were made.

[Instructions for using a code editor to write Python](editor)

## Using Jupyter notebooks

Jupyter notebooks provide a way to document and run Python scripts interactively.  They operate by running a localhost webserver on your computer that you can interact with via a web browser.  Jupyter notebooks can run Python code as well as other scripting languages such as R.

Jupyter notebooks are particularly great if you are running code that is essentially linear - for example a data processing pipeline or data manipulation leading to a visualization.  However, Jupyter notebooks cannot display intermediate calculations taking place in loops or in function calls.  This makes them less useful for running more complex applications that make extensive use of loops and functions.

[More information about installing and using Jupyter notebooks](../jupyter/)

# Python in Geographic Information Systems (GIS)

[Some resources on using Python in GIS](../../geo/gis/python/)

# For more information

If you are new to Python, an excellent starting-off point is [Python For Beginners](https://www.python.org/about/gettingstarted/), part of the official Python website.  It contains links to a massive number of other resources, including tutorials, videos, books, lists of editors and IDEs, and code examples.

## DiSC Python lessons at Vanderbilt

The [Vanderbilt Libraries Digital Scholarship and Communications (DiSC) office](https://www.library.vanderbilt.edu/disc/) typically offers two cycles of Python lessons for beginners.  These lessons are given on the Vanderbilt campus and are free and open to anyone.  For more information about current offerings, see the [landing page for DiSC Python lessons](wg).

## O'Reilly for Higher Education resources

The Vanderbilt Libraries has a subscription to [O'Reilly for Higher Education](http://www.library.vanderbilt.edu/eres?id=1676) resources.  To access these resources, you need to have a Vanderbilt VUNet ID and password.  **Important note:** When you have finished accessing a resource, be sure to sign out and close the browser tab. If you don't you may not be able to log in the next time and need to delete your browser cookies in order to successfully log in.

The resources include access to the excellent O'Reilly books reference books, many training videos, and other interactive learning resources.  One example is the book Introducing Python (2nd Edition) by Bill Lubanovic, which can easily located using the search box on the website. You may be able to access it directly with [this link](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/introducing-python-2nd/9781492051374/).

## Books

[Dive Into Python](http://histo.ucsf.edu/BMS270/diveintopython3-r802.pdf) (by Mark Pilgrim) - free online pdf (Python 3). Also availible in print. 

[Programs, Information, and People text](https://www.programsinformationpeople.org/runestone/static/publicPIP/index.html) from a [course at University of Michigan School of Information](https://www.programsinformationpeople.org/runestone/).  Includes examples of using APIs and OAuth.

The Vanderbilt Science and Engineering Library has a number of books on programming in Python that are available for checkout.

## Websites

[Software Carpentry Programming with Python](http://swcarpentry.github.io/python-novice-inflammation/)

[Software Carpentry Plotting and Programming in Python](http://swcarpentry.github.io/python-novice-inflammation/)

[Library Carpentry Introduction to web scraping](https://librarycarpentry.org/lc-webscraping/)

[GLAM Workbench](https://glam-workbench.net/) - Tools and tutorials for working with data from galleries, libraries, archives, and museums (GLAM).

[Python IDEs and Code Editors (Guide)](https://realpython.com/python-ides-code-editors-guide/)

[Python 3.x documentation](https://docs.python.org/3/) - the official documentation for Python for the latest stable release of Python 3

[The Python Wiki](https://wiki.python.org/moin/) - The official user-editable guide to Python

[The Python (3) Tutorial](https://docs.python.org/3/tutorial/index.html) - The official tutorial of Python.  This tutorial systematically covers (with examples) the major features of Python.  It's a bit dry, however.

[LearnPython.org](https://www.learnpython.org/) - A Python learning tutorial supported by DataCamp.  A very cool feature of this site is its interactive on-screen editors, which allow you to hack pre-written code snippets and see what happens.

## YouTube video series

These series have not been vetted in any way - check them out at your own risk.

[Python for Beginners](https://www.youtube.com/playlist?list=PLlrxD0HtieHhS8VzuMCfQD4uJ9yne1mE6) - Microsoft Developer (142k subscribers but not exclusively Python)

[Python Tutorials for Absolute Beginners](https://www.youtube.com/playlist?list=PLBZBJbE_rGRWeh5mIBhD-hhDwSEDxogDg) - CS Dojo (747K subscribers)

[Python Programming Beginner Tutorials](https://www.youtube.com/playlist?list=PL-osiE80TeTskrapNbzXhwoFUiLCjGgY7) - Corey Schafer (202K subscribers)

[OSP - Python Beginner Series for Absolute Beginners](https://www.youtube.com/playlist?list=PLBZBJbE_rGRWeh5mIBhD-hhDwSEDxogDg) kjdElectronics - (58K subscribers)

----
Revised 2020-01-10
