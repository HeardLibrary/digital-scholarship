---
permalink: /script/codegraf/ees3/
title: EES 2580 - Dictionaries, loops, and complex data structures
breadcrumb: ees3
---

Previous lesson: [Code libraries and lists](../ees2)

# Dictionaries, loops, and complex data structures - EES 2580

In this lesson we introduce a second complex object: *dictionaries*. A dictionary is a one-dimensional data structure like a list, but its elements are referenced by name using a *key* rather than by index number. 

We can build more complex objects by nesting one object inside another. Two examples we examine are lists of lists and lists of dictionaries.

The pandas module introduces a useful two-dimensional data structure called a *DataFrame*. We examine the structure of a DataFrame and how to reference its elements.

We also introduce two kinds of *loops*, which are ways to step through *iterable* objects like lists or to repeat an action many times.

**Learning objectives** At the end of this lesson, the learner will be able to:
- create a dictionary by specifying the items it contains.
- add or change dictionary values.
- remove a dictionary value.
- create a complex Python data structure by creating a list that contains lists or dictionaries as list items.
- describe how a list of lists can be compared to cells of a table.
- create a pandas Series from a Python dictionary.
- reference a value in a pandas Series by its label index or integer position index.
- reference a column in a pandas DataFrame by its label index.
- reference a row in a pandas DataFrame by its label index or integer position index.
- reference a cell in a pandas DataFrame by its row and column label indices.
- load a spreadsheet from a URL into a pandas DataFrame.
- use the `.head()` method to view the first few lines of a DataFrame.
- preform vectorized operations on columns of a pandas DataFrame.
- print the items on a list using a `for` loop.
- explain how an *indented code block* is used to define sections of code.
- use the `.iterrows()` method to iterate through the rows of a pandas DataFrame.


## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/ees3/ees3.ipynb)


# Dictionaries

![diagram of a dictionary](../dictionary.png)

## Introduction to dictionaries (6m51s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/DjOhhv6LHAI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Dictionaries are written as a series of key:value pairs, separated by commas, within curly brackets.

```
catalog = {'1008':'widget', '2149':'flange', '19x5':'smoke shifter', '992':'poiuyt'}
```

An empty dictionary can be created using curly brackets with nothing inside them

```
traits = {}
```

Both creating and changing a value in the dictionary are done by assigning a value by designated key

```
traits['height'] = 12
```

An item can be removed using the del command

```
del traits['eye color']
```

----

# Complex data structures

For a more detailed look at this topic that repeats some of this content, go to [this page](../021/)

## Lists of lists (5m05s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/UP3K-EiG9gU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A list can contain any object, including other lists.  In some programming languages, there are two-dimensional structures called *arrays*.  To create an array-like structure in Python, we can make a list of lists.  Here's an example:

```python
firstRow = [3, 5, 7, 9]
secondRow = [4, 11, -1, 5]
thirdRow = [-99, 0, 45, 0]
data = [firstRow, secondRow, thirdRow]
```

An equivalent way to have created this list of lists would have been:

```python
data = [[3, 5, 7, 9], [4, 11, -1, 5], [-99, 0, 45, 0]]
```

We can think of a list of lists like a table where the first index represents the row and the second index represents the column.

![list of lists as a table](list-of-lists.png)

To reference an item in a list of lists, first reference the outer list position, then the inner position.  For example, to refer to the first item in the third list, use `data[2][0]`. In the table model, we can think of the indexing as `data[column][row]`.

----

## Lists of dictionaries (4m58s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/1w7Cuog4LbQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example code:

```
characters = [{'name':'Mickey Mouse', 'company':'Disney', 'gender': 'male'}, {'name':'Daisy Duck', 'company':'Disney', 'gender': 'female'}, {'name':'Daffy Duck', 'company':'Warner Brothers', 'gender': 'male'},  {'name':'Fred Flintstone', 'company':'Hanna Barbera', 'gender': 'male'}, {'name':'WALL-E', 'company':'Pixar', 'gender': 'neutral'}, {'name':'Fiona', 'company':'DreamWorks', 'gender': 'female'}]
```

![list of dictionaries as a table](list-of-dictionaries.png)

----

## Introduction to pandas Series (5m59s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/RXFjPbUWH6I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The form of the statement to create a Series from a Python dictionary is:

```
series_name = pd.Series(values_dictionary)
```

pandas *Series* are similar to both lists and dictionaries since they can be indexed by either a label index (similar to a dictionary key) or an integer position index (similar to the index of a list). 

```
states_series = pd.Series(states_dict)
print(states_series[2])
print(states_series['TN'])
```

**NOTE:** As with other Python indexing, the integer position index is zero-based (counting starts with zero). So an integer index of 2 locates the 3rd item in the Series.

To avoid ambiguity, the indexing system can be made explicit by indexing using `.loc[]` for label indices and `.iloc[]` for integer position indexing:

```
states_series.loc['TN']
states_series.iloc[2]
```

Do not associate the "i" in `.iloc[]` with the word "index", since "index" is used generically to describe the label index. It's better to think of the "i" as representing "integer".

