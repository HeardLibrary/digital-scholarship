---
permalink: /script/python/projects/ees/
title: EES project
breadcrumb: ees
---

# EES project ideas

## Project learning objectives:

The students will:
- acquire data from a tabular data source and load it into a Python data structure (list of dictionaries).
- extract necessary data from the data structure and wrangle it into a form usable in their analysis.
- use the basic Python structures and statements they have learned: `if`, `for`, `input`, assignment, use a function from a module.
- create a simple visualization using `matplotlib.pyplot`. 

# Tasks and subtasks

1\ Acquire data
1\.1 Use script-defined function (provided) to load CSV from URL to a list of dictionaries

2\ Calculate means for desired quantity (rainfall, temperature)
2\.1 Step through all data in column for quantity and sum for period to be averaged
2\.1.1 Determine the limits of the period for that analysis
2\.1.2 Extract year or month from date string if necessary
2\.1.3 Screen whether a particular datum is from the correct time interval
2\.1.4 Skip missing data
2\.1.5 Add screened data to sum
2\.2 Calculate the mean from the sum
2\.2.1 Count data that were summarized (exclude missing data)
2\.3 Append mean to growing list of summary data

3\ Visualize data
3\.1 Set up subplot
3\.1.1 Create subplot
3\.1.2 Label axes
3\.2 Plot data using appropriate style (scatterplot, bar, error bars)
3\.3 Add trendline if appropriate
3\.3.1 Fit linear polynomial to summary data
3\.3.2 Add polynomial data to plot

## Task details

For particular tasks, it is best to start with the narrowest subtasks and work your way to the broader tasks.

1\ Acquire data

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

## Data aquisition

1. Go to <https://www.ncdc.noaa.gov/cdo-web/>
2. Click on Search tools.
3. Dataset: Global Summary of the Month. Date range: 1900-01-01 to 2022-02-01. Search for: Cities. Search term: (city of interest)
4. If city shows up, click on `View Full Details`. Click on `Station List`. Find a station with a long time interval and good coverage. Click on the station link. Mesa 1896-2017
Cli click add to cart. Then click on cart in upper right.
5. On output format, choose CSV. You can adjust the date range to an earlier date at this time. Click continue.
6. On custom outputs page, change units to metric. Select `Precipitation` and `Air Temperature` as output options. Click Continue.
7. Add your email address, then click Submit Order.
8. Check your email. First you should get a notification that your order was submitted. In a few minutes, you should get another email saying that you order is complete. Click the `Download` link in the email and save the file somewhere you can find it.

## Plot types

mean rainfall by year, mean temperature by year (scatterplots)

mean rainfall by month (bar plot), mean max/min temp by month ("range" plot)
