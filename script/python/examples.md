---
permalink: /script/python/examples/
title: Python code examples
breadcrumb: Examples
---

# Some code examples to try

The examples below are appropriate for each week of the intro tutorial.

## Getting the examples onto your computer

There are two easy ways to get the examples onto your computer from Github.

1. Click the Raw button, then select all, copy, and paste into a blank page of your editor.

2. Right-click on the Raw button, then select "Save link as" (or similar options depending on your browser).  When prompted, navigate to the place where you want to save the file.  If you are planning to run from the command line, your home folder will be convenient.  (See step 3 of [this page](../editor/#workflow-for-editing-and-testing-python-code) if you don't know how to find your home folder.)

## Retrieving libraries that aren't in the standard library

Some modules that aren't included in the standard libary must be retrieved using the PIP application.  If you receive an error message saying that a package can't be found, retrieve it at the command line (in this example, the **requests** library):

On Windows:

```
pip install requests
```

On Mac:

```
pip3 install requests
```

## Week 1

[A simple script to retrieve data from a URL](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/api/python/http_request.py) - requires the **requests** library

[Uses the "turtle" drawing tool to make a shape](https://github.com/baskaufs/msc/blob/master/python/turn_right.py)

[Sets up a simple graphical interface with text boxes and a button](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/gui/python/simple_form.py)

----
Revised 2019-01-14
