---
permalink: /script/codegraf/006b/
title: CodeGraf - Loops
breadcrumb: OO6b
---

Previous lesson: [Lists and dictionaries](../006a)

# Loops

In this lesson we introduce two kinds of *loops*, which are ways to step through *iterable* objects like lists or to repeat an action many times.

**Learning objectives** At the end of this lesson, the learner will be able to:
- print the items on a list using a `for` loop.
- explain how an *indented code block* is used to define sections of code.
- use a `range()` object to perform action a fixed number of times.
- iterate through a `range()` object using a `for` loop and use the value in a calculation.
- describe how a `while` loop ends when it has an indefinite number of iterations.
- set up a `while` loop to perform actions in an indented code block.
- describe how an empty string can be generated by the enter/return key.
- build a string by repeatedly concatenating additional strings to an empty string.
- build a list by repeatedly appending additional items to an empty list.
- describe the actions that occur when several methods are attached sequentially.

Total video time: 33m 13s (60m 57s when practice live coding videos are included)

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/006/006b.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1sPO7Uib0Aa0Ut-10RD_tDMwGCgTa58AB)

[Lesson slides](../slides/lesson006b.pdf)


# Loops

## for loops (5m46s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/uAlD1Y5e4Ao" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A very common task in Python is to repeat some code multiple times.  For example, suppose we want to do something with every item in a list.  A list is *iterable*, meaning that you can step through the list and operate on each of the items in the sequence.  Here's an example:

```
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
for fruit in basket:
    print('I ate one ' + fruit)
print("I'm full now!")
```

Each time the script iterates to another item in the list, it repeats the indented code block below the `for` statement and the value of the iterator (`fruit` in this case) changes to the next item.  Strings are also iterable:

```
word = 'supercalifragilisticexpialidocious'
print('Spell it out!')
for letter in word:
    print(letter)
print('That wore me out.')
```


----

## Iterating over a range object (10m28s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/WeoJz01w1ww" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

You can generate an iterable range of numbers using a `range()` object.  The form of the numbers we use in `range()` is similar to the numbering in slices, although we separate them with commas.  The first number is the starting number and the second number is one more than the ending number. An optional third number can specify the step (e.g. 2 would generate every second number).  The step can also be negative.

We can use a `for` statement to iterate through a range.  Here are examples:

```python
for count in range(1,11):
    print(count)
```

```python
print('Prepare to launch!')
for count_down in range(10, 0, -1):
    print(count_down)
print('Lift off!')
```

Notice how we need to be careful that our second number goes one step beyond our intended range.  

```python
cheer = ''
for skipper in range(2, 10, 2):
    cheer = cheer + str(skipper) + ', '
cheer = cheer + 'who do we appreciate?'
print(cheer)
```

Notice in this example that if we wanted to treat the integer that we generated as a string, we needed to convert it to a string using the `str()` function. That allows us to do a clever trick of starting the `cheer` object as an empty string, then concatenating more strings to its end each time the code block is executed in the loop.

Ranges are often used to index list items when we want to iterate through a list, but have access to the index number.  Here is an example:

```python
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
print("Here's a list of the fruit in the basket:")
for fruit_number in range(0, len(basket)):
    print(str(fruit_number + 1) + ' ' + basket[fruit_number])
print('You can see that there are ' + str(len(basket)) + ' fruits in the basket.')
```

Notice several things:
1. Because the number of items in the list `len(basket)` (5) is one more than the index of the last item in the list `basket[4]`, the range covers the entire list, since ranges must end one number greater than the range you want.
2. I had to add 1 to the `fruit_number` as it iterated because Python counts starting from zero and I wanted to start numbering from one.
3. I had to use the `str()` function each time I wanted to concatenate one of the integer numbers to other strings. I also could have printed the numbers by passing them into the `print()` function as several arguments separated by commas. That would not have required converting them from integers to strings.


----

## while loops (10m44s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/UU1i2KhFg9I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example:

```
power = 0 # must have an initial value
exponent = 0
print('exponent\tpower') # \t is the escaped tab character
while power < 100:
    power = 2**exponent  # exponentiation is done with **
    print(exponent, '\t', power)
    exponent += 1 # incrementing is critical for the loop to end
print("Those are the powers of two.")
```

Pressing the return/enter key without entering any text generates an empty string (`''`). We can use this as a way for a user to indicate that they are done entering items.

```
print('Enter your list items and press Enter when done')
item = 'something'
word_list = []

while item != '': # check for the empty string
    item = input('Next item: ')
    word_list.append(item)

# remove the final empty string
del word_list[len(word_list)-1]
#word_list = word_list[:len(word_list)] # alternate way to remove by slicing
print('Your list is:', word_list)
```

**Notes:**
1. Here we use a similar trick to the one we saw earlier where we built upon an empty string. In this example, we start with an empty list, then add list items one at a time until the user indicates that they are done by pressing the enter key.
2. Because the `while` loop tests the condition at the start of the loop, the empty string entered by the user gets added to the list during the execution of the indented code block. So when the loop is finished, we need to remove the extra empty string that got added to the end of the list. The script uses the `del` command, but an alternate method is in the commented-out line. That alternate method generates a slice of the list from the first item to the next to last item, then replaces the original list with the slice.


