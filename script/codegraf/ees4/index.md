---
permalink: /script/codegraf/ees4/
title: EES 2580 - Loops, conditional execution, and Matplotlib
breadcrumb: ees4
---

Previous lesson: [Dictionaries and complex data structures](../ees3)

# Loops, conditional execution, and Matplotlib - EES 2580

In this lesson we will introduce *for loops*, which are ways to step through *iterable* objects like lists or to repeat an action many times. We will also learn several ways to control the flow through statements in your code. We will use variations on `if` statements to do general conditional execution and use `try` ... `except` ... statements to trap errors. Finally, we will introduce the Matplotlib library to create plots of data.

**Learning objectives** At the end of this lesson, the learner will be able to:
- compare the procedural and vectorized approaches to programming.
- print the items on a list using a `for` loop.
- explain how an *indented code block* is used to define sections of code.
- use the `.iterrows()` method to iterate through the rows of a pandas DataFrame.
- use `if`, `elif`, and `else` to control execution of code blocks in a script.
- explain how indentation affects the execution of code blocks.
- use `try` and `except` to control the behavior of a script when errors occur in particular lines of code.
- create a scatter, line, bar, or errorbar plot using Matplotlib.
- assign labels to axes in a plot.
- overlay a best-fit polynomial curve.


## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/ees4/ees4.ipynb)


# Loops

----

## Procedural vs. vectorized paradigm (4m 10s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/joHgR4vtnuY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

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

## Building a sequence with a for loop

A common strategy in programming is to build a sequence by starting with an empty sequence and adding items to it one at a time. Here's an example using strings:

```
list_of_words = ['The ', 'quick ', 'brown ', 'fox ', 'jumps ', 'over ', 'the ', 'lazy ', 'dog ']
sentence = ''
for word in list_of_words:
    sentence = sentence + word # Concatenate the word to the sentence
print(sentence + '!')
```

The statement pattern `sequence = sequence + item` is a common pattern in programming.  It is so common that there is a shorthand for it: `sequence += item`.  Here's the same example using the shorthand:

```
sentence = ''
for word in list_of_words:
    sentence += word
print(sentence + '!')
```

We can use the same kind of strategy to add numbers:
    
```
total = 0
for number in [3, 5, 7, 9]:
    total += number # Add the number to the total
print('The total is', total)
```

In both of these cases, we knew the items in advance. We can use the `range()` function to generate a sequence of numbers that can be used to control the number of times we add items to a sequence. Here's an example:

```
bird_list = []
for i in range(4):
    bird = input('Enter a bird name: ')
    bird_list.append(bird) # Append the bird name to the list
print('Your bird list is:', bird_list)
```

----

## Iterating through DataFrame rows (4m11s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4x6C2VLtDoU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Typically, we don't want to iterate through rows in a pandas DataFrame because it's faster and more efficient to make changes to an entire column of the table using vectorized operations. However, there are some cases where it is difficult or impossible to do this and it's necessary to operate on one row at a time. Examples of such situations include:

- operations involving a complex sequence of operations or conditions involving multiple cells in a row.
- operations on row cells that involve retrieving data from somewhere outside of the DataFrame.
- operations that involve output calculated from row values to somewhere outside of the dataframe.

The `.iterrows()` method creates an iterable object from the DataFrame. With each iteration, a tuple is generated that contains the label index as its first item and a series containing row data as the second item. (For more information about tuples, see the optional section at the end of the lesson.) The row data series has the column headers as the series label indices and the row values as the series values. 