A pandas Series is composed of a NumPy array with an associated label index object. Basing the Series data structure on a NumPy array allows the Series to be used in vectorized operations and provides better performance than with basic Python data structures like lists and dictionaries.

The `.values` attribute of a Series returns the NumPy array and the `.index` attribute returns the label index. Both are iterable.

----

## pandas DataFrame structure (6m28s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/zOk1LyaQOTo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Columns of a data frame can be referred to by their label in two ways:

```
states_df['capital']
states_df.capital
```

The "dot notation" can only be used if the column label is a valid Python object name (i.e. can't have spaces). The resulting object is a series whose values are the values in the column labeled by the row label indices.

Rows in a data frame can be referred to by either their index label (using `.loc[]`) or their integer position (using `.iloc[]`):

```
states_df.loc['AZ']
states_df.iloc[1]
```

The resulting object is a series whose values are the values in the row labeled by the column headers.

Cells in a data frame can be referred to by their row, column labels (using `.loc[]`):

```
states_df.loc['PA', 'population']
```

The resulting object has the type of the cell value.

---

# Loading a DataFrame from a file

One nice thing about loading spreadsheet data into a pandas DataFrame is that the file can come either from your local file directory or from a URL. The same function can be used for either data source.

## Loading a spreadsheet via a URL (3m02s)

Functions for reading and writing from spreadsheets to pandas DataFrames:

`pd.read_csv()` read from a CSV file into a data frame.

`pd.to_csv()` write from a data frame to a CSV file.

`pd.read_excel()` read from an Excel file into a data frame.

`pd.to_excel()` write from a data frame to an Excel file.

For details about reading from particular sheets in an Excel file, delimiters other than commas, etc. see the [pandas User Guide](https://pandas.pydata.org/docs/user_guide/io.html) and [this Stack Overflow post](https://stackoverflow.com/questions/26521266/using-pandas-to-pd-read-excel-for-multiple-worksheets-of-the-same-workbook).

<iframe width="1120" height="630" src="https://www.youtube.com/embed/JVwKj7H8QU0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Note: when loading files via a URL, be sure that the URL delivers the raw file, not an HTML representation of the file.

**Examining the DataFrame**

Use the `.head()` method to view only the first few lines of a DataFrame (default is 5 if `number_of_lines` argument omitted):
```
dataframe.head(number_of_lines)
```

The `.tail()` method is similar, but shows the last few lines of a DataFrame

The `.shape` attribute returns a tuple of the number of rows and number of columns. 

The `.columns` attribute returns the column names as a pandas Index object. Use the `list()` function to convert into a simple Python list.

The `.index` returns the row label indices as a pandas Index object. Use the `list()` function to convert into a simple Python list.

----

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

## Iterating through DataFrame rows (4m11s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4x6C2VLtDoU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Typically, we don't want to iterate through rows in a pandas DataFrame because it's faster and more efficient to make changes to an entire column of the table using vectorized operations. However, there are some cases where it is difficult or impossible to do this and it's necessary to operate on one row at a time. Examples of such situations include:

- operations involving a complex sequence of operations or conditions involving multiple cells in a row.
- operations on row cells that involve retrieving data from somewhere outside of the DataFrame.
- operations that involve output calculated from row values to somewhere outside of the dataframe.

The `.iterrows()` method creates an iterable object from the DataFrame. With each iteration, a tuple is generated that contains the label index as its first item and a series containing row data as the second item. The row data series has the column headers as the series label indices and the row values as the series values. 

Values in the row series can be referenced as shown [in this lesson](../008/#introduction-to-pandas-series-5m59s), either by direct indexing:

```
row_series['column_header']
```

or by passing the series label (the column header) into `.loc[]`:

```
row_series.loc['column_header']
```
----

# Practice

**Practice assignment**

**Instructions:** Go to the [practice assignment Colab notebook](https://colab.research.google.com/drive/1wOBPS-Bn17J0YKtXjRcwf-_y8qZHGaj4?usp=sharing) and make a copy in your own drive as you did the practice notebook. Put you name in the first text cell and save the notebook.

1. Create a dictionary where the keys are the names of months and the values are the number of days in that month. Allow a user to enter the name of a month and print the number of days in that month. Create appropriate prompts and print statements so the user knows what to do and can interpret the response.
2. Copy the statement that creates the dictionary that is a catolog of items. Create another dictionary with exactly the same items and keys, but for which the values are prices as decimal numbers. Let the user type in a catalog number, then print the name of the item and its price. Prepend a dollar sign `$` to the price before printing, but don't include the dollar sign in the dictionary.
3. Modify the last program to convert the price of the selected item to euros (you may need to look up the exchange rate). Add an additional statement to print the price in euros, prepending the Unicode string for the euro sign (`\u20AC`) to the numeric price. Make the print statement work so that there is no space between the euro sign and the price?
4. Create a list that contains the days of the week. Using a `for` loop, print the days of the week.
5. Use `range()` with a `for` loop that counts by 10 from 10 to 200. Make sure that your first number is 10 and your last number is 200.
6. Create two lists. The first list should contain the names of the month in order and the second list should contain the number of days in each month in order. Create a `for` loop using `range()` that will step through the numbers 0 to 11. As you iterate through each number, print the corresponding name and number of days for each month, using the index of the list item (for example `name[month_number]` where `month_number` is the iterated index number).
7. Using the list of month names from the previous exercise, use a `for` loop to print the index number generated by `range()` and following it, the month name. (In other words, generate a numbered list of months.) Make sure that your numbered list numbers January as 1 and December as 12. Now let ask the user to enter the number of the month they want to choose. Convert what they input into an integer, then print the name of the month and the number of days in that month. Make your script user friendly so that the user knows what they are supposed to do and also make the final printout say something like `March has 31 days.` rather than just printing a name and a number.
8. Create an empty list called `friends`. Set the value of the variable `counter` to zero. Using a `while` loop, ask the user to enter the name of a friend. In each loop, append the name of the friend to the `friends` list and increment (add one to) the `counter` variable. End the `while` loop when the user presses the `Enter` (or `Return`) key without entering a name. When the loop ends, use a `for` loop to print the list of the user's friends and also tell the user the total number of friends that they have.
9. The following line of code defines the variable `climate`, which provides the average precipitation and temperature for months the year 1879 in Mesa, Arizona. 

```
climate = [
    {'month': 'Jan', 'ppt': 92.8, 'tavg': 12.1},
    {'month': 'Feb', 'ppt': 19.1, 'tavg': 10.1},
    {'month': 'Mar', 'ppt': 18.2, 'tavg': 11.8},
    {'month': 'Apr', 'ppt': 0, 'tavg': 19.2},
    {'month': 'May', 'ppt': 4.1, 'tavg': 25},
    {'month': 'Jun', 'ppt': 0, 'tavg': 28.1},
    {'month': 'Jul', 'ppt': 8.3, 'tavg': 32.4},
    {'month': 'Aug', 'ppt': 41.8, 'tavg': 32.2},
    {'month': 'Sep', 'ppt': 34.1, 'tavg': 28.2},
    {'month': 'Oct', 'ppt': 2.5, 'tavg': 19.5},
    {'month': 'Nov', 'ppt': 0, 'tavg': 14.5},
    {'month': 'Dec', 'ppt': 7.6, 'tavg': 8.7}    
]
```

Use the `type()` function to answer the following questions:
- what class of object is `climate`?
- what class of object is `climate[2]`?
- what class of object is `climate[2]['month']`?
- what class of object is `climate[2]['ppt']`?

10\. Write the expressions to print the following:
- the average temperture for July 1879.
- the data dictionary for December 1879. 

11\. Using a single `for` loop, print the month abbreviation and average temperature for each month in 1879 together on the same line.

12\. Create a variable called `sum` and set its value to zero. Create a `for` loop that steps through each month and adds the precipitation value for each month to the `sum` variable. Recall that 

```
sum += number
```

is a shortcut for

```
sum = sum + number
```

After you add up all of the values, print the value of the average precipitation for all months of the year. (Don't worry about weighting the monthly values by the length of the month.)

13\. In question 13 last week, we loaded data from a file on the Internet, turned its data into a list, but failed to correctly find the maximum numeric value because the values in our list were strings. Solve the problem by: 
- creating an empty list to hold numbers
- loading the data from the Internet
- splitting it into a list based on newline characters
- stepping through the list using a `for` loop, converting each string into a number, and appending it to a new list
- using the `max()` function to find the largest value of the new, numeric list.

The line of code with the URL from which you can retrieve the data is:

```
url = 'https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/codegraf/mesa_prcp_by_month.txt'
```

**Optional practice with video help (See videos below for live coding)**

These practice problems are a bit more challenging, so there are video "walk-thoughs" for each one.

1. Improve the list entry example by making it produce an alphabetized list.
2. Improve the list entry script by making its alphabetizing case-insensitive.
3. Have the list entry script print each of the items on the list on a separate line.
4. Alphabetize the list of files in your current working directory, then print each file name on a separate line.
5. In [a famous story](http://wbilljohnson.com/journal/math/gauss.htm), the young mathematician Karl Gauss’s teacher assigned him the task of adding all of the numbers from 1 to 100, with the intention of keeping him busy for a while. It didn’t work because in a few moments, Gauss calculated the answer, 5050, using some clever thinking. However, if Gauss were in school now, he could just write a Python script to do the calculation. Write a script using `range()` to add all the numbers from 1 up to any number that you choose. Note: if you use the `input()` function to get the person’s number, you’ll need to use the int() function to turn the entered string into an integer number.
6. The game Yatzee involves rolling five dice and trying to get “poker hands” like three of a kind, a straight, etc. You can simulate the rolling of a die using a function from the random module:

```
randomNumber = r.randrange(1, 7)
```
Simulate the rolling of five dice as follows:

 - create an empty list
 - run a `for` loop five times
 - each loop, generate a random number and append it to the list
 - print the list.

----

## Practice live coding

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

Next lesson: [Contitional execution](../ees4)


----

Revised 2022-03-18
