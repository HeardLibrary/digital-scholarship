# Practice assignment 5.

# Write your code in the space after the comment prompt for each problem. Write any 
# verbal answers to the problems as comments following the prompt.

# Problem 1. 
# Load the Nashville schools data into a tibble using the first line of code below. As you did 
# in a previous lesson, add a totals column to the end of the tibble that is the sum of the "Male" 
# and "Female" column. Assign the resulting tibble to a new data object.

schools_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")

# Problem 2. For each row where the School Level column has a value of "Elementary School", 
# replace "Elementary School" with "Primary School". Remember that when a column header
# contains a space, you must surround its name with backticks (`), which are different from 
# single quotes (').


# Problem 3. Create a new column in the table called "Pacific Islanders" and populate it with a 
# value of "present" if there is a number in the "Native Hawaiian or Other Pacific Islander" column 
# and with a value of "absent" if there is a missing value.


# Problem 4. Sort the resulting tibble from the school with the most students to the 
# school with the least.


# Problem 5. Use the select() function to create a new data frame that contains only the School Level, 
# School Name, total number of students, and Pacific Islanders columns.


# Problem 6. Combine all of the steps in the previous problems into a single pipeline using 
# the %>% pipe operator. Assign the result to a tibble with a different name from the previuos one. 
# Verify that this tibble is the same as the result that you got after problem 5.

