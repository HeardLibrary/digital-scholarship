---
permalink: /script/python/projects/ideas/
title: project ideas
breadcrumb: ideas
---

# Generic project ideas

1. Create a game that involves the computer generating a string or numeric value and the user has to guess what it is based on some kind of clues given by the computer.
2. Create a progam the uses information about the time or date to decide on some action determined by user input.
3. Create a program that builds a list based on user input, then manipulates that list in some meaningful way. The user should be able to control the number of items in the list.
4. Create a data dictionary involving some kind of useful information and create a script that allows a user to enter data to discover information based on their input.
5. Create a program that performs some useful or useless task a ridiculous number of times and performs some kind of calculation or manipulation of the data as it loops.
6. Create a program that allows a user to enter a string, then the program manipulates the string in some interesting way based on feedback from the user.
7. Try to write a program that will pass the "Turing Test". Check strings that are input by the user and have the computer respond based on the content of the user's input.

# EES project ideas

## Project learning objectives:

The students will:
- acquire data from a tabular data source and load it into a Python data structure (list of dictionaries).
- extract necessary data from the data structure and wrangle it into a form usable in their analysis.
- use the basic Python structures and statements they have learned: `if`, `for`, `input`, assignment, use a function from a module.
- create a simple visualization using `matplotlib.pyplot`. 

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
