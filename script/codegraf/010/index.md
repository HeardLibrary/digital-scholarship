---
permalink: /script/codegraf/010/
title: CodeGraf - Introduction to plotting
breadcrumb: O10
---

Previous regular lesson: [Extracting and changing DataFrame data](../009b)

Previous optional lesson: [Summarizing and rearranging DataFrames](../009c)

# Introduction to plotting

Creating plots may be the end point if you want to present the results of data collection, or it may be just the beginning of a cycle of data visualization, modeling, and additional data gathering and wrangling. Data visualization is a large topic, but it begins with formatting your data into a form that allows you to create a plot using software. In this lesson, we will start with the easiest methods for generating plots from pandas DataFrames and progress to building more complicated plots using Pyplot from the Matplotlib Python library.

**Learning objectives** At the end of this lesson, the learner will:
- create a multiline plot directly from a pandas DataFrame
- separate plot lines using the `subplots=` argument.
- create a simple XY scatterplot from two numeric columns of a pandas DataFrame.
- create one or more pie charts from slices of a pandas DataFrame.
- create a bar chart using a pandas series sliced or summarized from a DataFrame.
- use the Pyplot `plt.plot()` function to create XY line or scatterplots using pandas series sliced from a dataframe.
- describe the organization of figure and subplot ("axes") objects in Pyplot.
- instantiate one or more subplots and specify their row and column organization.
- format a plot within a subplot by specifying line, color, and point characteristics.
- overlay more than one plot within a subplot. 
- extract data from the indices, columns, and rows of a pandas DataFrame and use those data to generate a stacked bar chart.

Total video time: 62m 54s

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/010/010.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1mGH4RH3uKuW1aoH5vlz-to-vQ68djHVF)

[Lesson slides](../slides/lesson010.pdf)

# Plotting with pandas

The standard import statement for Pyplot from Matplotlib is:

```
import matplotlib.pyplot as plt
```

## Line graph from a pandas DataFrame (6m57s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/G5TrCBgox1A" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

In order for a date string to display in a reasonable way on a pandas or Pyplot plot, they must be converted to datetime objects, then set as the row index. Example:

```
covid['date'] = pd.to_datetime(covid['date'], format = '%Y-%m-%d') # converts string to datetime object
covid.set_index(['date'], inplace=True)
```

