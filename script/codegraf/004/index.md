---
permalink: /script/codegraf/004/
title: CodeGraf - Python programming basics
breadcrumb: OO4
---

Previous lesson: 

If you weren't sure how you were going to be running your code: [Installing a programming environment](../003)

If you wanted to start coding Python as quickly as possible: [Quickstart guide for running Python in a Colab notebook](../003a)

If you wanted to code using the AI tool GitHub Copilot, see [Setting up VS Code to use Jupyter notebooks and GitHub Copilot](../003c)

# Python programming basics

This lesson is focused on developing familiarity with core statements and functions that are frequently used in Python scripts.

**Learning objectives** At the end of this lesson, the learner will:
- use the assignment operator `=` to set the value of a variable.
- follow style conventions of the [PEP 8 Python style guide](https://www.python.org/dev/peps/pep-0008/).
- distingish between *string*, *number*, and *boolean* objects.
- use *literal* and *variable* objects in functions.
- describe *argument* and *return value* in the context of functions.
- use the `type()` function to determine the class of an object.
- use the `input()` function to enter a number.
- describe the difference in behavior of the `+` operator with numbers and strings.
- define *concatenation*.
- list six operators that produce boolean outputs.

Total video time: 53m 8s (66m 40s with optional practice script videos)

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/004/004.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/12wvGS6syV4iAvC2Gbw9LyuimB6jGBOPQ?usp=sharing)

[Lesson slides](../slides/lesson004.pdf)

# The = assignment operator

## Introduction to variable assignment (3m25s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/FAvnuY4HEks" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

**String, number, and boolean object types**

A *string* is a sequence of characters, such as a word or sentence. 

There are a variety of *number types* in Python.  Two types are *integers* (numbers with no decimal point) and *floating point* numbers (numbers with a decimal point).

A *boolean* is a True or False value.

**Literals**

In a *literal*, you state explicitly what the object is.  String literals are written within single or double quotes:

```text
"cat"
'dog'
"My name is Steve."
'!@#$%^&*'
```

To create a literal containing a quote, enclose it in the other kind of quote:

