# -------------------
# Homework answers
# ------------------

# Explore the data at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/gis/wg/Metro_Nashville_Schools.csv

# Use this line to load the data into a data frame
schools_data <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")

# 1. What does read.csv do when column headers have spaces in them?

# answer: It inserts a dot in place of the spaces

# 2. Display the values in the zip code column
schools_data$Zip.Code

# 3. How many values are there in the zip code column?
length(schools_data$Zip.Code)

# 4. Calculate the number of students in each school by adding the values in the male and female columns
total_students <- schools_data$Male + schools_data$Female

# 5. Calculate the fraction of students that are white in each school
fraction_white <- schools_data$White / total_students

# 6. Calculate the average fraction of white students by school
mean(fraction_white)

