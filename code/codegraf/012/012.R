# --------------------
# Lists
# --------------------

# recreate the animals vector
animal <- c("frog", "spider", "worm", "bee")

# create a list
thing <- list(fruit_kind="apple", euler=2.71828, vector_data=animal, curse="!@#$%")

# referencing list items
thing[[2]]
thing$curse


# --------------------
# Data frames
# --------------------

# Making a data frame from vectors
group <- c("reptile", "arachnid", "annelid", "insect") # vector of strings
animal <- c("lizard", "spider", "worm", "bee")
number_legs <- c(4,8,0,6) # vector of numbers
organism_info <- data.frame(group, animal, number_legs)

# Referring to parts of a data frame
organism_info$animal # column by name
organism_info[2,1] # cell by row, column
organism_info$animal[4] # cell by column name and position in column

# --------------------
# Loading data frames from files
# --------------------

# Loading data from a CSV into a data frame

# by a file-choosing dialog:
my_data_frame <- read.csv(file.choose())  
# from a URL:
my_data_frame <- read.csv("https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv") 

# from a hard-coded path:
my_data_frame <- read.csv("~/test.csv")  # by a path (Mac home directory)
my_data_frame <- read.csv("c:\temp\test.csv")  # by a path (Windows C: drive)

# When you hard code a file name in a script in a script with no path, 
# R will assume the file is in your current working directory.
# If you don't know what that is, you can find out using:

getwd()

# load a file from your current working directory:
my_data_frame <- read.csv("test.csv")

# You can change the working directory using the setwd() function.  For example:
setwd("~/Documents/r/")
# would change the working directory to the "r" subdirectory of the Documents folder on a Mac.


# --------------------
# More file loading options
# --------------------

# The openxlsx package can read an Excel file into a data frame.
# To load the package then read in the file:

library(openxlsx)
data_frame <- read.xlsx(xlsxFile = "my_file.xlsx", sheet = 'name_of_sheet')

# The sheet argument is optional.
# you can also use file.choose() to select the file interactively:

data_frame <- read.xlsx(file.choose())


# ------------------
# Tibbles
# ------------------

# tidyverse packages operate on tibbles, a special type of data frame. 
# When data frames are operated upon by a tidyverse function, the output is generally a tibble.
# The readr package provides analogs to read.csv() that loads CSV data as a tibble. 
# In particular, it does not automatically turn character strings into factors

library(readr)

# compare the two data structures by clicking on their listings in the global environment pane
erg_dframe <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
erg_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")

# They basically look the same
# Now compare their table summaries
str(erg_dframe)
str(erg_tibble)

# Notice the difference in how the block and color columns are read in.
# If the file has tab delimiters instead of commas, you can use read_tsv()

# For reference: how to write a tibble to a CSV file
write_csv(tibble_name, "file_name.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# Example uses common options (include column names, replace existing file if any).
# See https://readr.tidyverse.org/reference/write_delim.html for details.

# Opening a tab-separated values (TSV) file as a tibble
my_tibble <- read_tsv("test.tsv")


# ------------------
# Examining a data frame
# ------------------

# head() shows the first 6 rows
# tail() shows the last 6 rows
# names() returns the column names
# str() describes the structure of the data frame with information about each column
head(my_data_frame)
tail(my_data_frame)
names(my_data_frame)
str(my_data_frame)

# ------------------
# Operations on data frames
# ------------------

# Vector recycling
a <- c(1, 2)
b <- c(10, 15, 17, 5, 1)
a + b

# Recreate the organism_info data frame if necessary
number_wings <- c(0, 0, 0, 4)
number_appendages <- number_wings + organism_info$number_legs

# Recycling
calendar <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/calendar.csv")
weekdays <- c(0, 1, 1, 1, 1, 1, 0)
work_week_calls <- calendar$number_calls * weekdays

# -------------------
# Homework
# ------------------

# Read in as regular data frame
schools_data_df <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")
# Read in as tibble
schools_data <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")

# 1. What is the difference between how read.csv() and read_csv() treat spaces in column headers?


# 2. Display the values in the zip code column


# 3. How many values are there in the zip code column?


# 4. Calculate the total number of students in each school by adding the values in the male and female columns


# 5. Calculate the fraction of students that are white in each school
