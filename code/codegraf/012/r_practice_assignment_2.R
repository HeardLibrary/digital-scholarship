# Practice assignment 2.

# In the code that you write, for each object use a meaningful name in “snake case”.
# Write your code in the space after the comment prompt for each problem. Write any 
# verbal answers to the problems as comments following the prompt.

# Problem 1. Load the Nashville schools dataset two ways using the code below. 
# What is different about the way spaces in column headers are treated 
# in regular data frames created by read.csv() and tibbles created by read_csv() ?


# Read in as regular data frame
schools_data_df <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")
# Read in as tibble
schools_data <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")


# Problem 2. Display the values in the zip code column. Use the $ notation.


# Problem 3. How many values are there in the zip code column? Since a column is 
# basically a vector, we can use the length() function with it as we did with vectors.


# Problem 4. Calculate the total number of students in each school by adding the 
# values in the male and female columns. (Data on non-gender binary students are not available).


# Problem 5. Calculate the fraction of students that are white in each school.
# Use your answer from the previous question to calculate this.


# Problem 6. Try to load into a data frame some Excel file that you have on your local 
# drive into a data frame using the read.xlsx() function. If you are using Posit 
# Cloud, this takes two steps. First you need to use the Files pane in the lower 
# right to upload the file to your cloud directory. You can use file.choose() 
# to navigate to where you saved the file, or figure out the path and put it 
# directly in read.xlsx(). Once you've loaded the file, write code to display
# the first column in the console.