```text
"That's OK!"
`Why is he called "Paco"?'
```

A back slash is used to generate special characters, such as a *newline* ("hard return" character). The character after the backslash has a special meaning and is not included in the string. Example:

```python
'This is the first line of text.\nThis is the second line of text.'
```

Number literals are written without quotes:

```python
3.14159
157
57.25
0.0098
```

Bolean literals are written like this, without quotes:

```python
True
False
```

**Assignment to variables**

Values are assigned to variables using an equals sign.  In variable assignment, **an equals sign does not mean that the two things are equal!**  The value on the right is assigned to the variable on the left.  It's helpful to think of the equals sign as an arrow pointing to the left.  Examples:

```python
user_name = "smithjr"
is_door_open = False
number_of_array_elements = 47
eulers_number = 2.7182818
```

In these examples, literals are being assigned to variables.  The contents of a variable can also be assigned to a variable, or an expression can be evalutated and the result placed in a variable.

```python
user_name = last_login_name
sum = number_widgets + 3
too_many = sum > 10
```

In the third example above, the variable `too_many` will contain a boolean (`True` or `False`) depending on a condition (whether the number in `sum` is greater than 10 or not).


----

## Assignment to variables: coding conventions (7m28s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/iIgDMsXXQxg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The following conventions are suggestions for naming that are commonly used and "safe".  That doesn't mean that you can construct names in other ways and get away with it, but if you follow these conventions, your code will be easy to read and won't have unexpected behavior.

Your code is less likely to have bugs if it is easy for a human to read it and easily tell what's going on.  For that reason, it is better to have object names that are descriptive of what the object is or does.  For example, a name like `load_participant_data` is better than `x`.

The following **characters** can be considered "safe" for names in Python: upper and lower case Latin alphabet letters, numerals, and the underscore (`_`) character. Periods (dots) have special use in Python.  Spaces are bad. Hypens can cause problems in some circumstances, so it's better to avoid them.  As a general practice, it's probably safest to begin object names with letters, since other symbols sometimes have special uses, and in some contexts, object names beginning with numerals might have problems.

For **names** of variables and functions, the [PEP 8 style guide](https://www.python.org/dev/peps/pep-0008/) recommends separating words with underscores.  Examples: `company_report_file_name` and `convert_xml_to_json`.  This style is sometimes called *snake_case*.

camelCase is also frequently used.  In camelCase, descriptive words are concatenated, with the first word beginning with a lower case letter and subsequent words beginning with capital letters.  Examples: `companyReportFileName` and `convertXmlToJson`.  

----

# Built-in functions

## Review of functions (2m14s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/VUSoRRlZFM8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A *function* is a way to break Python into reusable chunks.  

A function is like a processing machine.  You put stuff into it and different stuff comes out of it.  Think of a latte-making machine.  It might have three inputs: one for coffee beans, one for milk product, and one for water.  You put those three things in and a latte comes out.  The exact result will depend on what you put in.  Put in decaf beans, fat-free milk, and water and you get a skinny decaf latte.  Put in regular beans, soy milk, and water and you get a vegan regular latte.  Put in regular beans, full cream milk, and no water and you get an error.

The things you put into the function are called *arguments*.  The general format for a Python function is:

```python
function_name(argument1, argument2, ...)
```

There can be zero to many arguments in a function.  The latte function might look like this:

```python
make_latte(beans, milk, water)
```

The output of the function, called the **return value** can be assigned to a variable:

```python
my_latte = make_latte(beans, milk, water)
```

**Some built-in functions**

Python comes with build-in functions that are always available.  Here are some:

```python
print()
input()
max()
len()
type()
int()
```

----

## Built-in functions: print and input (5m17s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/f3NqLIXUtJs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`print()` function example:
```
# The argument passed into the print() function is printed to the display.
# There is no return value
print(character_name) # pass in a variable
print() # pass in nothing
print('Fred') # pass in a literal
```

`input()` function example:
```
# The argument passed into the input() function is the prompt to the user.
# The return value is the string entered by the user from the keyboard.
my_character = input('What is the name of the character? ')
print(my_character)
```

----

## Review of function behavior (1m46s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/SlIcpI8Vc68" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Comments in programs (1m57s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/utKSuOm6IMM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Examples:
```
# Comment on a separate line (ignored by the Python interpreter)
print('some words') # comment on the same line as a statement (everything after # is ignored)
```

----

# Type of objects

## The type function (3m14s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/oPvbsy4vRho" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`type()` function example:
```
# The argument passed into the type function is the object whose type you want to know.
# The return value is the type of the object.
# The output can be assigned to a variable.
the_type = type("a word")
print(the_type)
```

Function nesting example:
```
print(type(True))
```

----

## Cross-cell persistence of values (3m15s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/rJE-LKasScU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## String return value of input function (1m31s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/0JWsQcGImv8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example:
```
# What is the type of the output of the input() function?
answer = input("Input a string or number: ")
print(answer)
print(type(answer))
```

----

## What determines the type of a variable? (2m19s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/VCV8PQAJl-g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Requirements of function arguments (4m57s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/S5sRJ5rN2dE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`max()` function examples:
```
print(max(1, 5, 2))
print(max(3, 6, 14, 1, 256, 34))
print(max()) # produces an error
```

`len()` function examples:
```
print(len('dog'))
print(len('aardvark'))
print(len('')) # '' is called the empty string
print(len(42)) # produces an error
```

----

## Inputting a number (4m38s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/qX52UcnVebY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Type conversion using the `int()` function:
```
# We may be able to turn one kind of object into another.
a_string = '42'
print(a_string)
print(type(a_string))
a_number = int(a_string)
print(a_number)
print(type(a_number))
```

Numeric input example:
```
response = input('What is your number? ')
number = int(response)
# You can print several arguments by separating them by commas
print('Here is your number, plus 2:', number + 2)
```

----

# Operators

## Math operations and concatenation (3m18s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/0jbgW1-FB8c" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Some simple math operators are `+` (addition), `-` (subtraction), `*` (multiplication), and `/` (division).

Examples:
```
number_widgets = 1
answer = number_widgets + 3
print(answer)
```

```
first_number = 325
second_number = 145
together = first_number + second_number
print(together)
print(type(together))
```

```
first_number = '325'
second_number = '145'
together = first_number + second_number
print(together)
print(type(together))
```

The `+` operator is used for *concatenation* of strings.

----

## Working with boolean operations (7m49s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/NymzeTpOj_E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Boolean operators are: `==` (equivalence), `!=` (not equal), `>` (greater than), `<` (less than), `>=` (greater than or equal to), and `<=` (less than or equal to).

Examples:
```
print('dog' == 'cat')
print('cat' == 'cat')
print('dog' != 'cat')
print(3 > 2)
print(2 > 2)
print(2 >= 2)
```

```
# Notice that one `=` is the assignment operator and two `==` is the equivalence operator.
same_animal = 'cat' == 'monkey'
print(same_animal)
```

```
first_animal = input('What is your first animal? ')
second_animal = input('What is your second animal? ')
same_animal = first_animal == second_animal
print('First animal the same as second animal?', same_animal)
```

----

# Optional Practice scripts

Look at the scripts in the lesson Colab notebook and try to explain what they do before you run them. Then try running the to see if what you predicted was correct. If you don’t understand what happened, you can watch the following videos.

## Practice instructions (0m47s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/2kN9jsiSkJM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Practice script 1 (2m14s)

```
name = input("What's your name? ")
print('Hello ' + name + '! How are you?')
```

<iframe width="1120" height="630" src="https://www.youtube.com/embed/b-ijvZIZUlk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

## Practice script 2 (3m02s)

```
first_number = float(input('What is your number? '))
second_number = 67
biggest = max(first_number, second_number, 100)
print(biggest)
```

<iframe width="1120" height="630" src="https://www.youtube.com/embed/9s-HL4GFYLI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

## Practice script 3 (2m29s)

```
name = input('What is your name? ')
how_long = len(name)
print('Your name is '+ name + '. It is: ')
print(how_long)
print('characters long.')
```

<iframe width="1120" height="630" src="https://www.youtube.com/embed/peWMt0oUsMw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

## Practice script 4 (2m19s)

```
a_number = 16
a_number = a_number + 1
print(a_number)
```

<iframe width="1120" height="630" src="https://www.youtube.com/embed/NnQ9LWHuqL8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

## Practice script 5 (2m41s)

```
number_widgets = int(input('How many widgets? '))
sum = number_widgets + 3
too_many = sum > 10
print(too_many)
```

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Gp0bOJ3dRdo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

## Practice assignment:

The questions for the practice assignment are in this [Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/004/004_practice.ipynb). It is also available as a [Colab notebook](https://colab.research.google.com/drive/1GaNrFR-sR8dVhDqpyzDk1QAxndUxjFwu?usp=sharing). You will need to [make a copy of it in your own drive](../003a#running-someone-elses-colab-notebook-3m35s) before editing it.

Next lesson: [Using code libraries](../005)

----
Revised 2023-10-03