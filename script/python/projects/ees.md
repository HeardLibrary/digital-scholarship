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
2\.1 Step through all data in column for quantity and sum for period to be averaged<br/>
2\.1.1 Determine the limits of the period for that analysis<br/>
2\.1.2 Extract year or month from date string if necessary<br/>
2\.1.3 Screen whether a particular datum is from the correct time interval<br/>
2\.1.4 Skip missing data<br/>
2\.1.5 Add screened data to sum<br/>
2\.2 Calculate the mean from the sum<br/>
2\.2.1 Count data that were summarized (exclude missing data)<br/>
2\.3 Append mean to growing list of summary data<br/>

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

**2\.1 Step through all data in column for quantity and sum for period to be averaged**<br/>
**2\.1.1 Determine the limits of the period for that analysis**

The limits you choose will either be a range of months or years. The easiest way to loop through years is to treat them as numbers and use a `range()` object to generate them. The months are tricker, since they need to have leading zeros. So it's easier to create a list of strings like: `['01', '02', '03', ...'12']`. 

**2\.1.2 Extract year or month from date string if necessary**

The date strings are in ISO 8601 format: `2022-03-29` in the order of year-month-day. To get the year, you need to slice the first four characters. However, the loop variable is an integer, so to compare the loop variable to the extracted year you need to either make them both strings or both integers. For months, you also need to slice the date string, but if you are looping through a list of strings for the months, you can make the comparison directly.





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


