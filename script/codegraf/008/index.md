---
permalink: /script/codegraf/008/
title: CodeGraf - pandas Series
breadcrumb: OO8
---

Previous lesson: [Reading and writing CSV files](../022) or

[optional lesson on NumPy arrays](../007)

# Pandas series

This lesson introduces the [pandas library for Python](https://pandas.pydata.org/) and one of the data structures that it introduces: *Series*. Series are one-dimensional objects built from NumPy arrays. 

**Learning objectives** At the end of this lesson, the learner will:
- import the pandas module using the conventional statement.
- describe how pandas Series are related to NumPy arrays.
- instantiate a Series from a dictionary.
- refer to a Series item using either its integer (position) index or label index using `.loc[]` and `.iloc[]`.
- write the expression for a slice of a Series using either integer or label indices using `.loc[]` and `.iloc[]`.

Total video time: 33m 36s

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/008/008.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/)

[Lesson slides](../slides/lesson008.pdf)

[pandas user guide](https://pandas.pydata.org/docs/user_guide/)

# Series

## Introduction to Pandas (2m50s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/HFLSlryCqxU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The conventional import statement for pandas is:
```
import pandas as pd
```

All of the examples in the rest of this lesson assume that you've executed this statement and assigned pandas to the abbreviation `pd`.

----

## Review of one-dimensional Python data structures (1m32s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Kqjn7FbDwzg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Dictionaries are addressable by key:

```
states_dict = {'OH': 'Ohio', 'TN': 'Tennessee', 'AZ': 'Arizona', 'PA': 'Pennsylvania', 'AK': 'Alaska'}
print(states_dict['TN'])
```

Lists are addressable by integer index:

```
animal_list = ['lizard', 'spider', 'worm', 'bee']
print(animal_list[2])
```

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

# Extracting parts of Series

In addition to specifying a particular item in a series, `.loc[]` and `.iloc[]` can be used to extract a part of the series (a "slice") based on one of several mechanisms. The resulting slice is also a pandas Series, and the label indices from the original Series are maintained in the slice.

## Slicing pandas Series by index (5m07s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/5Wu8HFdz9Gg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Series slices can be denoted using a range of either label indices or integer positions:
```
states_series.loc['TN':'PA']
states_series.iloc[1:4]
```

Slices denoted by integer position do not include the last numbered item, but slices denoted by labels include the last labeled item. In the examples above, the item with the index `PA` will be included in the first slice but the item in position 4 will not be included in the second slice.

Slices can also be denoted by a list of labels or integers:

```
states_series.loc[ ['TN', 'AK', 'OH'] ]
states_series.iloc[ [1, 3, 0] ]
```

The order of items in the slice will be the order of the indices in the list and all listed indices will be included.

----

## Slicing pandas Series by boolean conditions (3m30s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/M1YFlf6OLpU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The items to be included in a slice can also be selected using a boolean Series passed into `.loc[]`. The label indices of the boolean series should match the label indices of the Series to be sliced on an item by item basis. This is usually accomplished by generating the boolean Series by performing a vectorized operation that produces a boolean on the Series to be sliced. 

![Vectorized operation producing a boolean Series](vectorized_boolean.png)

For example, the method `.startswith()` will produce a Series of booleans based on whether each corresponding string value from a source Series begins with the string passed in as an argument. The following expression generates a Series of booleans with a `True` value when the string value starts with the character `A`:

```
states_series.str.startswith('A')
```

If the resulting boolean Series is passed into `.loc[]`, the resulting slice will include each item in the source Series where the condition is `True`.

![Slicing based on boolean conditions](boolean_slice.png)

The label indices are maintained for the values in the resulting slice.

----

## Slices vs. copies (10m15s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/n6A_g2Dukn0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

x


----

# Making changes to pandas data objects permanent (4m23s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/N7L7ezG7vJA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

x




----

# Practice exercises

Under construction

----


Next lesson: [DataFrame manipulation](../009a)


----
Revised 2022-10-28
