---
permalink: /script/python/projects/ees/
title: EES project
breadcrumb: ees
---

# EES Python data visualization project

## Project learning objectives:

The students will:
- acquire data from a tabular data source and load it into a Python data structure (list of dictionaries).
- extract necessary data from the data structure and wrangle it into a form usable in their analysis.
- use the basic Python structures and statements they have learned: `if`, `for`, `input`, assignment, use a function from a module.
- create a simple visualization using `matplotlib.pyplot`. 

# Tasks and subtasks

1 Acquire data<br/>
1\.1 Use script-defined function (provided) to load CSV from URL to a list of dictionaries<br/>

2 Calculate means for desired quantity (rainfall, temperature)<br/>
2\.1 Step through all data in column for the quantity, then sum for period to be averaged<br/>
2\.1.1 Extract year or month from date string if necessary<br/>
2\.1.2 Screen whether a particular datum is from the correct time interval<br/>
2\.1.3 Skip missing data<br/>
2\.1.4 Add screened data to sum<br/>
2\.1.5 Count data that were summarized (exclude missing data)<br/>
2\.2 Calculate the mean from the sum<br/>
2\.3 Repeat the screening for every time interval to be graphed (year or month)
2\.3.1 Determine the limits of the period for that analysis<br/>
2\.3.2 Append time point and mean to growing lists of summary data<br/>

3 Visualize data<br/>
3\.1 Set up subplot<br/>
3\.1.1 Create subplot<br/>
3\.1.2 Label axes<br/>
3\.2 Plot data using appropriate style (scatterplot, bar, error bars)<br/>
3\.3 Add trendline if appropriate<br/>
3\.3.1 Fit linear polynomial to summary data<br/>
3\.3.2 Add polynomial data to plot<br/>

## Task details

For particular tasks, it is best to start with the narrowest subtasks and work your way to the broader tasks.

**1 Acquire data**

The raw data will be provided as a file available from GitHub using a URL given to you. 

**1\.1 Use script-defined function (provided) to load CSV from URL to a list of dictionaries**

You will be given a function to be inserted into your code that will get the data, convert it to a Python list of dictionaries, and return the list of dictionaries. The dictionaries are a special kind known as an *ordered dictionary*, but you can use them just like regular dictionaries.

**2 Calculate means for desired quantity (rainfall, temperature)**

Start with one factor and interval (mean rainfall by year) and after completing the code for that combination, change the code to handle different intervals and factors. 

The overall structure of the code in this part of the program will be a little complicated since it involves two nested `for` loops. It will look something like this:

```
# Create empty lists
for timepoint in range_of_time: # do the inner loop for each timepoint
    for month in climate_data: # go through every month to see if its datum needs to be included
        # Perform a screen for each timepoint.
        # Sum each datum that qualifies.
    # Perform calculations using the sum of included data and append the calculated values to lists.
```

We will build the inner loop first for a hard-coded timepoint value (a certain year or month), then build the outer loop to step through all timepoints.

**2\.1 Step through all data in column for the quantity, then sum for period to be averaged**

This will be a loop that includes all of the rows in the table

**2\.1.1 Extract year or month from date string if necessary**

The date strings are in ISO 8601 format: `2022-03-29` in the order of year-month-day. To get the year, you need to slice the first four characters. However, the loop variable is an integer, so to compare the loop variable to the extracted year you need to either make them both strings or both integers. For months, you also need to slice the date string, but if you are looping through a list of strings for the months, you can make the comparison directly.

**2\.1.2 Screen whether a particular datum is from the correct time interval**

Both of these tasks will require `if` statements. The `if` statements need to be nested so that both requirements must be met (the datum must be in the interval and the datum must not be missing) in order for the datum to be added to the sum. So you can't use `if ... elif...` to do the screen.

For now, just hard code a particular year (like `'1950'`) or month (like `'05'`) to screen for. Later we will create another loop to do the screening for every time point in the visualization.

**2\.1.3 Skip missing data**

