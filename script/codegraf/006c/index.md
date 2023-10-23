---
permalink: /script/codegraf/006c/
title: CodeGraf - Conditional execution
breadcrumb: OO6c
---

Previous lesson: [Loops](../006b)

# Conditional execution

In this lesson we will learn several ways to control the flow through statements in your code. We will use variations on `if` statements to do general conditional execution and use `try` ... `except` ... statements to trap errors. We will also examine how flags can be used to track conditions in the script and to assist in the decision-making process.

**Learning objectives** At the end of this lesson, the learner will be able to:
- compare the procedural and vectorized approaches to programming.
- use `if`, `elif`, and `else` to control execution of code blocks in a script.
- explain how indentation affects the execution of code blocks.
- create names for variables to hold boolean values that indicate the state that the variables describe.
- use `try` and `except` to control the behavior of a script when errors occur in particular lines of code.
- use `if ... in ...` to determine if an item is included in an iterable.

Total video time: 28m 20 s (44 m 08 s including optional videos)

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/006/006c.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1p7Z2MQQtwQ2QkietCe-lMz11AC__5ngd)

[Lesson slides](../slides/lesson006c.pdf)


# Procedural vs. vectorized paradigm (4m 10s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/joHgR4vtnuY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

# Conditional execution

## if statements (9m 29s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/12r7CQzshHw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Code example and notes:

```python
name = 'Fred Flintstone'

# Evaluate the boolean value of is_micky based on the comparison of name and 'Mickey Mouse'
is_micky = name == 'Mickey Mouse'
print(name)
print(is_micky)

if is_micky:
    print('You are a Disney character')
print('That is all!')
```

