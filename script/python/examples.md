---
permalink: /script/python/examples/
title: Python code examples
breadcrumb: Examples
---

# Some code examples to try

The examples below are appropriate for each week of the intro tutorial.

## Getting the examples onto your computer

There are two easy ways to get the examples onto your computer from Github.

1. Click the Raw button, then select all, copy, and paste into a blank file in your code editor.  You can then save the file.

2. Right-click on the Raw button, then select "Save link as" (or similar options depending on your browser).  When prompted, navigate to the place where you want to save the file.  If you are planning to run from the command line, your home folder will be convenient.  (See step 3 of [this page](../editor/#workflow-for-editing-and-testing-python-code) if you don't know how to find your home folder.)  You can open the file in your code editor or IDE to modify it.

## Retrieving libraries that aren't in the standard library

*Note: For instructions on installing packages in Thonny, see [these instructions](../thonny/#installing-a-package-in-thonny).*  

Some modules that aren't included in the standard libary must be retrieved using the PIP application, Python's standard package manager.  If you receive an error message saying that a module can't be found, like this: 

<img src="../images/no-module.png" style="border:1px solid black">

retrieve the package at the command line (in this example, the **bs4** package):

On Windows:

```
pip install bs4
```

On Mac:

```
pip3 install bs4
```

<img src="../images/pip-install.png" style="border:1px solid black">


## Week 1

[A simple script to retrieve data from a URL](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/http_request.py) - requires the **requests** library; does not seem to work in Thonny even when the requests package is installed

[Uses the "turtle" drawing tool to make a shape](https://github.com/baskaufs/msc/blob/master/python/turn_right.py)

[Sets up a simple graphical interface with text boxes and a button](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/gui/python/simple_form.py)

----
Revised 2019-01-15