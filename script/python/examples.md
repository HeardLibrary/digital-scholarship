---
permalink: /script/python/examples/
title: Python code examples
breadcrumb: Examples
---

# Some code examples to try

## Getting the examples onto your computer

There are two ways to get the examples onto your computer from Github.  First, click on the link to get to the appropriate page.  Then:

1. **Easy way:** If you are using Thonny or some other IDE, click the Raw button, then select all, copy, and paste into a blank file in your code editor.  You can then save the file.

2. **Harder way:** You can use this method if you want to edit the code in a code editor and run it from the command line.  Right-click on the Raw button, then select "Save link as" (or similar options depending on your browser).  When prompted, navigate to the place where you want to save the file.  If you are planning to run from the command line, your home folder will be convenient.  (See step 3 of [this page](../editor/#workflow-for-editing-and-testing-python-code) if you don't know how to find your home folder.)  You can open the file in your code editor or IDE to modify it.

## Links to examples

[Uses the "turtle" drawing tool to make a shape](https://github.com/baskaufs/msc/blob/master/python/turn_right.py).  The shape is drawn in a separate window that pops up. Try changing the numbers in the functions to see what happens.

[Sets up a simple graphical interface with text boxes and a button](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/gui/python/simple_form.py).  You can change the text boxes and when you click the button, different things will be printed in the shell window.

[A simple script to retrieve data from a URL](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/http_request.py) - This very small program checks whether a web page is working.  It returns a code of `200` if it's working.  You can uncomment line 5 (remove the `#` character) to see the raw text of the file that was retrieved.  Try changing the URL to some other web page to see what happens. **Note:** this script requires installation of the `requests` library if you don't already have it (i.e. if you aren't using Anaconda).  See the next section for info about installing packages.

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


----
Revised 2019-08-27