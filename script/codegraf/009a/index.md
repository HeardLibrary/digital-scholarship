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

## Loading a spreadsheet as a pandas DataFrame via a URL (3m02s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/JVwKj7H8QU0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Loading a data file into a local Jupyter notebook under Mac OS (4m54s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/pedaEJGIYI8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Loading a data file into a local Jupyter notebook under Windows OS (5m54s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/MWONQtQHPzk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Loading a data file in Google Colabs (5m08s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/hfOAyJw8Xfw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Variation in the behavior of mounting Google Drive in Colab (3m05s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/zYHVzPV3djs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

## Data types in DataFrames and missing values (4m39s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/3PNgkdfpeZs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Setting the row label index of a DataFrame (3m09s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/wiTiHR8leAU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The `.set_index()` method changes one of the columns into the row label index. 

The `.reset_index()` method changes a row label index into a regular column.

Example:
```
state_co2_sector = state_co2_sector.set_index('State')
```

----

# Manipulating DataFrames

## Creating a calculated column (2m09s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/AZMlQlamTLM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

## Simple column methods (5m12s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/-TrWy3q20LM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Sorting examples:

```
# Ascending sort (smallest to largest):
state_co2_fuel.sort_values(by='Total mmt')

# Descending sort (largest to smallest):
state_co2_fuel.sort_values(by='Total mmt', ascending=False)
```


Summary of axes terminology:

![data frame axes diagram](dataframe-axes-diagram.png)


----

## Dropping and transposing (1m39s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4GZmPQj6hz0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

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

## Combining DataFrames (4m45s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/DsvkZfFF5H4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>



----

# Example workflow (3m12s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/kw10CWo_oe4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>


----

# Practice exercises

under construction

----


Next lesson: [Extracting and changing values in a DataFrame](../009b)

----
Revised 2022-11-08