Values in the row series can be referenced as shown [in this lesson](../008/#introduction-to-pandas-series-5m59s), either by direct indexing:

```
row_series['column_header']
```

or by passing the series label (the column header) into `.loc[]`:

```
row_series.loc['column_header']
```
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
3. As with code blocks in functions, the code block here is demarcated by indentation (of the standard four spaces).  In this example, there is only one line in the indented code block, but there could be many.
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

# Plotting with Matplotlib

Matplotlib (<https://matplotlib.org/>) is a plotting library for Python that is built on the NumPy extension. One part of the library, `pyplot`, is designed to operate in a fashion that is familiar to users of MATLAB. Typically, the input data for creating plots with Matplotlib are NumPy arrays, which we have not studied, but generic lists of numbers and pandas Series are also accepted as input. There are two interfaces for using Matplotlib. We will use the object-oriented interface, but you sometimes may see examples that look quite different because they use the other interface. 

To import Pyplot, it is conventional to use:

```
import matplotlib.pyplot as plt
```

We will plot some interesting data described in Example 1.2 of [Whitlock and Schluter](https://whitlockschluter.zoology.ubc.ca/) about injuries sustained by cats falling out of apartment building windows. The data are from vet office records (not an experimental manipulation!) and look like this:

```
average_injury_rate = [0.7, 1.0, 1.9, 2.0, 2.3, 2.4, 1.0]
stories_fallen = [2, 3, 4, 5, 6, 8, 11]
```

Each corresponding item in the lists represents a particular data point (e.g. average injury rate for falling 2 stories was 0.7).

## Pyplot figures and subplots (7m34s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4Xt2MHlh7qI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

.

Creating a *figure* instance sets aside space for all of the plots in the figure. The `figsize=` argument can be used to set the width and height of the figure. Example:

```
fig = plt.figure(figsize=(10, 10))
```

One to many *subplot* instances can be inserted into the figure. Example:

```
axes2 = fig.add_subplot(2, 1, 2)
```

creates two rows of plots with one plot in each row, and instantiates the second plot.

"Axes" is often used to refer to the subplots, hence the use of `ax` as the name of a subplot object. This use of the term differs from the conventional use to indicate X and Y axes of the plot itself.

If we just want to create a single plot, we can use

```
ax = fig.add_subplot(1, 1, 1)
```

The `show` function is not needed in Jupyter notebooks, but is required in stand-alone Python installations to display the plot.

```
plt.show()
```

----

## Plot types and appearance

Matplotlib provides methods to generate simple two-dimensional plot types. The first two arguments are the variables to be plotted as `(x, y)`.

```
ax.scatter(stories_fallen, injury_rate, color='r') # dot plot (scatterplot) with red color
ax.plot(stories_fallen, injury_rate) # line plot (points connected by lines)
ax.bar(stories_fallen, injury_rate) # bar plot

# error bar plot with dot markers
ax.errorbar(stories_fallen, injury_rate, yerr=[lower_deviation, upper_deviation], fmt='o')
```

`lower_deviation` and `upper_deviation` are one-dimensional data structures (e.g. lists) that have the same length as the data list, with corresponding items.

Axis labels are generated using two methods:

```
ax.set_xlabel('stories fallen')
ax.set_ylabel('average injury per cat')
```

## Fitting a polynomial curve

To overlay a best-fit line or curve, you must calculate the function of the best-fit polynomial using numpy functions. 

```
z = np.polyfit(stories_fallen, injury_rate, 2) # third argument is the order, e.g. 1=linear, 2=quadratic, etc.
p = np.poly1d(z)
```

The created function `p()` can be plotted as a function of the x variable:

```
ax.plot(stories_fallen, p(stories_fallen))
```

# Practice exercises

**Instructions:**  The questions for the practice assignment are in this [Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/ees4/ees4_practice.ipynb). Download it to your local drive within the GitHub repository you created for this course.

When you've finished the assignment, be sure to save a final time. Do not clear the output so that viewers can see what the output was when you submit the assignment. Commit the changes to the repository and push the changes to the remote repository on GitHub.  

Go to the web page for the repository on GitHub and locate the notebook. Submit the link for the notebook web page to Brightspace as instructed.

----

# Optional topics

The following topics introduce some additional concepts that are useful to know, but not critical for this lesson. 

----

## if ... in ... (optional)

Another condition we can test for is whether a particular item is included in an iterable object using the `in` keyword. Consider the following code:

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

## Tuples (optional)

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



----

This is the end of the EES 2580 Beginning Python module. 

If you want to continue on with lessons on vectorized programming with pandas, you can begin the lesson on [NumPy arrays](../007)

Continue to the intermediate series on [files and tables](../020)

----

Revised 2024-03-06
