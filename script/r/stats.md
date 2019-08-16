---
permalink: /script/r/stats/
title: R scripts for basic stats
breadcrumb: Stats
---

return to [Where do I go from here?](../next/)

go to [Getting started with R and RStudio](../)

# R Scripts for Basic Stats

This page contains scripts for several basic statistical tests and one more complex test (ANOVA). This lesson assumes that you have RStudio installed on your computer and are familiar with the lessons [Navigating around in RStudio](../navigate/) and [Introduction to R data structures](../structures/).  If you haven't already studied them, you should look at them first.

In each test, the first line of the script as written retrieves a CSV file from the [DiSC Office's GitHub code repo](https://github.com/HeardLibrary/digital-scholarship) using a URL.  If you are going to use the script with your own data from your hard drive, you will need to substitute the following line for the first line of the script:

```
myDataFrame <- read.csv(file.choose())
```

You'll need to replace `myDataFrame` with whatever name was used for the data frame in the example.  See [Methods for reading CSV data into data frames](https://heardlibrary.github.io/digital-scholarship/script/r/structures/#methods-for-reading-csv-data-into-data-frames) for more information.  

## t-test of means

A t-test of means assesses the difference between two levels of a single factor.  In this example, the factor is gender and the levels are `men` and `women`.  The dependent variable (response) is named `height` and has numeric values.  In order for R to carry out the test, the data need to be arranged with one column for the grouping variable designating gender and a second column containing the height data, like this:  

![](../images/t-test-table-grouping-variable.png)

Data arranged in this manner is called ["tidy data"](https://heardlibrary.github.io/digital-scholarship/script/r/next/#tidy-data).  **Important note:** because of the difference between the way that R handles numeric and string data when it loads it into a data frame, it is important that any grouping variable that you use in the source CSV file contain non-numeric characters.  See [Data types in data frames and tibbles](https://heardlibrary.github.io/digital-scholarship/script/r/structures/#data-types-in-data-frames-and-tibbles) for details. 

Here's the script to perform the t-test of means on [these data](https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/t-test.csv):

```
heightsDframe = read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/t-test.csv")
t.test(height ~ grouping, data=heightsDframe, var.equal=TRUE, conf.level=0.95)
```

You can run the script by pasting it into the editor pane, highlighting (selecting) both lines, and clicking the **Run** button.  You could also enter each of the two lines one at a time in the Console pane, but that would be more work.  If you have forgotten how the RStudio GUI is laid out, please review [The RStudio GUI](https://heardlibrary.github.io/digital-scholarship/script/r/navigate/#the-rstudio-gui).

The results of the test show up in the Console pane.  The *P*-value of 0.01711 indicates that the heights of men and women are significantly different based on these data.  

In `height ~ grouping` of the second line of the script, `height` is the name of the column containing the data and `grouping` is the name of the column containing the grouping variable.  We can see that the columns in the data frame are laid out in this way by clicking on the name of the data frame (`heightsDframe`) in the workspace summary in the upper right pane of RStudio.  The data frame will be displayed in table form in the upper left pane where you can verify that `height` and `grouping` are actually the names used in the headers of the appropriate columns.  If the data you want to analyze have different column headers, you'll need to change the script to the appropriate column names.  

## paired t-test

A paired t-test differs from a t-test of means in that particular observations in one of the two groups is paired in some way with a particular observation in the other group.  For that reason, the layout of a data frame for a paired t-test is different than the layout for a t-test of means.  

table here

```
t.test(Data$no_malonate, Data$malonate, paired=TRUE, conf.level=0.95)
```

----
Revised 2019-08-16
