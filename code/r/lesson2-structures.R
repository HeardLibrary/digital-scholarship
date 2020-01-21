# --------------------------
# Vectors
# --------------------------

# create a vector of numbers
number_vector <- c(1, 3, 6, 10, 15)

# create a vector of character strings
animal <- c("frog", "spider", "worm", "bee")

# create sequences
number_range <- 3:9
count_down <- 10:0
go_negative <- 5:-3

# display properties of a vector
length(animal)
mode(animal)

# referencing parts of a vector
animal[3]
animal[2] <- "arachnid"
animal[2:4]

# single items are vectors
an_item <- "some character string"
length(an_item)
an_item[1]

# applying a function to a vector
sqrt(number_vector)

# creating a matrix
a_vector <- c(1.1, 1.2, 2.1, 2.2, 3.1, 3.2)
a_matrix <- matrix(a_vector, 2, 3)
a_matrix

# a vector with a missing data value
vector_with_missing <- c(1, 2, NA, 3)

# see what happens when you try to calculate the average of a vector with missing data
mean(number_vector)
mean(vector_with_missing)

# --------------------
# Lists
# --------------------

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

# loading data from a CSV into a data frame
my_data_frame <- read.csv("~/test.csv")  # by a path (Mac home directory)
my_data_frame <- read.csv("c:\temp\test.csv")  # by a path (Windows C: drive)
my_data_frame <- read.csv(file.choose())  # by a file-choosing dialog
# from a URL:
my_data_frame <- read.csv("https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv") 

# -------------------
# Homework
# ------------------

# Explore the data at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/gis/wg/Metro_Nashville_Schools.csv

# Use this line to load the data into a data frame
schools_data <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")

# 1. What does read.csv do when column headers have spaces in them?



# 2. Display the values in the zip code column


# 3. How many values are there in the zip code column?


# 4. Calculate the number of students in each school by adding the values in the male and female columns


# 5. Calculate the fraction of students that are white in each school


# 6. Calculate the average fraction of white students by school


