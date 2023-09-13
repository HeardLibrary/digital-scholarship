---
permalink: /script/codegraf/013/
title: CodeGraf - R programming basics - Basic statistics, plots, and missing data
breadcrumb: O13
---

Previous lesson: [Lists and data frames](../012)

# R programming basics: Basic statistics, plots, and missing data

In this lesson, we will start using R data structures to do simple forms of data exploration through statistical calculations and plotting. In the process, we will learn the role that missing data plays in R data sets. We will also examine how the vectorized programming approach that is fundamental to R influences the way we code complex operations.

**Learning objectives** At the end of this lesson, the learner will be able to:
- describe the function that the missing data indicator `NA` serves in R data structures.
- list two types of cells in CSV files that might be interpreted as `NA` when loaded into an R data frame.
- calculate basic statistics on a vector: `length()`, `mean()`, `sd()`, `summary()`, and `quantile()`.
- describe how the procedural and vectorized programming paradigms differ.
- use the `is.na()` function to modify items in a vector or column of a data frame.
- create a histogram with `hist()`.
- create a box-and-whisker plot using `plot()`.
- create an x-y scatterplot using `plot()`.
- use the `lm()` function to generate a trendline for a scatterplot and to calculate statistical quantities related to linear regressions.

Total video time: 46 m 44 s

# Links

[Lesson R script at GitHub](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/013/013.R)

[Lesson slides](../slides/lesson013.pdf)

