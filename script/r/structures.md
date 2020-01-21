---
permalink: /script/r/structures/
title: Introduction to R data structures
breadcrumb: Data structures
---

go back to [Navigating around in RStudio](../navigate/)

# Introduction to R data structures

If you are a Vanderbilt user, you should be able to use your VUNet ID and password for free access to O'Reilly for Higher Education resources.  To access them, click [this link](http://www.library.vanderbilt.edu/eres?id=1676), then log in.  Sometimes it is necessary to close your browser, or clear your cookies to get access, so if you have problems, you can try that. It is also possible to navigate there by going to <https://www.library.vanderbilt.edu/>, select `DATABASES A-Z`, click on `O`, then select `O'Reilly for Higher Education`.

In this lesson, I'll reference some sections of the book, *R Cookbook, 2nd Edition*, which you can find by searching at the O'Reilly sight, or try [this direct link to the book](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/). The direct links in the text might work, otherwise navigate to the correct section by number.

**Comments**

Note on comments: comments can be added to R scripts to make them more understandable.  A comment starts with the `#` character and R simply ignores everything on the line after it.  Here's an example:

```
# simple script to demonstrate assignment
x <- c(1,2)  # the "arrow" points to the left to show the direction of the assignment
```

## The role of data structures in R

Like most programming languages, R defines a number of different kinds of structures for storing data.  These structures can hold multiple data items in a manner similar to structures that might be called arrays or lists in other languages, and could represent a column in a spreadsheet, or data tables. 

Data structures are particularly important in R because generally functions in R operate on entire data structures rather than on individual items within the structure.  In other words, if we want a function to act on every item in a data structure, we don't loop through the items in the structure - rather, we simply pass an appropriate data structure into the function and R automatically performs the functions action on all of the items in the structure.  For that reason, looping isn't as big a thing in R as it is in other programming languages such as Python.  

There are numerous data structures in R, but we will focus on the three most important.  Many of the other data structures are variations on these main structures, so understanding these three will make it easier to understand the others.

<img src="../images/vector-diagram.png" style="border:1px solid black">

## Vectors

