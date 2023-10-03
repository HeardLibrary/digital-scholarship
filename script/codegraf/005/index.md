---
permalink: /script/codegraf/005/
title: CodeGraf - Using code libraries
breadcrumb: OO5
---

Previous lesson: [Python programming basics](../004)

# Using code libraries

This lesson explains how to import modules from the Python Standard Library. It introduces the concept of methods associated with a class.

**Learning objectives** At the end of this lesson, the learner will:
- import functions from a module in three ways
- print the current time and delay the execution of a script
- assign the path of the current working directory to a string
- describe the relationship between methods and functions
- explain the syntax for writing methods of an object
- use the `.upper()` method to turn a string to all uppercase letters.

Total video time: 33m 35s

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/005/005.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1YxO98U9HbbQsNzeTVmLsWnh0DD8bHxSC)

[Lesson slides](../slides/lesson005.pdf)


# The import statement

## Introduction to the import statement (3m34s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/wqJM9a75AvA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A *module* is reusable code stored in a separate file. Functions can be imported from a module using an `import` statement. 

Modules in the Standard Library are included in the normal Python distribution. Functions in the Standard Libarary that aren't built-in must be imported.

**Forms of the import statement**

Import a single function:
```
from math import sqrt
answer = sqrt(3)  # don't need to include the module name
```

Import the whole module:
```
import math
answer = math.sqrt(3)  # prefix the function name with the module name
```

Import the module and abbreviate:
```
import math as m
answer = m.sqrt(3)  # prefix the function name with the module abbreviation
```

----

## Using the import statement (3m08s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/EeJ5hkpcqaQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example - Import a single function:
```
from math import sqrt
answer = sqrt(2)
print(answer)
```

Example - Import the entire module:
```
import math
pi = math.pi # modules can include constants (unchanging variable values)
print(pi)
answer = math.cos(pi)
print(answer)
```

Example - abbreviate the imported module name
```
import math as m
answer = m.log10(1000)
print(answer)
```

----

## The time module (2m28s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/2YxQSqQ8tnA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example:
```
# Import the time module
import time

# Print current local time as a formatted string
# "Local time" may be ambiguous if running in the cloud!
print(time.strftime('%H:%M:%S'))
print("I'm going to go to sleep for 3 seconds!")

# Suspend execution for 3 seconds
time.sleep(3)
print("I'm awake!")
print(time.strftime('%H:%M:%S'))
```

Note that some functions return a value, as in the first example where the current time is returned, then printed. But some functions do not return any value. Rather, they just do something, as in the second example, which makes the script pause for a certain number of seconds. 

----

## The os (operating system) module (3m12s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/NHy1a6KhihU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example:
```
import os

working_directory = os.getcwd()
print(working_directory)
print(os.listdir()) # no argument gets working directory
# print(os.listdir(working_directory + '/Documents'))
```

----

## What if a module isn't in the Standard Library?

In the examples we have used so far, the modules we have wanted to import have been included in the Standard Library, so we have been able to load them using an `import` statement. However, sometimes when you try to import a module that you've seen in code examples, you will receive an error message saying that the module can't be found. In that case, the library containing that module isn't downloaded to your computer and it must be installed. (Note: we will use "package" and "library" interchangeably and ignore their technical differences.)

The libraries that are installed automatically will depend at least partly on how you installed and are using Python. If you are using Jupyter notebooks installed as part of an Anaconda distribution, many of the commonly used modules not included in the Standard Library will be available to you without needing to install them. The same is true with Colab. If you did a stand-alone installation of Jupyter notebooks, you are more likely to need to install additional libraries. 

There are two common installation methods. The standard method uses `pip`. If you are using Anaconda, it comes with its own package manager, `conda`. Both of these applications are used in the console (`Command prompte` on Windows or `Terminal` on Mac.) Here is an example of how to install a commonly used package: `requests`. In the console, enter the following:

```
pip3 install requests
```

If it doesn't work on your computer, then try it again without the "3":

```
pip install requests
```

(Depending on your installation, the "3" may be important if `pip` without the "3" installs Python 2 packages.) You will see lines of printout but eventually you should see a prompt again. Once the installation is complete, you should be able to use the library in your Jupyter notebook.

**Note:** The name of the library to be installed is often, but not always, the name of the module that you will load. For example, the commonly used BeautifulSoup library is installed using

```
pip install beautifulsoup4
```

but is typically loaded in code using

```
from bs4 import BeautifulSoup
```