----

## Shortcuts (optional)

There are several shortcuts that can simplify code involving loops. They aren't necessary to accomplish basic tasks, but allow you to write code that is more compact.

**Ranges that start with zero**

If you have a range that starts with zero, you can omit the first argument. For example:

```
for count in range(11):
    print(count)
```

would do exactly the same thing as:

```
for count in range(0, 11):
    print(count)
```

This makes it easy to step through the indices of all items in a list:

```
my_list = "apple", "banana", "grape"
for count in range(len(my_list)):
    print(my_list[count])
```

**The `enumerate()` function**

In the example where we wanted to print a numbered list of fruits, we used a `range()` object to generate the indices, then used the indices to look up the items on the list and print them. There is a more straightforward way to accomplish that in Python. If we pass a list into the `enumerate()` function, it will return an iterable "enumerator object". Each time we step through an enumerate object, it produces not one item, but a pair of items (technically a `tuple`, discussed in the next lesson): an index and a list item. We can "unpack" the two items into two variables with the `for` loop like this:

```
basket = ['apple', 'orange', 'banana', 'lemon', 'lime']
print("Here's a list of the fruit in the basket:")
for fruit_number, fruit in enumerate(basket):
    print(fruit_number, fruit)
print('You can see that there are', len(basket), 'fruits in the basket.')
```

By default, the index number starts with zero. So the code above would number the fruits from zero. If we want it to start with a different number, we can use a `start` keyword argument, like this:

```
for fruit_number, fruit in enumerate(basket, start=1):
```

**List comprehensions**

List comprehensions are probably the most complicated of these shortcuts. They are less readable to a human, but are also more compact, so you often see them when someone wants to quickly generate a list in a single line of code. The general format of a list comprehension is:

```
[expression for item in iterable]
```

Here is a simple example that generates a list of the squares of integers from 0 to 11:

```
squares = [n**2 for n in range(11)]
```

`range(11)` is an iterable of the integers from 0 to 10, and `n**2` is the square of `n`. 

The expression can be pretty much anything. Here's a list comprehension that makes a list of the lower case first initials in a name:

```
name = 'John Paul Jones'
name_list = name.split(' ')
initials_list = [name_string[0].lower() for name_string in name_list]
print(initials_list)
```

The `.join()` method joints items in a list of strings using the character that the method is applied to. So if I wanted to joint a list of strings with the empty string (nothing) between each character, I could use this:

```
concatenated_initials = ''.join(initials_list)
```

Putting this all together, I could generate lower case initials for any number of names using this code:

```
name = input('What is your name? ')
name_list = name.split(' ')
initials_list = [name_string[0].lower() for name_string in name_list]
print('Your initials are:', ''.join(initials_list))
```

This is very compact code, but might blow the mind of a beginning Python coder because it crams so many Python techniques into a few lines. 

----

## Aside: Applying methods sequentially (6m17s)

This optional section describes two approaches to carring out methods sequentially.

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Lx0HGUmfX-g" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Applying several methods sequentially in a single statement results in very compact code. But the code becomes less understandable than when the methods are carried out in separate statements.

**Note:** In order to apply methods sequentially as shown here, the return value of a method must be an object that is of the correct type to be operated upon by the next method. In this example, `my_sentence` is a string, which can be operated upon by the `.lower()` method. The `.lower()` method returns a string, which can be operated upon by the `.split()` method. The `.split()` method returns a list, which can be operatied upon by the `.count()` method. The `.count()` method returns an iteger and that is the type of the output of the entire sequence of methods.

In some cases, it makes sense to just pile up several methods. For example, if we just want a line of code that generates a ISO 8601 dateTime string to be used for a timestamp, it's convenient to just put the code on one line like this:

```
import datetime
# Generate an ISO 8601 dateTime string
wholeTimeStringZ = datetime.datetime.utcnow().isoformat() # form: 2019-12-05T15:35:04.959311
```

This basically serves as a utility for us and documenting how all of its pieces work isn't really that important for understanding the code.

----

# Practice assignment

The questions for the practice assignment are in this [Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/006/006b_practice.ipynb). It is also available as a [Colab notebook](https://colab.research.google.com/drive/1tVC5hSbsW8E-y0-XxE_fhshc0Q1w7Kty?usp=sharing). You will need to [make a copy of it in your own drive](../003a#running-someone-elses-colab-notebook-3m35s) before editing it.

For feedback on the assignment, change the sharing properties to allow access for anyone with the link, and send the notebook link to the instructor.

----

## Practice live coding

These videos will help you do the extra (optional) practice problems at the end of the Practice Assignment Colab notebook.

**Practice problem 1** (1m48s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/tzKr4GD4Zro" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

**Practice problem 2** (4m04s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/CjnEB4Q-P6Y" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

**Practice problem 3** (2m33s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/yym2lYOsH_Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

**Practice problem 4** (3m21s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Y399DyeXB4s" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

**Practice problem 5** (9m47s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/K7_8JNartQU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

**Practice problem 6** (6m09s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/JQn8n0P8Kvc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Next lesson: [Contitional execution](../006c)


----

Revised 2023-02-22