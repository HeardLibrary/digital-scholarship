# Practice assignment 5.

# Write your code in the space after the comment prompt for each problem. Write any 
# verbal answers to the problems as comments following the prompt.

# Problem 1. 
# Load the Nashville schools data into a tibble using the first line of code below.
# Subset the data by pulling out only the rows that have "High School" as a value for 
# "School Level". Assign the result to a new tibble. Remember that when a column header
# contains a space, you must surround its name with backticks (`), which are different from 
# single quotes (').

schools_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")


# Problem 2. Add a totals column to the end of the tibble that is the sum of the "Male" 
# and "Female" column. Assign the resulting tibble to a new data object.


# Problem 3. Create two new columns that give the fraction of students that are 
# economically disadvantaged and that have limited English proficiency (i.e. divide 
# each of the original columns by the totals).


# Problem 4. Create a new tibble that has only the two columns you generated in the 
# last problem, the "totals" column, and the "School Name" column. You can do this 
# using the select() function on the output of the previous problem. Is there a 
# way you could do both this problem and the previous one using a single function?

  
# Problem 5. Sort the resulting tibble from the school with the most students to the 
# school with the least.


# Problem 6. Combine all of the steps in the previous problems into a single pipeline using 
# the %>% pipe operator. Assign the result to a tibble called relative_high_school. 
# Verify that this tibble is the same as the result that you got after problem 5.