R Cookbook [section 2.5](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch02.html#recipe-id038)

A *vector* is a one-dimensional data structure consisting of items of the same kind. This would be analogous to a column of data in a spreadsheet.  Vectors have a name that is used to refer to that particular instance of a vector.  The individual items in the vector can be referenced using their position in the vector, as shown in the diagram above.  Note: R is "one based", meaning that we start counting items at 1.  This is in contrast to Python, which is "zero based" (counting starts at 0).

We can construct a vector by explicitly entering its values using the `c()` (for "construct") function, like this:

```
animal <- c("frog", "spider", "worm", "bee")
```

Notice that in R, the assignment operator is `<-`, designed to look like a leftward pointing arrow since the data on the right is passed into the variable on the left. (One can also use the symbol `=` as the assignment operator, but using `<-` is more typical.)

![](../images/create-vector.png)

The screenshot above shows what happens when we create a vector using RStudio, then display the third item in the vector.

### Vector variants

R Cookbook [section 5.14](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch05.html#recipe-id062) 

R has two additional data structures that are similar to vectors: *matrices* and *arrays*.  Both of these structures are similar to vectors in that they can only contain one kind of data.  A matrix has two dimensions (analogous to multiple columns and rows of the same kind of data) and a vector can be turned into a matrix simply by assigning it two dimensions.  An array is similar, except that it can have any number of dimensions.  

Matrices and arrays are important data structures in cases where certain mathematical operations need to be performed efficiently on very large data sets.  You can learn more about them in any R reference work.

<img src="../images/list-diagram.png" style="border:1px solid black">

## Lists

R Cookbook [section 5.6](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch05.html#recipe-id053)

A *list* is also a one-dimensional data structure, like a vector.  However, the items in a list can be heterogeneous (different types of items).  In the diagram above, we see that the values in the list consist of two strings (characters listed in quotes), one number (no quotes), and the vector `animal` that we created earlier (with its name given without quotes).  

I can create the list in the diagram using this command (assuming that I've already created the `animal` vector):

```
thing <- list(fruitKind="apple", euler=2.71828, vectorData=animal, curse="!@#$%")
```

Notice that as I add items to the list, I can also assign names to each item.  The items can be referenced by those names.  This allows an R list to behave like a dictionary in Python or a JSON object consisting of name:value pairs.  (Note: names can also be assigned to items in a vector, although that is often not particularly useful.)

![](../images/create-list.png)

The screenshot above shows what happens when I create the list in RStudio using the console.  After the list is created, it shows up in the workspace summary (**Environment** tab in upper right pane).  Because lists can be complicated, the items in the list aren't shown there.  If I want to see the details of the list, I can click on the list in the summary and a new tab will open in the upper left pane showing me what is contained in the list.

As with vectors, you can refer to a particular item by its position in the list, like this:

```
thing[[2]]
```

Notice that when referring to an item in a list, you use two square brackets (vs. one square bracket for vectors).  You can also reference a list item by its name, for example:

```
thing$curse
```

<img src="../images/data-frame-diagram.png" style="border:1px solid black">

## Data frames

R Cookbook [section 5.18](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch05.html#recipe-id251)

Data frames are two dimensional data objects and are one of the most widely used data types in R.  One can think of a data frame as a table with rows and columns, with the top row containing column headers that are names describing what's in the columns.  

It is helpful to think of a data frame as a sort of combination of lists and vectors. The values in a particular column are like a vector, with the column header for that column containing the vector's name.  The set of columns is like a list whose items are vectors.

We can actually create a data frame by first constructing a vector for each column:

```
group <- c("reptile", "arachnid", "annelid", "insect")  # vector of strings
animal <- c("frog", "spider", "worm", "bee")
numberLegs <- c(4,8,0,6)  # vector of numbers
```

then loading the vectors into the data frame:

```
organismInfo <- data.frame(group, animal, numberLegs)
```

By default, R will use the name of each vector as the name for the column in the data frame.

![](../images/create-data-frame.png)

In the example screenshot above, I've chosen to save my script in a file called [organism-example.R](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/r/organism-example.R).  I loaded the script into the editor pane, highlighted all of the lines, then clicked **Run**.  As the script runs, each command is executed in the Console pane and each of the created data structures is listed in the **Environment** tab of the upper right pane.

![](../images/view-data-frame.png)

If I want to see what's actually in the data frame, I can click on the name of the data frame in the upper right pane "global environment" pane and a tab will open in the upper left editor pane showing the data frame in table form.

We can refer to a particular cell in the table by listing its row followed by its column in brackets, like this:

```
organismInfo[2,1]
```

Because the columns of a data frame behave somewhat like list items, the notation for referring to list items by name (dollar sign followed by name) can also be used to refer to columns in a data frame:

```
organismInfo$animal
```

and items in that column can be referred to by their position from the top of the column:

```
organismInfo$animal[4]
```

### Data types in data frames and tibbles

R Cookbook [section 5.4](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch05.html#recipe-id051)

R for Data Science [Chapter 10](https://r4ds.had.co.nz/tibbles.html) (no login required)

When data are read into a data frame, what happens to them depends on the type of data.  Numeric data remain as numeric data, but string data (e.g. non-numeric data enclosed in quotes) are converted into a special data type called *factor* when they are loaded into the data frame.  This format is useful when the data are intended to be used in statistical tests, and given that R was originally statistics-heavy, this automatic conversion makes some sense.  

R keeps track of the unique values of factors, which are known as the *levels* of the factor that are present.  ("Level" comes from experimental design terminology - also related to R's heavy statistical orientation.) The factors are stored in a more efficient way than strings, which improves performance when crunching large data sets.  In the screen shot above, displaying the value of a particular cell containing text results in not only the value of the cell, but a listing of all of the levels present in that column.  Levels are not listed when displaying the contents of a cell containing a number.

Factors are important when running statistical tests, since they are the means by which numeric data are assigned to groups ("grouping variables") as required by tests like t-test of means, ANOVA, and logistic regression.  

More recently, the use of R has expanded far beyond statistics, so automatically trasforming data into a form that is optimal for statistics is no longer necessarily desirable in every case.  Another two-dimensional data structure, called a *tibble*, was developed to broaden the use of data frames.  When data are read into a tibble, there is never a conversion of data types (strings remain strings).  The rules for column names are also relaxed over traditional data frames.  

### Methods for reading CSV data into data frames

R Cookbook [section 4.8](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch04.html#recipe-id027)

The method of loading data into a data frame by manually entering the items as part of the script is not efficient for large data sets.  Large sets of tabular data are commonly saved as files in comma separated values (CSV) format.  All common spreadsheet applications (such as Microsoft Excel, OpenOffice Calc, and Libre Office Calc) provide a way to export spreadsheet data in CSV format, so that's the best way to get a dataset from a spreasheet into R. If a spreadsheet contains multiple sheets, each one must be saved as a separate CSV file.  **To save an Excel sheet in CSV format, go to Save As… and select "CSV (Comma delimited) (*.csv)" from the "Save as type:" dropdown.** 

**Important note:** R can be much more picky about file names than other applications.  Here is some general advice about naming CSV files:

1. Don't use really long file names.
2. Don't use file names with spaces in them.  It's better to use underscores (`_`) or dashes (`-`) instead.
3. Pay attention to whether you use upper or lower case letters in the file names.  Unless you are using a systematic capitalization system like camelCase, it's a good idea to use only lower case letters.

There are two convenient ways to load CSV data into a data frame: loading it from a file on your local computer, and loading it through the Internet using a URL.  

**From your hard drive**

To load a CSV file from your local hard drive, we'll make use of an R function that initiates a "file open" dialog: `file.choose()`.  When the file open dialog is executed, a popup window lets you navigate to and select the file that you want to open.  **Important note:**  occasionally, the popup window is hidden behind the RStudio window.  So if you run the script and it seems to have gotten stuck, minimize the RStudio window and see if the file open dialog window was hiding underneath.

The `file.choose()` function reads the CSV file into R, but the data that has been read in isn't in the form of a data frame.  The function `read.csv` is used to convert CSV-formatted raw data into the data frame data structure.  So the file open function and the CSV conversion function can be put together into a combined function that both opens the file and converts the CSV:

```
myDataFrame <- read.csv(file.choose())
```

To practice using this function, download and save the file [t-test.csv](https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/t-test.csv) somewhere on your computer.  To do that, right click on the link in the previous sentence, and select **Save Link As...**.  After you have downloaded the file, paste the line in the example above into the Console pane of RStudio and press **Enter**.  The data frame `myDataFrame` should appear in the summary pane in the upper right, and if you click on its name, you can see the table in a tab in the upper left pane.  

**From a URL**

R Cookbook [section 4.10](https://learning-oreilly-com.proxy.library.vanderbilt.edu/library/view/r-cookbook-2nd/9781492040675/ch04.html#recipe-id031)

Sometimes a teacher, colleague, or a website might make a file available directly via a URL.  So an alternative to getting a CSV file from your computer's drive is to specify a URL that points to the file location at some place on the Internet.  One important consideration is that the URL must deliver the raw data file and not a web page.  You can see the distinction between the two by comparing:

<https://gist.github.com/baskaufs/1a7a995c1b25d6e88b45>

with

<https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv>

In the first case, the URL leads to a web page that displays the content of the CSV file formatted as an HTML table.  In the second case, the browser displays the actual characters that comprise the CSV file.  The second URL could be used to load the file as part of an R script, but the first URL would display an error. 

Here is the command that would read data from the file URL into a data frame:

```
myOtherDataFrame <- read.csv(file="https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv")
```

You can test this command by copying it and entering it into the Console pane of RStudio.  You should see the newly created data frame in the workspace summary pane (upper right) as in the previous example.  

If you have a GitHub account, creating a Gist is an easy way to make raw data available publicly through a URL.  Create the gist in the editing environment, then after creating a public Gist, click on the Raw button at the upper right of the screen.  Copy the URL from the browser's address box and paste it into the script between the quotes after the `file=` key as shown in the example above.

**Data from an Excel spreadsheet**

R Cookbook [section 4.11]()

The `openxlsx` package can read an Excel file into a data frame.  

To load the package then read in the file:

```
library(openxlsx)
data_frame <- read.xlsx(xlsxFile = "my_file.xlsx", sheet = 'name_of_sheet')
```

The `sheet` argument is optional.

The `readxl` package can read from Excel files (both .xls and .xlsx) into a tibble. It is also included in the `tidyverse` package.

To load the package then read in the file:

```
library(readxl)
tibble_from_xl <- read_excel(file.choose())
```

As with read_csv, the grouping column contains characters, not factors.

You can also specify the sheet to use:

```
another_tibble_from_xl <- read_excel(file.choose(), sheet = "t-test")
```

For more details, see <http://www.sthda.com/english/wiki/reading-data-from-excel-files-xls-xlsx-into-r>.

---

Continue to [Where to go from here](../next/)

----
Revised 2020-01-21
