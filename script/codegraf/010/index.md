---
permalink: /script/codegraf/010/
title: CodeGraf - Introduction to plotting
breadcrumb: O10
---

Previous regular lesson: [Extracting and changing DataFrame data](../009b)

Previous optional lesson: [Summarizing and rearranging DataFrames](../009c)

# Introduction to plotting

Creating plots may be the end point if you want to present the results of data collection, or it may be just the beginning of a cycle of data visualization, modeling, and additional data gathering and wrangling. Data visualization is a large topic, but it begins with formatting your data into a form that allows you to create a plot using software. In this lesson, we will start with the easiest methods for generating plots from pandas DataFrames and progress to building more complicated plots using pyplot from the Matplotlib Python library.

**Learning objectives** At the end of this lesson, the learner will:
- create a multiline plot directly from a pandas DataFrame
- create a simple XY scatterplot from two numeric columns of a pandas DataFrame.
- create a pie chart from a slice of a pandas DataFrame.
- create a bar chart using a pandas Series sliced or summarized from a DataFrame.
- describe the difference between the two application interfaces in pyplot.
- describe the organization of figure and subplot ("axes") objects in pyplot.
- instantiate one or more subplots and specify their row and column organization.
- format a plot within a subplot by specifying line, color, and point characteristics.
- overlay more than one plot within a subplot. 
- generate a best-fit polynomial and overlay it on a scatterplot.
- create a scatterplot with error bars.
- create multiple subplots within a figure by looping in a script.

Total video time: 23m 15s (42m 50s with optional videos)

## Links

[Lesson Jupyter notebook at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/010/010.ipynb)

