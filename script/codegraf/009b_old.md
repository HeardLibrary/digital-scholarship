---
title: CodeGraf - Rearranging and combining DataFrames
---

Previous lesson: [DataFrame manipulation](../009a)

# Rearranging and combining DataFrames

Preparing data for analysis and visualization can involve cleaning, reformatting, summarizing, and changing the organization of the data. This second of two data-wranging lessons introduces ways to rearrange and combine data to "wrangle" your data into a usable form. It provides background for additional exploration of the data wrangling capabilities of pandas.

**Learning objectives** At the end of this lesson, the learner will:
- transpose a DataFrame using the `.transpose()` (`.T`) method.
- use grouping to view a subset of a dataframe using `.groupby()` and `.get_group()`.
- generate summary data using `.sum()` or `.mean()` with or without `.groupby()`.
- transform a series having a grouping variable index label to a "wide" DataFrame using `.unstack()`.
- change a "wide" DataFrame to a "long" DataFrame using the `melt()` function.
- change a "long" DataFrame to a "wide" DataFrame using the `.pivot()` method.
- merge two DataFrames by an inner or outer join using the `merge()` function.

Total video time: 34m 50s

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/009/009b.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1-ANzwOCXJ0pX5eQCZwkccMdWJglHuCV4)

[Lesson slides](../slides/lesson009b.pdf)

# Rearranging data

## Transpose (1m50s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/e0G41_XbuVY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Transpose (switch rows and columns) using the `.transpose()` method (abbreviated `.T`):

```
top_state_co2_fuel_fraction.transpose()
```

or

```
top_state_co2_fuel_fraction.T
```

----

## Grouping and group operations (5m13s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/bSwEZPl92ps" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Examples:

```
# Group by a column, then view one of the grouping values:
co2_state_grouped = state_co2.groupby(['State'])
co2_state_grouped.get_group(('Texas'))

# Group by a column, then create a collapsed view by summing the values by group:
co2_sector_grouped = state_co2.groupby(['Sector'])
total_co2_sector = co2_sector_grouped.sum()
```


----

## Unstacking long data frames (6m15s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/O-7MCGSdJUI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example of summing rows, then unstacking to form a "wide" DataFrame:

```
# Load the data
url = 'https://github.com/HeardLibrary/digital-scholarship/raw/master/data/codegraf/co2_data.xlsx'
state_co2 = pd.read_excel(url)

# Change two generic columns to row index labels
double_label = state_co2.copy().set_index(['Sector', 'State'])

# Collapse the remaining columns by summing their values
year_total = double_label.sum(axis='columns')

# Generate the "wide" DataFrame by unstacking the values and creating columns based on the Sector value
column_df = year_total.unstack('Sector')
```

----

## Switching between long and wide table forms (6m06s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/UVOGbyGrzjM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example of changing a "wide" DataFrame to a "long" DataFrame using the `melt()` function:

```
long = pd.melt(wide, ['State'])
```

Notes:
- The DataFrame name is the first argument
- The columns to remaing as grouping variables (not data) are specified as a list in the second argument.

Example of changing a "long" DataFrame to a "wide" DataFrame using the '.pivot()` method:

```
state_wide = long.pivot('State', 'Sector', 'value')
```

Notes:
- The first argument is the name of the column to be used as the row index labels
- The second argument is the name of the column to be used as the column index labels
- The third argument is the name of the column that contains the data that will fill the cells of the new columns.



----

# Combining data

## Data table joins (3m25s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/zmrsmJBMvqw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The result of an *inner join* merge includes only rows where the key exists in both tables.

The result of a *full outer join* includes every row in either table. If one of the tables is missing a key value, the values of columns from that table are filled in with missing data markers (`NaN`) in the resulting row for that key.

Inner joins include only rows where all data are available in both tables. Full outer joins preserve all of the data in the original tables.


----

## Merges in pandas (12m01s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/b_wEfCdG-hY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Example:
```
state_data_outer = pd.merge(state_co2_sector, state_population, on=['State'], how='outer')
```

Notes:
- The first two arguments are the DataFrames to be merged.
- The third argument is the name of the columns containing the keys.
- The fourth argument is the type of join (`inner` or `outer`).


----

# Practice exercises

Due to low demand for this lesson, I haven't yet written practice exercises for it. Are you disappointed? Let me know and I'll bump it up on my priorities list.

----


Next lesson: [Introduction to plotting](../010)

----
Revised 2021-01-31
