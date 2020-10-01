# ------------------
# More data wrangling and piping
# ------------------

# Load the whole tidyverse if you have it
library(tidyverse)

# Load the packages we need separately if not
library(readr)
library(dplyr)

# ------------------
# Replacing values
# ------------------

# read in the fake grades
filename <- "https://gist.githubusercontent.com/baskaufs/ca8d32c1479de9e23cb93088ab8feef0/raw/1f94848c49f8b2e20e7bc93c890ac9caf5caa921/grades.csv"
grades <- read_csv(filename)
grades

# students who haven't finished the paper have until the end of the course, so use NAs
# students who didn't make up the test get zeros
grades$tests
is.na(grades$tests)
replace(grades$tests, is.na(grades$tests), 0)

# we want to add a numeric value for participation so that we can average it.
grades$participation

# does not work because it doesn't handle "fail" and forces vector to character
replace(grades$participation, grades$participation=="pass", 100)

# ifelse() function
boolean_vector <- c(TRUE, FALSE, FALSE, TRUE, TRUE)
boolean_vector
ifelse(boolean_vector, "yay!", "what?")

# handles "else" condition.
grades$participation
grades$participation=="pass"
ifelse(grades$participation=="pass", 100, 50)

# could go the other way if desired
grades$paper
ifelse(grades$paper >= 70, "pass", "fail")

# ------------------
# Where to put the replacements?
# ------------------

# Use mutate to add a new column "participation_numeric"
# *NOTE* If data frame is specified as first argument, only column names must be specified

# Only display tibble result:
mutate(grades, participation_numeric = ifelse(participation=="pass", 100, 50))

# Assign to a new tibble after adding
new_tibble <- mutate(grades, participation_numeric = ifelse(participation=="pass", 100, 50))
new_tibble

# Reassign to the same tibble after adding
grades
grades <- mutate(grades, participation_numeric = ifelse(participation=="pass", 100, 50))
grades

# Reassign to the same tibble replacing the source column
grades <- read_csv(filename)
grades
grades <- mutate(grades, participation = ifelse(participation=="pass", 100, 50))
grades

# ------------------
# Simple data pipeline using R
# ------------------

# In a data "pipeline", the data move through a series of transformation operations. 

# read the CSV data into a tibble
filename <- "https://gist.githubusercontent.com/baskaufs/ca8d32c1479de9e23cb93088ab8feef0/raw/1f94848c49f8b2e20e7bc93c890ac9caf5caa921/grades.csv"
grades <- read_csv(filename)
grades

# replace the NAs in the test category with zeros "in place"
fixed_tests <- mutate(grades, tests = replace(tests, is.na(tests), 0))
fixed_tests

# convert the participation from pass/fail to score
fixed_participation <- mutate(fixed_tests, participation = ifelse(participation=="pass", 100, 50))
fixed_participation

# create a new tibble with only the student names and their averages
average_only <- transmute(fixed_participation, name, average = (tests + paper + participation)/3)
average_only

# fliter out students who haven't completed their work
final_average <- filter(average_only, !is.na(average))
final_average

# arrange by averages ascending
arrange(final_average, average)

# or descending
arrange(final_average, desc(average))

# ------------------
# Pipelines using pipes
# ------------------

# Wickham and Grolemund Chapter 18 Pipes https://r4ds.had.co.nz/pipes.html

# Pipes were developed in the magrittr package
library(magrittr)

# Grades modifications sequentially
# Read file, replace test zeros, make numeric participation, calculate average, remove NAs, sort descending
filename <- "https://gist.githubusercontent.com/baskaufs/ca8d32c1479de9e23cb93088ab8feef0/raw/1f94848c49f8b2e20e7bc93c890ac9caf5caa921/grades.csv"
grades <- read_csv(filename)
fixed_tests <- mutate(grades, tests = replace(tests, is.na(tests), 0))
fixed_participation <- mutate(fixed_tests, participation = ifelse(participation=="pass", 100, 50))
average_only <- transmute(fixed_participation, name, average = (tests + paper + participation)/3)
final_average <- filter(average_only, !is.na(average))
arrange(final_average, desc(average))

# Pipe symbol %>% sends output from one function into the next function as the data source
# Data source in function needs to be the first argument.
# In the pipeline, the first argument (tibble name) is omitted.

# Output goes to the console
library(readr)
library(dplyr)
library(magrittr)

read_csv("https://gist.githubusercontent.com/baskaufs/ca8d32c1479de9e23cb93088ab8feef0/raw/1f94848c49f8b2e20e7bc93c890ac9caf5caa921/grades.csv") %>%
  mutate(tests = replace(tests, is.na(tests), 0)) %>%
  mutate(participation = ifelse(participation=="pass", 100, 50)) %>%
  transmute(name, average = (tests + paper + participation)/3) %>%
  filter(!is.na(average)) %>%
  arrange(desc(average))

# Piping eliminates the need for many named intermediate objects and is easier to follow

# To assign the output value of the pipe to an object, use the assignment operator

summary <- read_csv("https://gist.githubusercontent.com/baskaufs/ca8d32c1479de9e23cb93088ab8feef0/raw/1f94848c49f8b2e20e7bc93c890ac9caf5caa921/grades.csv") %>%
  mutate(tests = replace(tests, is.na(tests), 0)) %>%
  mutate(participation = ifelse(participation=="pass", 100, 50)) %>%
  transmute(name, average = (tests + paper + participation)/3) %>%
  filter(!is.na(average)) %>%
  arrange(desc(average))

summary

# output directly to a file

# find out where the file is going to be saved (current working directory)
getwd()

read_csv("https://gist.githubusercontent.com/baskaufs/ca8d32c1479de9e23cb93088ab8feef0/raw/1f94848c49f8b2e20e7bc93c890ac9caf5caa921/grades.csv") %>%
  mutate(tests = replace(tests, is.na(tests), 0)) %>%
  mutate(participation = ifelse(participation=="pass", 100, 50)) %>%
  transmute(name, average = (tests + paper + participation)/3) %>%
  filter(!is.na(average)) %>%
  arrange(desc(average)) %>% 
  write_csv("grades-output.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# If the data are already in a tibble (or generic data frame), the tibble can be piped in directly:
grades %>%
  mutate(tests = replace(tests, is.na(tests), 0)) %>%
  mutate(participation = ifelse(participation=="pass", 100, 50)) %>%
  transmute(name, average = (tests + paper + participation)/3) %>%
  filter(!is.na(average)) %>%
  arrange(desc(average))

# ------------------
# Practice
# ------------------

# Use this code to start on the practice assignment
schools_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")