[Lesson Colab notebook](https://colab.research.google.com/drive/1WSpHPV68TmM8qiBD_YcMpWvBLanvKmCL)

[Lesson slides](../slides/lesson010.pdf)

[Matplotlib gallery](https://matplotlib.org/stable/gallery/index.html)

# Introduction to plotting in Python (0m57s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/yx2HCpE-5Y0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

To plot directly from a pandas DataFrame, you must include the pandas import statement:

```
import pandas as pd
```

## Line plot from a pandas DataFrame (2m39s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/L35ZmvCAWAQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The default type for plots made directly from a DataFrame is line. The `.plot()` method defaults to a line plot. Here is an example for a dataframe named `covid`:

```
covid.plot()
```

The plot type can be changed by passing in a `kind` keyword argument:

```
covid.plot(kind='line')
```

By default, the first column is used for the X axis and subsequent columns are plotted as additional data series on the Y axis.

**datetime objects**

In order for a date string to display in a reasonable way on a pandas or Pyplot plot, they must be converted to datetime objects, then set as the row index. Example:

```
covid['date'] = pd.to_datetime(covid['date'], format = '%Y-%m-%d') # converts string to datetime object
covid = covid.set_index(['date'])
```

For more on `datetime` objects, review [this lesson](../005/#the-datetime-module-9m08s).

----

## Other plot types from pandas DataFrames (3m02s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/F3HQ62C-zac" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Plot type options for pandas plots are: line, scatter, pie, bar, barh, and others.

To generate a scatterplot from a pandas DataFrame, use the `.scatter()` method. Pass in the X column name as the first argument and the Y column name as the second. Example:

```
covid.plot.scatter('x_column', 'y_column')
```

One pie chart can only contain data from a single pandas series. That means that a single column or row must be sliced from the DataFrame for input into the plot. Example:

```
dataframe.plot(kind='pie')
```

The values will be used as the data for generating the sectors and the label indices will be used as the sector labels.

Bar charts can be generated from a series sliced from a pandas DataFrame column. The row index labels will be used for the X axis labels and the values in the column will be used to determine the Y axis scale. 

For horizontal bar charts (`barh`), the row index labels will be used as the Y axis labels. The labels will be ascending from bottom to top, so if they are alphabetic, a sort with `ascending=False` must be performed on the rows before plotting to make the labels be in alphabetical order from the top.

Example:

```
totals_by_state.sort_index(ascending=False).plot(kind='barh', figsize=(10,10))
```

----

# pyplot from Matplotlib

The standard import statement for pyplot from Matplotlib is:

```
import matplotlib.pyplot as plt
```

[Overview of common plot types](https://matplotlib.org/stable/plot_types/index.html)


## Matplotlib and pyplot (2m05s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/KG7-uGx1YZc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

pyplot is a submodule of the commonly used Matplotlib library. The input is generally in the form of NumPy arrays, but since a pandas series consists of a NumPy arrays plus an index, a series can also generally be used as input. Because the columns in pandas DataFrames are series, if they are sliced from the DataFrame, they can be used as input as well.

pyplot has two application interfaces. One is object-oriented and can be used to build plots by creating and modifying plotting objects. The other is the "pyplot" interface that generates plots in a style that is familiar to Matlab users. This lesson will use the object-oriented interface, since that is most similar to the Python coding style used in previous lessons of this series.  

----


## Pyplot figures and subplots (4m52s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Yz-Tv_29r4M" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

**Figures and subplots**

Creating a *figure* instance sets aside space for all of the plots in the figure. The `figsize=` argument can be used to set the width and height of the figure. Example:

```
fig = plt.figure(figsize=(10,10))
```

One to many *subplot* instances can be inserted into the figure. Example:

```
axes2 = fig.add_subplot(2, 1, 2)
```

"Axes" is often used to refer to the subplots, hence the use of `ax` as the name of a subplot object. This use of the term differs from the conventional use to indicate X and Y axes of the plot itself.

The first argument in the `.add_subplot()` method is the number of rows of subplots, the second argument is the number of columns of subplots, and the third argument is the position of this particular subplot in the sequence of subplots.

When operating in a notebook environment (Jupyter or Colab), the plots will automatically display in the space below the cell. If using a stand-along Python installation, you will need to execute the

```
plt.show()
```

function to open a popup window to display the plot. **Important note:** In notebook interfaces (Jupyter and Colab), all of the code related to a particular plot must be included in a single cell. 

**Plot method syntax**

Here is an example of a statement that creates a line plot:

```
axes1.plot(first_cases.index, first_cases['cases'], color='k', linestyle='dashed', marker='o')
```

The first two arguments are the one-dimensional sequences used as data for the X and Y axes respectively. These sequences may be a pandas Series, a pandas DataFrame column, a Numpy array, or a row label index. Other keyword arguments may be used to specify the color, dash style of the line, and marker type. For more information, see the [color options](https://matplotlib.org/stable/gallery/color/named_colors.html), [line style options](https://matplotlib.org/stable/gallery/lines_bars_and_markers/linestyles.html), and [marker types](https://matplotlib.org/stable/api/markers_api.html). 

Plot types other than line plots are created using methods other than `.plot()`. See the following sections for examples.

----

## Plotting in a single Pyplot subplot (1m38s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/UvxUzgjIuQg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

More than one plot can be inserted into the same subplot object. The more recently added plot will cover up earlier plots. Bar plot example:

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

## Scatterplot with best fit curve (3m38s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/l1gFUpT50Fk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Scatter (or dot) plots are created using the `.scatter()` method:

```
ax.scatter(stories_fallen, injury_rate, color='r')
```

The first argument is the sequence of X values and the second argument is the sequence of Y values. 

**Additional plot features**

Additional features can be specified by adding additional statements. For example, the X and Y axis labels can be specified:

```
ax.set_xlabel('stories fallen')
ax.set_ylabel('average injury per cat')
```

If the data series that are plotted on the same axes are labeled using the `label` keyword argument, they can be used to generate a legend that identifies each of the series:

```
ax.scatter(stories_fallen, injury_rate, label='injury data')
ax.plot(stories_fallen, fit_y_values, color='r', linestyle='dashed', label='best fit line')
ax.legend(loc='upper left')
```

**Fitting a trend curve**

A best fit polynomial curve (including best fit line) can be fitted to the data using the Numpy `np.polyfit()` and `np.poly1d()` functions:

```
import numpy as np
z = np.polyfit(stories_fallen, injury_rate, 2)
p = np.poly1d(z)
```

The first argument in the polyfit function is the series of X values, the second argument is the series of Y values, and the third value is the order of the polynomial (1 for line, 2 for parabola, etc.). 

The fit function (assigned the name `p` in the example above) can be used to generate predicted values for a sequence of X values passed into it. This function can be used as the sequence of Y values in the `.plot()` method:

```
ax.plot(stories_fallen, p(stories_fallen) )
```

If the X values are sparse, a curve with order greater than 1 will not be smooth. In that case a sequence of numbers at closer intervals should be passed into the fit function. The following code uses the Numpy `np.linspace()` function to generate 20 values ranging between the minimum and maximum X values in the data:

```
min_x = stories_fallen.min()
max_x = stories_fallen.max()
fit_x_values = np.linspace(min_x, max_x, num=20)
```

When those values are used to generate the best-fit curve, the code looks like this:

```
fig = plt.figure(figsize=(5,5))
ax = fig.add_subplot(1, 1, 1)
ax.scatter(stories_fallen, injury_rate, label='data')
ax.plot(fit_x_values, p(fit_x_values), color='r', linestyle='dashed', label='fit')
ax.legend(loc="upper left")
```

**Plotting error bars**

The `.errorbar()` method will generate a scatterplot with error bars above and below the dots:

```
ax.errorbar(stories_fallen, injury_rate, yerr=[lower_deviation, upper_deviation], fmt='o')
```

The upper and lower bounds of the bars must be specified as a list of sequences to the `yerr` keyword argument. NOTE: these bounds represent the difference between the dots and the ends of the bars, not the absolute Y values of the bar ends.

----

## Creating subplots programmatically (3m06s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/L7jjHz41iyY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The number of plots and their organization can be set dynamically by a variable:

```
number_of_states = int(input('How many states to plot? '))
fig = plt.figure(figsize=(5, 4*number_of_states))
ax = fig.subplots(number_of_states, 1)
```

The code above will create a single column with number of rows entered by the user. The `.subplots()` method generates multiple subplots ("axes" named here as `ax`) as a Numpy array whose items can be referenced by an index number. 

One can then loop through the subplot array and generate each plot dynamically. The iterator in the example below is a sequence of integers that ranges from 0 to the last subplot. That iterator is used as an index for both the subplot objects and the rows in the source DataFrame that will be used to provide both the data, the sector labels, and the titles for the subplots. 

```
number_of_states = int(input('How many states to plot? '))
fig = plt.figure(figsize=(5, 4*number_of_states))
ax = fig.subplots(number_of_states, 1)
for subplot in range(number_of_states):
    ax[subplot].pie(decreasing.iloc[subplot], labels=decreasing.columns)
    ax[subplot].set_title(decreasing.index[subplot])
```

----
# Optional exercise

## Creating non-standard plots with pyplot (2m48s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/ZqB3Md6ypHQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

Pyplot gives you the ability to control the appearance and data sources of the plot very specifically and make it possible to use script statements to generate the features of the graph. However, this high degree of control is a tradeoff with the ease with which the plot can be generated. Creating complex Pyplot plots requires a more sophisticated understanding of programming and the structure of NumPy and pandas objects. Improved understanding will make it easier to follow template examples found online in places such as the [Matplotlib gallery](https://matplotlib.org/3.2.1/gallery/index.html). 

----

## Creating a stacked bar chart with pyplot (16m47s)

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

This dataset has more information than can easily be visualized without simplifying the data. In this exercise, we'll make use of the `.group()` method to summarize categories of data and make it possible to plot the simplified data. See the ["Grouping and group operations" section of the optional "Summarizing and rearranging DataFrames" lesson](https://heardlibrary.github.io/digital-scholarship/script/codegraf/009c/#grouping-and-group-operations-5m13s) to understand how the `.groupby()` combined with statistical methods work to summarize data by a category.

Follow the prompts in the examples notebook to create the specified plots.

1. Create a horizontal bar plot showing the average number of minutes of delay by carrier, in descending order.

2. Create a plot of Minutes of Delay by date for Delta Airlines. 

3. Visualize the seasonal pattern of delays across airlines using plot with error bars showing the standard deviation of delays per flight.


----
Revised 2022-11-20