---
permalink: /script/codegraf/ees2/
title: EES 2580 - Using code libraries and lists
breadcrumb: ees2
---

Previous lesson: [Python programming basics](../ees1)

# Using code libraries and lists - EES 2580

This lesson explains how to import modules from the Python Standard Library. It introduces the concept of methods associated with a class. We also introduce a complex object: *lists*. A list is a named one-dimensional data structure that allows us to store any number of items and reference them by an *index*. The lesson describes several ways lists are created. It also introduces some ways to manipulate and edit lists. 

**Learning objectives** At the end of this lesson, the learner will:
- import functions from a module in three ways
- print the current time and delay the execution of a script
- describe the relationship between methods and functions
- explain the syntax for writing methods of an object
- use the `.upper()` method to turn a string to all uppercase letters.
- describe a list object.
- construct a list by specifying its members.
- refer to a list item by its index.
- create lists using functions and methods.
- extract part of a list by slicing.
- randomize or order (alphabetize) a list.
- randomly select an item from a list.
- modify, remove, or add a list item.

Total video time: 41 m 36 s (plus 16 m optional)

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/ees2/ees2.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1SI83Hg3GuTm72nvA61AFQCgFuIdCcDCS?usp=sharing)

[lesson slides](ees2.pdf)

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

## What if a module isn't in the Standard Library?

In the examples we have used so far, the modules we have wanted to import have been included in the Standard Library, so we have been able to load them using an `import` statement. However, sometimes when you try to import a module that you've seen in code examples, you will receive an error message saying that the module can't be found. In that case, the library containing that module isn't downloaded to your computer and it must be installed. (Note: we will use "package" and "library" interchangeably and ignore their technical differences.)

The libraries that are installed automatically will depend at least partly on how you installed and are using Python. If you are using Jupyter notebooks installed as part of an Anaconda distribution or Colab notebooks, many of the commonly used modules not included in the Standard Library will be available to you without needing to install them. If you did a stand-alone installation of Jupyter notebooks, you are more likely to need to install additional libraries. 

There are two common installation methods. The standard method uses `pip`. If you are using Anaconda, it comes with its own package manager, `conda`. Both of these applications are used in the console (`Command prompt` on Windows or `Terminal` on Mac.) Here is an example of how to install a commonly used package: `requests`. In the console, enter the following:

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

----

## Installing modules in a notebook environment

If you are running a Jupyter on your local computer (vs. in the cloud on Colab) you can issue the `pip` (or `pip3`) command directly from a command line prompt.

However, in some situations such as Colab or a Jupyter notebook running on a remote server using Jupyter Lab, you cannot easily access the environment through a terminal window. In that case, you can't issue the `pip` command directly from a command line. Fortunately, the `iPython` notebook system (used by both Jupyter and Colab notebooks) includes several ways to run command line commands from within the notebook itself.

One way is to use "[magic commands](https://ipython.readthedocs.io/en/stable/interactive/magics.html)". When a code line begins with a percent sign (`%`), it is interpreted as a special "magic" command rather than a Python command. Here's how you would install the `requests` library in a notebook environment:

```
%pip install requests
```

There is also a magic `%conda` command if you are using the Conda package manager that is installed with Jupyter notebooks in the Anaconda distribution.

Another option for running `pip` is to begin the line with an exclamation mark (`!`), which runs the following text as if it were given from the command line. Using that method, you would enter:

```
!pip install requests
```

However, the magic command method is probably better since it automatically installs the module using the version that is correct for the version of Python that is running the notebook.

If you are running Jupyter notebooks in your local environment, you don't need to run these install commands every time you run the notebook, since the installation will persist on your local hard drive. In a cloud environment, you may need to run the install command every time you start the notebook, since the environment is reset each time you start a new notebook.

----

## The `requests` module

The `requests` module is a super-useful module that allows us to retrieve information from the web. Although the `requests` module is not part of the Standard Library, it may already be installed in your environment (e.g. if you are using Anaconda or Colab). You can find out whether it is installed in your environment by trying to import it using the command below. If it is installed, the line will execute without problems. If it is not installed, you will receive an error message. 

```
import requests
```

If you receive an error message, you can install the `requests` module using the `pip` command as described above.

The `get()` function of the `requests` module retrieves a web document. If the document is an HTML web page, it's not that useful, but if the document contains data, it's an easy way to access those data. The argument passed into the function is the URL of the document.

