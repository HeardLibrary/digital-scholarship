# Practice assignment 4.

# Write your code in the space after the comment prompt for each problem. Write any 
# verbal answers to the problems as comments following the prompt.

# Problem 1. Tidying data.
# A. Read the Nashville Schools data into a tibble. Select the School Name, Zip Code, Male, and Female columns and 
# assign them to another tibble. 


# B. Convert that tibble to a “tidy” tibble by stacking the Male and Female columns into a single “key” column named 
# "gender". The “values” column should be composed of the counts in the Male and Female columns – you can call that 
# new column "counts".


# Problem 2. Working with column data types.
# A. What kind of objects are the zip codes? Use the str() function to find out. 


# B. Starting with the “tidy” tibble you # created in the last problem, use the filter() function to select 
# only the rows that have a zip code of 37211. Assign those rows to a new tibble. 


# B. Convert the new gender column from character strings to a factor using the as.factor() function, then create a 
# box and whisker plot of counts vs. gender.


# Problem 3. Adding a column to a table.
# Use the mutate() function to add a total column to the schools data that is the sum of the Male and Female 
# columns. (You’ll need to use the male and female columns from the original tibble, not the new one you just 
# created.) Assign the result to a new tibble.


# Problem 4. Creating a new table from parts of another table.
# A. Apply the transmutate() function to the new tibble from the last problem to create a new tibble that contains 
# the relative (i.e. fractional) values of the Economically Disadvantaged, Disability, and Limited English 
# Proficiency columns. Hint: divide each of those columns by the Totals column that you just created. 


# B. Notice that the Limited English Proficiency and Disadvantaged columns have some NA values that should 
# probably be zeros. Use the method from the last lesson to change them from NA to 0 “in place” in the tibble. 


# C. Create two scatterplots: Economically Disadvantaged vs. Disability, and Limited English Proficiency vs. 
# Disability and superimpose a trendline on the plots to examine the relationship between the factors. 


# D. This analysis is pretty badly flawed from a statistical point of view, but if it were valid, are there any 
# reasonable interpretations of the data?

