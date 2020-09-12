# --------------------
# Lists
# --------------------

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
animal <- c("frog", "spider", "worm", "bee")
number_legs <- c(4,8,0,6) # vector of numbers
organism_info <- data.frame(group, animal, number_legs)

# Referring to parts of a data frame
organism_info$animal # column by name
organism_info[2,1] # cell by row, column
organism_info$animal[4] # cell by column name and position in column

# Loading data from a CSV into a data frame
my_data_frame <- read.csv("~/test.csv")  # by a path (Mac home directory)
my_data_frame <- read.csv("c:\temp\test.csv")  # by a path (Windows C: drive)
my_data_frame <- read.csv(file.choose())  # by a file-choosing dialog
# from a URL:
my_data_frame <- read.csv("https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv") 

# Examining a data frame

# head() shows the first 6 rows
# tail() shows the last 6 rows
# names() returns the column names
# str() describes the structure of the data frame with information about each column
head(my_data_frame)
tail(my_data_frame)
names(my_data_frame)
str(my_data_frame)

# -------------------
# Homework
# ------------------