We can retrieve the text of the U.S. Declaration of Indepencence from [this GitHub document](https://github.com/Veraticus/cryptolalia/blob/master/test/fixtures/Declaration%20of%20Independence.txt):

```
url = 'https://raw.githubusercontent.com/Veraticus/cryptolalia/master/test/fixtures/Declaration%20of%20Independence.txt'
reply = requests.get(url)
print(type(reply))
```

This code shows us that the `reply` variable contains a custom `Response` object. We can examine some attributes of the response like this:

```
print(reply.text)
print()
print(reply.status_code) # 200 = OK, 404 = not found
```

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

# Lists

## Introduction to lists (5m48s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/AhkagcbtDw4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A list is a sequence of objects.  The objects may be the same or different, but often are the same.  The order of the list is important and items can be referenced by their position in the list, numbered from zero.  

A list is created by putting the sequence in square brackets, separated by commas.  In the following example, a list is assigned to a variable:

```python
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
```

To reference a particular item, write the variable name followed by square brackets containing the index (position) of the object in the sequence: `basket[2]`.

To determine the count of items in a list, use the `len()` function.  In this example, it would be `len(basket)`, which would have a value of 5.  


----

## Lists as output of functions (5m44s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/X1lSuOQbliA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`listdir()` function is part of the optional content.

`sample()` function from random module

[`random` module documentation](https://docs.python.org/3.3/library/random.html)

```
import random

population = int(input('How many items in hat? '))
n = int(input('How many items to draw from hat? '))
# sample without replacement
pull_from_hat = random.sample(range(population), n) # first argument is a range object, second is number of samples
print(pull_from_hat)
```

`.split()` string method

```
my_sentence = 'It was a dark and stormy night.'
words_list = my_sentence.split(' ')
print(words_list)
```

Using data retrieved from the web:

```
path = 'https://raw.githubusercontent.com/Veraticus/cryptolalia/master/test/fixtures/Declaration%20of%20Independence.txt'
response = requests.get(path)
file_text = response.text
lower_case = file_text.lower() # Turn all of the text into lower case
lower_case.split('\n') # Split by newlines to get each line as a list item.
```


----

## Slicing a list (5m07s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/mGnQCI6RcCk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A *slice* of the list can be referenced using the following notation: `basket[1:4]`.  **Important note: in Python, when ranges are specified, for some reason, the last number in the range is one greater than the actual position in the range.**  So in this example, items 1 through 3 will be included. Since counting in Python is zero based, that means that the slice will contain the second through fourth items.

```
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
a_slice = basket[1:4]
print(a_slice)

# Slicing from the beginning
print(basket[:4])

# Slicing to the end
print(basket[2:])

# Slice relative to the end
print(basket[-2:])
```

Retrieving parts of strings uses the same notation as lists.  (You can essentially think of a string as a list of characters.)  So to get a particular character:

```python
nobelPeacePrize = 'Dag Hammarskj\u00f6ld'
print(nobelPeacePrize[2])
```

and to get part of a string, use a slice:

```python
nobelPeacePrize = 'Dag Hammarskj\u00f6ld'
print(len(nobelPeacePrize))
print(nobelPeacePrize[12:15])
```

Notice that escaped characters count as a single character even if we write them as an escape sequence using several characters.


----

## Manipulating lists (4m15s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/E4DgTGHn0S8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


**Randomize** a list. Use the `shuffle()` function from the `random` module.

Pass in the list to be randomized as the argument.

There is no return value.

```
import random as r

cards = ['Ac', '2c', 'Jc', 'Qc', 'Kc', 'Ah', '2h', '3h']
# Shuffle acts on the list object. It does not return a list.
r.shuffle(cards)
print(cards)
```

**Sort** a list. Use the `.sort()` list method. 

No argument is required, although the argument `reverse=True` can be passed to sort descending (or reverse alphabetical order).

There is no return value

```
day_list = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
# Sort acts on the list item. It does not return a list.
day_list.sort()
print(day_list)
day_list.sort(reverse=True)
print(day_list)
```

Sort all of the words in the Declartion of Independence:

```
sorted_words = lower_case.split(' ') # Split by spaces to get each word as a list item.
print(sorted_words)
sorted_words.sort()
print(sorted_words)
```

Pick a **random item** from a list. Use the `choice()` function from the `random` module.

The list to pick from is passed in as an argument.

The return value is the selected list item.

```
day_list = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
# Choice returns a single item from a list
print(day_list)
picked_day = r.choice(day_list)
print(picked_day)
```

----

## Modifying a list (4m20s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/d5CWyyg_vQ4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

To add an item to a list, use the `.append()` method.  Here is an example:

```python
basket.append('durian')
```

Notice that there is no assignment with this method -- you simply apply it and the list itself is changed. 

A list can also be empty.  You can create an empty list like this:

```python
hungry = []
```

You can then add items to the list using the `.append()` method. 

To change an item in a list, just assign a new value to that item:

```python
basket[1] = 'tangerine'
```

To find the position of an item in the list, use the `.index()` method. You can combine this with the previously described statement to replace an item. This is useful if you don't know the position of an item in the list.

```python
basket[basket.index('banana')] = 'plantain'
```

To remove an item from the list using its value, use the `.remove()` method:

```python
basket.remove('banana')
```

You can also delete an item using its index number:

```python
del basket[3]
```

To insert an item at a particular position in the list, use the `.insert()` method. The first argument is the position and the second is the item to be inserted.

```python
basket.insert(1, 'applesauce')
```

Two lists can be combined using the `+` operator.  

----

# Practice assignment

**Instructions:**  The questions for the practice assignment are in this [Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/ees2/ees2_practice.ipynb). Download it to your local drive within the GitHub repository you created for this course.

When you've finished the assignment, be sure to save a final time. Do not clear the output so that viewers can see what the output was when you submit the assignment. Commit the changes to the repository and push the changes to the remote repository on GitHub.  

Go to the web page for the repository on GitHub and locate the notebook. Submit the link for the notebook web page to Brightspace as instructed.


----

# Optional videos

The following videos cover content that is not required, but you might find them useful.

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

## The datetime module (9m08s)

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

**Optional practice** (if you want to practice using the datetime and time modules):

1. Import the datetime module abbreviated as `dt`. Instantiate `now` as a date and as a datetime using the abbreviation, and print the value of `now`. You will probably need to look at the examples. If you get stuck, you can watch the video below.


## Optional practice script 1 (3m41s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/rYqBBtQ0xgs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----


Next lesson: [Dictionaries and loops](../ees3)

----
Revised 2024-02-01
