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

[Lesson Colab notebook](https://colab.research.google.com/drive/1SI83Hg3GuTm72nvA61AFQCgFuIdCcDCS?usp=sharing)


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

The libraries that are installed automatically will depend at least partly on how you installed and are using Python. If you are using Jupyter notebooks installed as part of an Anaconda distribution or Colab notebooks, many of the commonly used modules not included in the Standard Library will be available to you without needing to install them. The same is true with Colab. If you did a stand-alone installation of Jupyter notebooks, you are more likely to need to install additional libraries. 

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

----

## The `requests` module

The `requests` module is a super-useful module that allows us to retrieve information from the web. Although the `requests` module is not part of the Standard Library, it is already installed in Colab. So we can use it in a Colab notebook just by importing it.

```
import requests
```

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

**Instructions:** Go to the [practice assignment Colab notebook](https://colab.research.google.com/drive/1EEc8D-hBvXAh9tkZu83fR0jZFQDI2DnM?usp=sharing) and make a copy in your own drive as you did the practice notebook. Put you name in the first text cell and save the notebook.

1. Import the `cos()` function from the math module so that you don't have to specify the module name when you want to use the function. Also import `pi` from the math module in the same way. Write a script to calculate the cosine of pi and also the circumference of a circle with a diameter of 3. If you don't remember how to calculate circumference, Google it.
2. Modify the previous script to allow the user to input their own diameter. Don't forget that the `input()` function returns strings, not numbers.
3. When describing angles, Python measures angles in radians, where 180 degrees = pi radian. That is, divide the angle in degrees by 180, then multiply by pi. Since most people aren't familiar with radians, write a script that will allow a user to input an angle in degrees, convert the degrees to radians, then calculate the cosine of the input angle. Test your script with 45 degrees, whose cosine is 0.70710678118 .
4. Write a script that lets a user enter a string. Then convert what they entered into all caps, all lower case, and title case.
5. **Case insensitivity**. It is often useful to check a user's input without concern for capitalization. The easiest way to do that is to convert what the user entered into all lower case, then check for equivalence with an all lower-case string. Write a script that lets the user input a string, then print the boolean result for comparing whether their string was equal to 'sister' with any kind of capitalization. 
6. Import the `time.sleep()` function to use without a prefix. Then make the script wait (sleep) for one second. 
7. Create a list containing the names of the days of the week. Print the list item for Tuesday by specifying its index. 
8. Assign a URL (including the `http://` or `https://` part) to a variable, then use the `.split()` method to break the URL into pieces based on the position of `/` characters. Note: select and copy a URL from the URL bar of a browser to get the full URL. Which list item contains the domain name (e.g. `vanderbilt.edu` or `calendar.google.com`)? Will that always be the same? Write an expression for the domain name, and print it.
9. If you have a domain name like `vanderbilt.edu`, `www.library.vanderbilt.edu`, or `calendar.google.com`, how can you determine how many parts it has that are separated by periods (dots)? (Hint: first split it into a list.) How can you write a general expression for the last part of any domain name? Modify your script from the last exercise to allow a user to paste in a full URL copied from a browser bar, then tell the user the kind of domain (`com`, `edu`, `org`, etc.) for the URL. Note: copy the URL from the browser bar so that it will have the `http://` or `https://` part of the URL.
10. Write a script that instantiates the fruit basket list, allows a user to type in a fruit, then add the fruit they typed in to the end of the list.
11. Modify the previous script to pick a random fruit from the modified list and print it.
12. Modify the previous script to pick a random fruit from the list, remove it from the list, tell the user that they can't have that fruit, then print the new list without the fruit you removed.
13. The file [mesa_prcp_by_month.txt](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/codegraf/mesa_prcp_by_month.txt) contains the average precipitation by month in mm for Mesa, Arizona, with each value on a separate line terminated by a newline character. Use the `get()` function from the `requests` module to retrieve the data and extract the text into a variable containing a single text string. Split the string by newline (`\n`) characters into a list that contains each value. *Non-rhetorical question:* Can you use the `max()` function to determine the number in the list? If so, do it in your script. If not, explain why in a comment in the script. The URL to access the data is:

```
url = 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/codegraf/mesa_prcp_by_month.txt'
```


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
2. The `time()` funtion (no arguments) from the time (NOT datetime) module gives the number of seconds since the midnight before January 1, 1970. Time how long it takes the user to enter something (or just press the `Enter`/`return` key) by finding the difference in time from before the input statement and after it. You can turn this into a reaction time tester by having one person click the run button and another person press the `Enter` key as soon as they see or hear the first person click run. You can also see how long it takes Python to execute a line of code by just not having an input statement.


## Optional practice script 1 (3m41s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/rYqBBtQ0xgs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----


Next lesson: [Dictionaries and loops](../ees3)

----
Revised 2022-03-04