For more on `datetime` objects, review [this lesson](../005/#the-datetime-module-9m08s).

----

## Subplots from a pandas DataFrame (3m28s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4cyWVMOrOng" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

To display line graphs from pandas DataFrame columns in separate subplots, set the `subplots` argument to `True`. The size of the plot can also be controlled usint the `figsize` argument. Example:

```
covid.plot(title = 'Covid 19 cases in the U.S.', subplots = True, figsize=(10,10))
```

----

## Other plot types from pandas DataFrames (1m55s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Q8Zk_8yXQRk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Plot type options for pandas plots are: line, scatter, pie, bar, barh, and others.

----

## Scatterplot from a pandas DataFrame (0m54s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/QGxAEw-xWxY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

To generate a scatterplot from a pandas DataFrame, pass in the X column name as the first argument and the Y column name as the second. Example:

```
covid.plot.scatter('x_column', 'y_column')
```

----

## Pie chart from a pandas DataFrame (7m54s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Qv-4E8cpnE8" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

One pie chart can only contain data from a single pandas series. That means that either a single column or row must be sliced from the DataFrame for input into the plot, or the `subplots=` argument must be set to `True`. Example:

```
dataframe.plot(kind='pie', subplots=True)
```

----

## Bar chart from a pandas DataFrame (2m04s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/nKIGnDH5kZs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Bar charts can be generated from a series sliced from a pandas DataFrame column. The row index labels will be used for the X axis labels and the values in the column will be used to determine the Y axis scale. 

For horizontal bar charts (`barh`), the row index labels will be used as the Y axis labels. The labels will be ascending from bottom to top, so if they are alphabetic, a sort with `ascending=False` must be performed on the rows before plotting to make the labels be in alphabetical order from the top.


----

# pyplot from Matplotlib

## What is pyplot? (1m46s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/xl4N5qjiZkw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

pyplot is a subset of the commonly used Matplotlib library. It is used to generate "Matlab-style" plots. The input is generally in the form of NumPy arrays, but since a pandas series consists of a NumPy arrays plus an index, a series can also generally be used as input. Because the columns in pandas DataFrames are series, if they are sliced from the DataFrame, they can be used as input as well.

----

## Pyplot plot function (5m45s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/mr8URVnVf5w" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The `plt.plot()` function is the simplest way to generate basic plots using Pyplot. To make scatter or line plots, pass in the X and Y arrays (i.e. series) as the first and second arguments respectively. Color, line style, and marker type can also be specified by arguments. Examples:

```
plt.scatter(first_cases.cases, first_cases.deaths)
plt.plot(first_cases.cases, first_cases.deaths, color='k', linestyle='dashed', marker='o')
```

----

## Pyplot figures and subplots (7m34s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/4Xt2MHlh7qI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Creating a *figure* instance sets aside space for all of the plots in the figure. The `figsize=` argument can be used to set the width and height of the figure. Example:

```
fig = plt.figure(figsize=(10,10))
```

One to many *subplot* instances can be inserted into the figure. Example:

```
axes2 = fig.add_subplot(2, 1, 2)
```

"Axes" is often used to refer to the subplots, hence the use of `ax` as the name of a subplot object. This use of the term differs from the conventional use to indicate X and Y axes of the plot itself.


----

## Plotting in a single Pyplot subplot (4m31s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/UYjzEOzNpgM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

More than one plot can be inserted into the same subplot object. The more recently added plot will cover up earlier plots. Example:

```
fig = plt.figure(figsize=(10,10))
# Create a single subplot
ax = fig.add_subplot(1, 1, 1)
ax.bar(first_cases.index, first_cases.cases, color='k')
ax.bar(first_cases.index, first_cases.deaths, color='r')
ax.set_title('start of the COVID 19 pandemic in the U.S.')
```

In this example, the red bars of the second plot will partially cover the black bars of the first plot.


----

## Creating non-standard plots with Pyplot (3m19s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/VzowOXwzCVg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Pyplot gives you the ability to control the appearance and data sources of the plot very specifically and make it possible to use script statements to generate the features of the graph. However, this high degree of control is a tradeoff with the ease with which the plot can be generated. Creating complex Pyplot plots requires a more sophisticated understanding of programming and the structure of NumPy and pandas objects. Improved understanding will make it easier to follow template examples found online in places such as the [Matplotlib gallery](https://matplotlib.org/3.2.1/gallery/index.html). 

----

## Creating a stacked bar chart with Pyplot (16m47s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Uic3-7uFgYg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Creating a stacked bar chart using Pyplot is challenging because of the need to calculate the total heights of all of the bars that are stacked below the bar currently being plotted. In this example, a `for` loop is used to do that calculation, and labels are extracted from a pandas dataframe to generate the bar labels and legend labels.

Example code:

```
# Load state_co2_sector spreadsheet
url = 'https://github.com/HeardLibrary/digital-scholarship/raw/master/data/codegraf/co2_state_2016_sector.xlsx'
state_co2_sector = pd.read_excel(url)

# Extract sector data for the top few states. number_of_states can be changed to add states bars.
number_of_states = 4
top_state_sectors = state_co2_sector.set_index('State').drop('Total').sort_values(by='Total', ascending=False).drop(['Total'], axis='columns')[:number_of_states]

# Create a figure object
fig = plt.figure(figsize=(15,10))

# Create a single subplot
ax = fig.add_subplot(1, 1, 1)

# Create a numpy array with one element for each row
ind = np.arange(len(top_state_sectors))
#print(ind)

# Extract the row and column labels as numpy arrays from pandas series
row_labels = top_state_sectors.index.values
column_labels = top_state_sectors.columns.values

for sector_number in range(len(top_state_sectors.columns)):
    #print(sector_number)
    #print(top_state_sectors.iloc[:, :sector_number])
    sector_sums = top_state_sectors.iloc[:, :sector_number].sum(axis='columns')
    #print(sector_sums)
    ax.bar(ind, top_state_sectors.iloc[:, sector_number], bottom=sector_sums)

# These functions operate on the most recently active subplot; we have only one in this example
plt.xticks(ind, row_labels)
plt.legend(column_labels)
```

# Practice problems

To do the practice problems, you need to download the large flight delay dataset from [this page](https://github.com/HeardLibrary/digital-scholarship/tree/master/data/codegraf). The dataset, On-Time: Reporting Carrier On-Time Performance (1987-present), is compressed in `.zip` format. After uncompressing the datafile (`flight_data_set.csv`), you will need to move it to the working directory of your environment. See the [Loading files from your file system](../008/#loading-files-from-your-file-system) section of the pandas data frames lesson for information about your specific cloud service or operating system.  

The text cell of each practice problem describes what to accomplish. Try to do the coding yourself before looking at the solution code in the cell below the description.

1. Calculate the average values for the carriers and slice out the Minutes of Delay per flight. Create a bar chart of the resulting series.

2. Recreate the plot, but this time replace `NaN` values with zeros.

3. First, Convert date column to a datetime object and group by Carrier Name, then Slice only the Delta data and sum by date. Plot only the Minutes of Delay by date. 

4. See if the pattern from the previous problem holds across airlines. First, group by both Carrier Name and Date rather than selecting only one airline. Limit output to Minutes of Delay data. Then unstack Carrier Name so that we get a column for each carrier. If we redo the plot, Pandas will plot a line for each carrier.

5. Compare the number of flights across airlines using a bar chart.

----
Revised 2020-09-01