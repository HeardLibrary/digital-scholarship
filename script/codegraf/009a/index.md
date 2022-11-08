---
permalink: /script/codegraf/009a/
title: CodeGraf - pandas DataFrame
breadcrumb: OO9a
---

Previous lesson: [pandas Series](../008)

# pandas DataFrame

Preparing data for analysis and visualization can involve cleaning, reformatting, summarizing, and changing the organization of the data. This first of two data-wranging lessons introduces basic data manipulations that may be required to "wrangle" your data into a usable form. It provides background for additional exploration of the data wrangling capabilities of pandas.

**Learning objectives** At the end of this lesson, the learner will:
- create row index labels from a generic column containing text strings using the `.set_index()` method.
- make changes to a source data frame using the `inplace=` argument.
- define *axis* and associate the two pandas DataFrame axes with rows and columns.
- remove rows or columns using the `.drop()` method.
- sort DataFrame rows using the `.sort_values()` method.
- select rows for a view using the `.notnull()` or `.isnull()` methods.
- select rows for a view using boolean conditions as index selectors.
- slice rows or columns by index labels using the `.loc()` method.
- slice rows or columns by index integers using the `.iloc()` method.

Total video time: m s

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/009/009a.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/)

[Lesson slides](../slides/lesson009a.pdf)

# DataFrames

## Introduction to DataFrames (0m55s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/GOGKX7v3Lf0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## pandas DataFrame structure (6m28s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/zOk1LyaQOTo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

# Loading a DataFrame from a file

## Loading a spreadsheet as a pandas DataFrame (3m02s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/JVwKj7H8QU0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Data types in DataFrames and missing values (4m39s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/3PNgkdfpeZs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Setting the row label index of a DataFrame (3m09s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/wiTiHR8leAU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

# Manipulating DataFrames

## Creating a calculated column (2m09s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/AZMlQlamTLM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Simple column methods (5m12s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/-TrWy3q20LM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Dropping and transposing (1m39s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4GZmPQj6hz0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Combining DataFrames (4m45s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/DsvkZfFF5H4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

# Example workflow (3m12s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/M82rKuDuahk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----












## Setting labels (4m45s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/uXTpu-366QU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The `.set_index()` method changes one of the columns into the row index. 

The `.reset_index()` method changes a row index into a regular column.

Example:
```
state_co2_sector.set_index('State', inplace=True)
```

----

## Making changes persist (5m09s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/yRWjJHXPW0w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

**Options for making changes to a DataFrame:**

Assign to a named view using the assignment operator `=`:
```
sorted_view = state_co2_fuel.sort_values(by='Total mmt')
```

Assign to a named copy using the `.copy()` method:
```
sorted_copy = state_co2_fuel.copy().sort_values(by='Total mmt')
```

Perform operation *inplace* using the `inplace=` argument:
```
state_co2_fuel.sort_values(by='Total mmt', inplace=True)
```


----

## Removing rows and columns (4m52s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/wQwMnWUr-aQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Summary of axes terminology:

![data frame axes diagram](dataframe-axes-diagram.png)

`.drop()` method examples:

```
# drop a single row
state_co2_sector.drop('Total')

# drop a list of rows
state_co2_sector.drop(['Virginia', 'West Virginia', 'Wyoming'])

# drop a column
state_co2_sector.drop('Total', axis='columns')
```

----

## Missing data (5m44s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/tdMpI_FPSlA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Replacing missing values examples:

```
# replace all missing values in the DataFrame with the same value: the empty string ('')
schools.fillna({'', inplace=True)

# replace missing values on a single column with the same value: the number zero (0)
schools.fillna({'Native Hawaiian or Other Pacific Islander': 0}, inplace=True)
```

Selecting rows that do not have missing values in a particular column of the DataFrame:

```
schools[schools['Grade PreK 3yrs'].notnull()]
```

----

## Sorting rows (2m49s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Izd4LGJ9hHE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Examples:

```
# Ascending sort (smallest to largest):
state_co2_fuel.sort_values(by='Total mmt', inplace=True)

# Descending sort (largest to smallest):
state_co2_fuel.sort_values(by='Total mmt', ascending=False, inplace=True)
```

----

# Subsetting data

## Slicing rows and columns (6m12s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/q9LxaBz6GZ8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Slicing the first four rows of a DataFrame using the integer index:

```
top_state_co2_fuel = state_co2_fuel.iloc[:4]
```

Note that it is only necessary to include one index (the first one) to slice rows.

Slicing a sequence of cloumns of a DataFrame using index labels:

```
state_co2_fuel_fractions = state_co2_fuel.loc[:, 'Coal fraction': 'Natural Gas fraction']
```

Note that `:` in the first index position selects every row.

----

## Selecting rows (8m42s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/2bZqQq5TIys" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example of selecting rows based on a boolean condition in one column:

```
state_co2_industrial = state_co2[state_co2['Sector']=='Industrial']
```

----

# Practice exercises

under construction

----


Next lesson: [Rearranging and combining DataFrames](../009b)

----
Revised 2022-11-08
