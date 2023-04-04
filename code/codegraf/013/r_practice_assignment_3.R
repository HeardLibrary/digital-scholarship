# Practice assignment 3.

# Write your code in the space after the comment prompt for each problem. Write any 
# verbal answers to the problems as comments following the prompt.

# Problem 1. 
# A. We are going to continue with where we left off in last lesson’s practice assignment. 
# Load the Nashville schools data using the URL below. Again, create a vector that contains the total 
# number of students in the schools by adding the male and female columns.
schools_data_df <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")


# B. Calculate the fraction of students that are economically disadvantaged. 


# C. Compare a histogram of the number of students who are economically disadvantaged in each school 
# with a historgram of the fraction of students who are economically disadvantaged. 
# How are the two histograms different?


# Problem 2.
# A. Look at the data table at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/gis/wg/Metro_Nashville_Schools.csv 
# Some of the schools have blank cells for limited English proficiency. 
# Should we should assume that those schools have values of zero or that the empty cells represent missing data? 
# If you think they should be zeros, fix that before you analyze the data. 


# B. Calculate the fraction of the students who have limited English proficiency. 


# C. Create a scatterplot of fraction economically disadvantaged (y) vs. fraction limited English proficiency (x).


# D. Generate a linear model of fraction economically disadvantaged (y) vs. fraction limited English proficiency (x) 
# and superimpose a trendline on top of your scatterplot from Problem 2. 


# E. Generate the summary statistics for this linear regression. Statistical notes: This is a better analysis 
# than what I did with the totals in the video because the totals data were not normally distributed. 
# However, there is also somewhat of an implicit assumption when you do a regression that y depends on x. 
# Is that a safe assumption in this case?


# Problem 3. 
# A. The World Bank has assembled data on World Development Indicators. We will examine some data on Women and 
# Development downloaded from their Data Catalog at http://wdi.worldbank.org/table/WV.5 
# A downloaded Excel file is archived at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/WV.5_Women_and_Development.xlsx . 
# The Excel file has a lot of extraneous rows that would not read into R, so the data have been cleaned up a 
# little in this CSV: https://gist.github.com/baskaufs/510972a23e3153edc133e33a2fcdf3d1. 
# Notice the non-standard missing data indicator ... Click on the Raw button to get the URL of the raw CSV data 
# and use that URL to load the data as a normal data frame using read.csv(). 


# B. Use the na.strings attribute to convert cells containing the character string ".." into R’s NA missing data indicator.


# C. Notice that the data frame contains 12 lines at the end that are summary data and not data about individual 
# countries. We do not want to include those lines when doing a country-by-country analysis. Create a vector that 
# contains the 2017 female life expectancy at birth for all of the countries, but not the summary rows. 


# D. Calculate the average of the country-by-country life expectancy. Is your answer the same as the average 
# for the World given at the end of the table? Should it be? Why or why not?


# E. Using the “nondiscrimination clause mentions gender in the constitution” column as a discontinuous factor 
# for x and percentage of women ages 20-24 first married by age 18 as a continuous factor for y, generate a 
# box-and-whisker plot. Is there a difference between countries that mention gender in a nondiscrimination 
# clause in their constitution and those that do not? Don’t forget about excluding the lines at the bottom!


# F. Create an x-y scatterplot visualizing the relationship between female financial account ownership and 
# percentage of seats in parliaments held by women. The summary of the model may help interpret the nature of the 
# relationship, if any.