[CodeGraf intermediate lessons on Intro to Stats with R](https://heardlibrary.github.io/digital-scholarship/script/codegraf/r/stats/)

[CodeGraf intermediate lessons on Data visualization with R using ggplot](https://heardlibrary.github.io/digital-scholarship/script/codegraf/r/ggplot/)

## Standard graphics

The **graphics** package is included in the standard distribution, so many kinds of plots can be generated without installing any additional packages.  A standard reference book for R graphics is *R Graphics* by Paul Murrel (now in its third edition).  The book is available in print from online sellers, but some parts of older editions are available online, such as [chapters 1, 4, and 5 of the first edition](https://www.stat.auckland.ac.nz/~paul/RGraphics/RGraphicsChapters-1-4-5.pdf).  There are also [graph galleries for the figures in each chapter of the book](https://www.stat.auckland.ac.nz/~paul/RG2e/) that provide the code used to generate the plots. The second edition of *R Graphics* is available online to Vanderbilt users through our O'Reilly subscription. See the following paragraph for login information.

Another more brief reference is Chapter 10 of *R Cookbook, 2nd Edition* by Paul Teetor (print book), which shows how to generate many of the typical kinds of simple plots useful to R users. Vanderbilt users can find it by logging directly into the O'Reilly website, using VUNet ID and password at [this link](http://www.library.vanderbilt.edu/eres?id=1676). You can also try [this direct link to the book](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/). In order for the direct links to places in the book to work, you must be logged into the O'Reilly website. 

## Basic statistics

R Cookbook [chapter 9](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch09.html#GeneralStatistics) provides a brief introduction to statistical calculations. Because R was created to do stats, there are many, many references available. Some free online resources to get you started are [here](https://heardlibrary.github.io/digital-scholarship/script/r/next/#statistical-analysis-with-r). [CodeGraf intermediate lessons on Intro to Stats with R](https://heardlibrary.github.io/digital-scholarship/script/codegraf/r/stats/)



## Introduction (1m04s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/lQozOTrEwEU" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

# Missing data

## The missing data indicator NA (3m54s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/yOEAAFbjehY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The "not available" missing data indicator `NA` is written without quotes:

```
vector_with_missing <- c(1, 2, NA, 3)
```

Functions that will not return a value when data are missing can be forced to remove `NA` prior to calculating with `na.rm = TRUE`:

```
mean(vector_with_missing, na.rm = TRUE) # remove NAs, then calculate
```

----

## Missing data when reading from CSV files (9m16s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/N4tJtJSoTh0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`read_csv()` converts `""` (empty) and `"NA"` strings to `NA` missing data values when reading CSV data into tibbles.

The behavior of `read.csv()` is complicated with respect to the cells it treats as missing data when it reads values into traditional data frames. Specific strings can be specified to be considered missing data using an `na.strings` argument:

```
data_frame <- read.csv(url, na.strings = c("-9999", "NaN", "NA" ,"")) # all listed strings read as NA
```

A `colClasses = "character"` argument causes every value (including numbers) to be read as characters except for the string `"NA"`, which is still read as an `NA` value.

```
data_frame <- read.csv(url, colClasses = "character")
```

----

# Basic statistical quantites

## Calculating some statical quantities (7m27s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Nv3Tq_ki8HY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

```
length(vector) # returns the number of items in a vector
mean(vector) # returns the average (mean) of items in a vector
sd(vector) # returns the standard deviation of items in a vector
summary(vector) # summaries limits, mean, median, etc. of items in a vector
quantile(vector) # defaults to returning quartiles of a vector
```

To generate quantiles other than quartiles, use the `probs` argument. For example:

```
quantile(x, probs = seq(0, 1, 1/10)) 
```

will generate deciles.

----

# Procedural vs. vectorized programming paradigm

## Procedural vs. vectorized approaches (4m40s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/Y_rNZ_KQpKo" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

## The is.na() function (0m47s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/i3VqjttEE14" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

The `is.na()` function returns a boolean: `TRUE` if the argument is `NA` and `FALSE` otherwise.

```
is.na(NA) # returns TRUE
is.na(3) # returns FALSE
```

----

## Replacing NA with zeros (9m53s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/8jsL9o3c6MQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

[Code for Python example](https://gist.github.com/baskaufs/d7a85bbe23b39b3276b5b888c5493ad8)

Example with result in a separate vector:

```
schools_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")
asian <- schools_data$Asian # Asian column of data frame assigned to a named vector object
booleans_vector <- is.na(asian)
asian[booleans_vector] <- 0
mean(asian)
```

Example with replacement in the original column ("in place"):

```
schools_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")
schools_data$Asian[is.na(schools_data$Asian)] <- 0
mean(schools_data$Asian)
```

----


# Basic plots

[CodeGraf intermediate lessons on Data visualization with R using ggplot](https://heardlibrary.github.io/digital-scholarship/script/codegraf/r/ggplot/)

## Histograms (3m23s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/nR1Sm99vTwE" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

```
hist(vector)
```

----

## Box-and-whisker plot (2m34s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/lC3Pj_jhjIc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

A box-and-whisker plot is generated when the independent variable (x) is a discontinuous factor and the dependent variable (y) is continous (a numeric vector):

```
plot(y ~ x)
```

**NOTE: In version 3 of R and lower, character columns are automatically converted to factors when CSV files are read into traditional data frames using `read.csv()`. They are not converted when CSV files are read into tibbles using `read_csv()`, or when using `read.csv()` in R version 4.0 or greater.** To convert a character column to factors, place the column name inside the function `as.factor()`. For example, in a data frame named `df` with numeric column `y` and character column `x`, use:

```
plot(df$y ~ as.factor(df$x))
```

----

## Scatterplot with trendline (3m46s)

<iframe width="1120" height="630" src="https://www.youtube.com/embed/_xLWg_LYSYY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

An X-Y scatterplot is generated when the independent variable (x) and the dependent variable (y) are both continuous (numeric vectors):

```
plot(y ~ x)
```

To include a trend line, a linear model must be generated using the same variables:

```
model <- lm(y ~ x)
```

To overlay the trendline:

```
abline(model)
```

The model will provide information about the linear regression test:

```
model # gives slope and intercept of best-fit line
summary(model) # gives statistical quantities related to the regression
```

----

# Practice assignment

The practice assignment is [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/codegraf/013/r_practice_assignment_3.R). You will need to load it into the editor pane of RStudio.

It is best to try to complete each problem on your own before resorting to watching the solution videos below.

----

Problem 1 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/P25hVX29H04" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Problem 2 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/n0qb5XL2_rA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Problem 3 solution

<iframe width="1120" height="630" src="https://www.youtube.com/embed/oiNHCkMQWxY" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

----

Next lesson: [Tidy Data and basic data wrangling](../014a)

----
Revised 2023-08-22