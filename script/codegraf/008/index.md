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

Total video time: m s

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/008/008.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/)

[Lesson slides](../slides/lesson008.pdf)

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



----

## Introduction to pandas Series (5m59s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/RXFjPbUWH6I" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Pandas *Series* are composed of a NumPy array with an index of label indices.

The form of the statement to create a Series from a Python dictionary is:

```
series_name = pd.Series(values_dictionary)
```

----

## Slicing pandas Series by index (5m07s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/5Wu8HFdz9Gg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Series slices can be denoted using a range of either integer or label indices:
```
labeled_legs.iloc[1:3]
labeled_groups.loc['lizard':'worm']
```

Slices denoted by integers do not include the last numbered item, but slices denoted by labels include the last labeled item. Slices can also be denoted by a list of item labels:

```
labeled_groups.loc[ ['worm', 'spider', 'lizard'] ]
```

----

## Slicing pandas Series by boolean conditions (3m30s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/M1YFlf6OLpU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

x


----

## Slices vs. copies (10m15s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/n6A_g2Dukn0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

x


----

## Making changes to pandas data objects permanent (4m23s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/N7L7ezG7vJA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

x




----

# Practice exercises

Under construction

----


Next lesson: [DataFrame manipulation](../009a)


----
Revised 2022-10-28