Notes:
1. The double equals sign `==` is a comparison operator to test for equality.  When `name == 'Micky Mouse'` is evaluated, the resulting boolean value is assigned to the variable `is_micky`.  Other conditional operators are: `!=` (not equal), `>` (greater than), `<=` (less than or equal to), etc.
2. The `if` statement controls whether the code block following the colon is executed or not (don't forget the colon!).  If the value following the keyword `if` has a value of `True`, then the code block is executed.  If the value is `False`, the code block is not executed. 
3. As with code blocks in loops, the code block here is demarcated by indentation (of the standard four spaces).  In this example, there is only one line in the indented code block, but there could be many.
4. The `print 'That is all!'` statement is not included in the code block, so it will be executed regardless of the condition.


----

## else and elif (7m 35s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/1yoVZQfkxTY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`else` code example and notes:

```python
name = input('What is the name of the character? ')
print(name)

if name == 'Mickey Mouse':
    print('You are a Disney character')
    print('You are almost ready to go out of copyright!')
else:
    print('You are not a Disney character')
print('That is all?')
```

Notes:
1. The input statement allows users to enter their choice of name.
2. If the input name is equivalent to `Mickey Mouse`, the indented block after the `if` clause is executed.
3. Otherwise, the indented code block after the `else` clause is executed.
4. The unindented code of the last line is always executed.

We could nest `if` statements inside `else` clauses like this:

```python
name = input('What is the name of the character? ')

if name == 'Mickey Mouse':
    print('You are a mouse')
else:
    if name == 'Donald Duck':
        print('You are not a mouse')
    else:
        if name == 'Minnie Mouse':
            print('Your boyfriend is getting old')
        else:
            print('You are not a Disney character')
print("That's all folks!")
```

Each of the subsequent `if` clauses is executed only if the previous ones were `False`. One problem with this structure is that it results in a complicated structure that is hard to read because of the many indentation levels. 

The structure can be simplified by replacing elses that are followed immediately by ifs with a different keyword: `elif`. Each `elif` clause is only executed if the previous clauses are `False`. 

`elif` code example and notes:

```python
name = input('What is the name of the character? ')

if name == 'Mickey Mouse':
    print('You are a mouse')
elif name == 'Donald Duck':
    print('You are not a mouse')
elif name == 'Minnie Mouse':
    print('Your boyfriend is getting old')
else:
    print('You are not a Disney character')
print("That's all folks!")
```

----

# Error trapping (7m 06s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/xKbfRXNMDNk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

If a user enters the wrong type of object, it can cause an error that will interrupt the execution of the script. We can guard against this using `try` ... `except`. The indented block following the `except` clause is executed when an error is thrown. Here is an example:

```python
from math import pi
typed_in = input('What is the diameter of your circle? ')
try:
    diameter = float(typed_in)
    print('The circumference is:', diameter * pi)
except:
    print("Sorry, you didn't enter a number.")
```

Here is another example to handle the situation where the script tries to access a dictionary item whose key does not exist:

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
part_number = input("What part do you want to order? ")
try:
    print('You have ordered a ' + catalog[part_number])
except:
    print("Sorry, that part isn't available.")
print("It's been a pleasure doing business with you!")
```

----

# if ... in ... 

`if ... in ...` is a very useful statement for avoiding errors by knowing whether a particular item is present in an iterable object (a list, for example). It provides an alternative to `try ... except ...` when an item isn't present.

We can test whether a particular item is included in an iterable object using the `in` keyword. Consider the following code:

```python
test = int(input())
if test in range(0,5):
    print(True)
else:
    print(False)
```

If the number entered is 0, 1, 2, 3, or 4, `True` will be printed. Here's another example:

```python
animal = input()
if animal in ['dog', 'cat', 'snake', 'bird']:
    print(True)
else:
    print(False)
```

If the input animal name is one of those in the list, `True` will be printed.

This approach provides an alternative way to make sure that a dictionary key exists before trying to retrieve its value. There are several methods associated with dictionary items: `.keys()`, `.values()`, and `.items()`. Each of these methods produces an iterable data structure containing parts of the dictionary. For example, `catalog.keys()` will enumerate all of the keys in the dictionary and `catalog.values()` will enumerate all of the values. Here's how we can use that information to avoid a "KeyError" error:

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
print(catalog.keys())

part_number = input("What part do you want to order? ")
if part_number in catalog.keys():
    print('You have ordered a ' + catalog[part_number])
else:
    print("Sorry, that part isn't available.")
print("It's been a pleasure doing business with you!")
```

The structure of this code is similar to what we used in the `try...except...` example, except that instead of trying to retrieve the value of the input key and handling the exception (i.e. error) if it fails, we check whether the key exists using an `if...in...` statement and handle the `False` condition with the `else:` code block. 

# Tuples (optional)

*Tuples* are a sequential data structure similar to lists. The items in a tuple can be referenced by indices, just like lists, but those items cannot be changed once the tuple is created. Literal tuples can be created by placing a list of objects in parentheses, like this:

```
animals_tuple = ('dog', 'cat', 'snake', 'bird')
print(animals_tuple[0])
print(animals_tuple[3])
```

The `.items()` dictionary method generates an iterable object consisting of a sequence of tuples where each tuple is a pair consisting of a key and its corresponding value. We can use this code to explore how the `.items()` dictionary method works:

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
print(catalog.items())
for item in catalog.items():
    print(item, type(item))
```

We can *unpack* a tuple by assigning it's parts to a sequence of variable names. The number of variable names must be the same as the number of items in the tuple. Here's an example:

```
number, string = (1, 'xyz')
print(number, string)
```

If we iterate through the item tuples that result from the `.items()` method, we can unpack them into separate `number` and `part` variables. Those variables can be used to print out the catalog to help users make a choice.

```python
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
print('number', 'part')
print('-----------')
# Assign each key and value from the dictionary item to its own variable
for number, part in catalog.items():
    print(number, part)
print()

part_number = input("Enter the number of the part you want to order: ")
print()
if part_number in catalog.keys():
    print('You have ordered a ' + catalog[part_number])
else:
    print("Sorry, that part isn't available.")
print("It's been a pleasure doing business with you!")
```

# Flags (9m 37s, Optional)

Sometimes we use a programming device called a *flag* to keep track of the state of some condition. In Python, it is convenient for a flag to contain a boolean and for the name of the flag to be some indication of the state that is being tracked. For example, if our script is monitoring the status of a door, we might use the variable name `door_open`, and assign it a value of `True` or `False`.

<iframe width="1120" height="630" src="https://www.youtube.com/embed/DCxP-Us7hpQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

*Note to all English majors:* I should have said "None of your numbers **were** even." but I didn't want to redo the whole video!

A typical use of a flag is to determine that a certain condition happened or never happened during a loop. In this example, we want to check a list of numbers and report if any of them were even. Try making some of them even or none of them even. When you are clear about how the code works, you can delete `print(number % 2)` or "comment it out" (make it stop working by putting a # in front of it).

```python
numbers = [3, 4, 453, 99, 19, 50]
was_an_even = False

for number in numbers:
    # The % (modulo) operator gives the remainder after a division.
    # Even numbers have no remainder when divided by 2.
    if number % 2 == 0:
        was_an_even = True

if was_an_even:
    print('At least one of your numbers was even')
else:
    print('None of your numbers were even')
```

Note: 
1. When writing boolean values in your code, make sure that you do not include them inside quotes. `True` is a boolean literal. `'True'` is a string.
2. The % (modulo) operator gives the remainder after a division. Even numbers have no remainder when divided by 2. So `number % 2` will be zero for even numbers and one for odd numbers.

When using a flag, we set the flag to the boolean state that indicates that the condition has never happened. Then when it happens in the code, we change the value to the boolean state that indicates that it did happen. Note that the naming of the flag can indicate change whether we expect the state to be `True` or `False`. For example, we could change the name of the flag in the code above like this:

```python
numbers = [3, 4, 453, 99, 19, 50]
no_evens = True

for number in numbers:
    if number % 2 == 0:
        no_evens = False

if no_evens:
    print('None of your numbers was even')
else:
    print('At least one of your numbers was even')
```

----

## List lookup example (Optional)

In the following example, we want to look for a particular item on a list. However, when we find the item, we want to stop looking rather than continuing the loop to the end of the list. For a short list, this isn't important, but if the list has thousands or millions of items on it, we definitely don't want to keep looking through the list once we have found the item.

In this example, we have two lists of equal length. The items in each position correspond (e.g. the second item in the `character_name` list goes with the second item in the `character_company` list). We iterate through the index numbers (using `range`) rather than the list items themselves because we can only iterate through items in one list, and we need to refer to items in both of the lists. 

```
character_name = ['Mickey Mouse', 'Donald Duck', 'Minnie Mouse', 'Fred Flinstone', 'Daffy Duck', 'Elmo Jetson']
character_company = ['Disney', 'Disney', 'Disney', 'Hanna-Barbera', 'Warner Brothers', 'Hanna-Barbera']

found = False
my_character_name = input('What character do you want to find the company for? ')

for character_number in range(len(character_name)): # if no starting number given for a range, 0 is assumed.
    if character_name[character_number] == my_character_name:
        found = True
        break # Stop the for loop when the character is found -- no need to keep looking.

if found:
    # The value of character number will remain what it was when the loop stopped.
    print(character_name[character_number], 'works at', character_company[character_number])
else:
    print('Could not find your character')
```

The `break` command is how we stop the `for` loop. 

In this example, we need the flag to keep track of whether we found the item or not. If the item is not found, the `for` loop will complete iterating through the entire range and will come to an end normally rather than by being broken. In that case, the 

```
found = True
```

statement will never be excuted. So in the next unindented code after the loop, we use an `if` statement to decide what to tell the user depending on whether the character was found or not.

In many situations, we would use a more complicated data structure like a list of dictionaries or a Pandas DataFrame rather than two corresponding lists. In the case of the Pandas DataFrame, there is a vectorized way to find matches in a column that is much efficient than the method used here.

----

## Complex flag example (6m 11s, Optional)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/1yN_zjZQbJE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Here is a more complicated example where we want to know if there were no matches when we checked a list of items. In this case, we only care about giving feedback if we got all the way through the list without a match.

```python
character_name = ['Mickey Mouse', 'Donald Duck', 'Minnie Mouse', 'Fred Flinstone', 'Daffy Duck', 'Elmo Jetson']
character_company = ['Disney', 'Disney', 'Disney', 'Hanna-Barbera', 'Warner Brothers', 'Hanna-Barbera']

no_characters = True
my_company = input('What film company do you want to check? ')

for company_number in range(len(character_company)): # if no starting number given, 0 is assumed.
    if character_company[company_number] == my_company:
        no_characters = False
        print(character_name[company_number], 'works at', character_company[company_number])
        
if no_characters:
    print('No characters work for your company')
```

**Note about using `range()`**

When we use `range()`, we can specify the start and end of the range like this:

```
range(0, 4)
```

which can be used to iterate through the numbers 0, 1, 2, and 3. If we omit the first number, a starting number of 0 is assumed, so

```
range(4)
```

will iterate through the same series of numbers as before. Recall that the end of the range is one number larger than the last number in the iteration. So if I want to iterate through a list with four items:

```
animals = ['cat', 'slug', 'bee', 'sponge']
```

by their indices, I would need to iterate through items 0, 1, 2, and 3. Therefore I could generate this sequence using `range(4)`. Since the number of items in the list (`len(animals)`) is 4, I can use 

```
range(len(animals))
```

to generate the range of indices for the list. This is a generalized solution for a list of any length, so it is better than hard-coding the number of items in the `range()` expression. If the number of items in the list changes or is not known in advance, this expression will always generate the indices of every list item.

----

# Practice assignment

The questions for the practice assignment are in this [Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/006/006c_practice.ipynb). It is also available as a [Colab notebook](https://colab.research.google.com/drive/1_rgeUKAfu7Mg2qrVJVlbk-m0kKGXue2I?usp=sharing). 

----

Problem 1 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/uGxQOMgOM7E" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Problem 2 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/5kxxpIDNydo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Problem 3 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/gZZa6YjkbBE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Problem 4 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/CDM5ODaTXEM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Problem 5 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/H8Eh2P3olog" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Problem 6 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/H3_6XR3GR7Y" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----


This is the end of the Beginning Python module. 

If you want to continue on with lessons on vectorized programming with Pandas, you can begin the lesson on [NumPy arrays](../007)

Continue to the intermediate series on [files and tables](../020)

----

Revised 2023-10-23