where `bs4` is the actual module name. Check the documentation for the library to make sure what the name is of the library before installing (for example [this](https://pypi.org/project/beautifulsoup4/) for BeautifulSoup).

## Installing modules in the Colab or other notebook environment

Since you cannot easily access the Colab runtime environment through a terminal window, you can't issue the `pip` command directly from a command line. Fortunately, the `iPython` notebook system (used by both Jupyter and Colab notebooks) includes several ways to run command line commands.

One way is to use "[magic commands](https://ipython.readthedocs.io/en/stable/interactive/magics.html)". When a code line begins with a percent sign (`%`), it is interpreted as a special "magic" command rather than a Python command. Here's how you would install the `requests` library in a notebook environment:

```
%pip install requests
```

(Note that in Colab you don't actually need to do this, since `requests` is already installed by default.) There is also a magic `%conda` command if you are using the Conda package manager that is installed with Jupyter notebooks in the Anaconda distribution.

Another option for running `pip` is to begin the line with an exclamation mark (`!`), which runs the following text as if it were given from the command line. Using that method, you would enter:

```
!pip install requests
```

However, the magic command method is probably better since it automatically installs the module using the version that is correct for the version of Python that is running the notebook.

If you are running Jupyter notebooks in your local environment, you don't need to run these install commands every time you run the notebook, since the installation will persist on your local hard drive. However, Colab spins up a new cloud server for you each time you re-open a Colab notebook. So on Colab, you need to do the install each time you open the notebook for a new session. (There are ways to "permanently" install libraries in Colab, but they are more complicated than what we want to get into in this lesson. See [Stack Overflow](https://stackoverflow.com/questions/55253498/how-do-i-install-a-library-permanently-in-colab) for details.)

----

# Methods

## Introduction to methods (4m20s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/GvN58T_V1tU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Particular *objects* are instances of generic *classes*.

*Methods* are associated with particular classes of objects. Any instance of a class can use a method associated with that class. 

A method is essentially a function that is linked to a class.

The form of a method is: `object.method()`. 

Arguments may be passed into a method. A method may produce a return value or it may carry out an action without returning anything.

----

## String class methods (1m08s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/1zWgFlzXqKQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Some string class methods are: `.upper()`, `.lower()`, and `.title()`.

Example:
```
# instantiate a string object
my_message = 'Do not yell at me, Steve!'

# apply the .upper() method to the string object
shouting = my_message.upper()
print(shouting)

ee_cummings = my_message.lower()
print(ee_cummings)
my_book = my_message.title()
print(my_book)
```

----

## Imported function or method? (1m44s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/hSd3zVXVIRI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

When looking at someone else's code, you can tell whether an object like `something.otherthing()` is a function from the `something` module or a method of a `something` object by looking at the code. If the top of the code has a statement like:

```
import something
```

then it is a function imported from the `something` module. If the code has a statement somewhere like:

```
something = something_else
```

where an object is assigned to a variable named `something`, then it is a method of a `something` object. 


----

## Optional video: The datetime module (9m08s)

The following video covers content that is not required, but you might find it useful.

<iframe width="1120" height="630" src="https://www.youtube.com/embed/RSRLhxu9_Ek" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The datetime module defines several kinds of objects. Two of them are: `date` and `datetime`.

*Date* objects can be instantiated by specifying their year, month, and day: `datetime.date(2001,9,11)`. They can also be instantiated using the `.today()` method: `datetime.date.today()`.

Example:
```
import datetime

# Instantiate two date objects, numeric arguments required.
sep_11 = datetime.date(2001,9,11)
this_day = datetime.date.today() # method sets the date value as today
print(type(sep_11))

# Create various string representations of the date objects
print(sep_11.isoformat()) # use ISO 8601 format
print(sep_11.weekday()) # numeric value; Monday is 0
print(sep_11.strftime('%A')) # '%A' is a string format code for the day
print()
print(this_day.isoformat())
print(this_day.weekday())
print(this_day.strftime('%A'))
```

*DateTime* objects can be instantitated using the current UTC (i.e. Greenwich Mean Time) time using the `.utcnow()` method: `datetime.datetime.utcnow()`.

Example:
```
import datetime

# Instantiate a dateTime object
# The dateTime will be expressed as Universal Coordinated Time (UTC)
# a.k.a. Greenwich Mean Time (GMT)
right_now = datetime.datetime.utcnow()
print(type(right_now))

# Create string representations of the datetime object
print(right_now.isoformat())
# See the datetime module documentation for the string format codes
print(right_now.strftime('%B %d, %Y %I:%M %p'))
```

Both `date` and `datetime` objects are abstract and don't have any particular representation. They can be represented as strings using several methods. The `.isoformat()` method represents them as strings according to the ISO 8601 standard. The `.strftime()` method represents them as strings based on user-defined string format codes.  

Notice how this differs from the `strftime()` function from the `time` module. The `strftime()` function returns a string object. It does not create an instance of any abstract object. In contrast, abstract `date` and `datetime` objects are created by the `datetime` module. They are not strings, but string representations of them can be created by several methods.

----

# Practice assignment

The questions for the practice assignment are in this [Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/005/005_practice.ipynb). It is also available as a [Colab notebook](https://colab.research.google.com/drive/1EwJI9lyeXnzxLJCNr4omnXzG_oK16u5K?usp=sharing). You will need to [make a copy of it in your own drive](../003a#running-someone-elses-colab-notebook-3m35s) before editing it.

For feedback on the assignment, change the sharing properties to allow access for anyone with the link, and send the notebook link to the instructor.

----

Next lesson: [Lists and dictionaries](../006a)

----
Revised 2023-10-03