The way that the data are read in by the `read_dicts_from_github_csv()` function, missing data (empty cells) have a value of empty string (`''`), so that's what you need to use in your boolean comparison.

**2\.1.4 Add screened data to sum**

Recall that you can add a number to a sum using this type of code:

```
sum = sum + new_number
```

Prior to adding the first number you need to assign a value of zero to `sum`. This can be shortened to:

```
sum += new_number
```

which achieves exactly the same result.  Note that both `sum` and `new_number` must be numbers (in this case `float`). If both are strings, the code above will concatenate (join end-to-end) the strings rather than add. If only one is a number, the code will throw an error.

**2\.1.5 Count data that were summarized (exclude missing data)**

As we add monthly values to the sum, we also need to keep track of how many data we have summed. For months, we can't just say that there were 12 because if there were a missing month's data we would only have 11. Recall that to count, we can use code similar to the examples above, except that instead of adding any number to the sum, we add one:

```
count = count + 1
```

or equivalently:

```
count += 1
```

**2\.2 Calculate the mean from the sum**

The screening code we wrote above will be inside a loop that steps through each of the months in the dataset. After that loop finishes, we need to calculate the average for the time interval over which we did the summing, using the sum and count we were building inside the loop.

**2\.3 Repeat the screening for every time point to be graphed (year or month)**

In order to repeat the screening for every time point that you are going to graph, you need to enclose the screening loop you made above inside another loop that does the screen for every point you want to plot.

**2\.3.1 Determine the limits of the period for that analysis**

The limits you choose will either be a range of months or years. The easiest way to loop through years is to treat them as numbers and use a `range()` object to generate them. The months are tricker, since they need to have leading zeros. So it's easier to create a list of strings like: `['01', '02', '03', ...'12']`. 

**2\.3.2 Append time point and mean to growing lists of summary data**

To do the visualization, you will need two lists containing the same number of items. One list will include the timepoint (typed as a number, so `'02'` would need to be turned into `2`.) and the other list will contain the mean value you calculated. After completing the screening and summing and calculation the average, you need to append these two numbers (timepoint and average) to the lists. Obviously, you need to create empty lists (`[]`) before you start the outer loop. 

For the errorbar plot of maximum and minumum temperatures by month, you will need to have four lists: a list of the months, a list of mean temperatures, a list of the upper ends of the deviations, and a list of the lower ends of the deviations. You can calculate the latter two by taking the mean maximum temperature for that month and subtracting the mean average temperature, and taking the mean average temperature for that month ans subtracting the mean minimum temperature for that month.

**3 Visualize data**

The plot setup should be fairly straightforward and be similar to examples we did in class.

**3\.1 Set up subplot<br/>
3\.1.1 Create subplot**

We should only need a single subplot ("ax") within each figure.

**3\.1.2 Label axes**

Each axis should be labeled with both the quantity represented on that axis and the units of that quantity.

**3\.2 Plot data using appropriate style (scatterplot, bar, error bars)**

Each plot will differ in details, but the first argument (x) of the plot will be the timepoints and the second argument (y) will be the quantity averaged (precipitation or temperature).

**3\.3 Add trendline if appropriate**

A trendline is generally appropriate for scatterplots. A linear trendline (best-fit line) is appropriate if we want to assess whether changes over time increase or decrease over the time interval being visualized. 

**3\.3.1 Fit linear polynomial to summary data<br/>
3\.3.2 Add polynomial data to plot**

Follow the examples from the lesson. It may be clearer to make the trendline be a different color than the scatterplot points. You can controll this several ways.

## Project rubric:

| possible points | feature |
| --------------- | ------- |
| 10 | User input with an informative prompt |
| 10 | At least one `if` clause |
| 20 | extract data from, or store data in one or more of the basic Python data structures (list, dictionary, tuple) |
| 10 | a `for` or `while` loop as appropriate for the task |
| 10 | use a function to perform a calculation based on multiple values from the dataset |
| 20 | a visualization using the `matplot.pyplot` module |
| 20 | "does it work" points (i. e. to what extent does the script actually do the required task?) |


