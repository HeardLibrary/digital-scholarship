# ******************************
# Loading data

# -----------------------------
# Reading in a CSV file from your drive into a data frame using read.csv()

# NOTE: all examples assume the first row is a header row and uses it to establish column names.

# Download this file: https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/t-test.csv
# by right clicking on the Raw button and saving to your hard drive.
# IMPORTANT: on Macs, GitHub flags the file as text, 
# so the default is to save the file with a .txt file extension.  Either change the Format to "All Files" 
# and the extension to .csv in the download dialog, or change the extension using Finder after the download.

# Here's the command to open a dialog to let you load the file from your drive:
df_from_file <- read.csv(file.choose())

# lets see what the two columns of the data frame look like:
df_from_file$grouping
class(df_from_file$grouping)
df_from_file$height
class(df_from_file$height)

# Notice that the grouping column is an instance of the "factor" class.
df_from_file <- read.csv(file.choose())

# It the CSV file does not have headers, you can add the "header = FALSE" argument:
df_from_file <- read.csv(file.choose(), header = FALSE)

# If you want to hard-code the file name you can replace the file.choose() function with the file name:

df_from_file <- read.csv("t-test.csv")

# However, it will assume the file is in your current working directory.
# If you don't know what that is, you can find out using:
getwd()

# You can change the working directory using the setwd() function.  For example:
setwd("~/Documents/r/")
# would change the working directory to the "r" subdirectory of the Documents folder on a Mac.


# -----------------------------
# Using a GitHub Gist URL

# Here's the same file posted as a Gist: https://gist.github.com/baskaufs/1a7a995c1b25d6e88b45
# To directly access the file through a URL, you need the URL of the raw data file, not its web page.
# Right-click on the Raw button and copy the link, or click on the Raw button and copy the URL from the URL box of the browser.

# This process is the same for any GitHub page (not just Gists).

# -----------------------------
# Reading a CSV file from a URL into a data frame using read.csv()

# Insert the URL of the raw CSV file between the quotes:

df_from_url <- read.csv(file="")

# Here's an example using the URL of the file online:
df_from_url <- read.csv(file="https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv")

# The remaining examples specify the file using file.choose(), but in each case, you can
# replace file.choose() with the file name (in quotes) or file="url" as in the exmples above.

# -----------------------------
# Installing tidyverse

# The tidyverse package includes many useful packages for working with tabular data.
# Install it if you haven't already.
install.packages("tidyverse")

# -----------------------------
# Loading CSV data into a Tibble

# Load the necessary package:
library(readr)
tibble_from_csv <- read_csv(file.choose())

# lets see what the two columns of the data frame look like:
tibble_from_csv$grouping
class(tibble_from_csv$grouping)
tibble_from_csv$height
class(tibble_from_csv$height)

# Notice that the grouping column is an instance of the "character" class, not a factor.

# -----------------------------
# Loading data from an Excel file using read_excel()

# The readxl package can read from Excel files (both .xls and .xlsx). It is also 
# included in the tidyverse package

# Load the package:
library(readxl)
tibble_from_xl <- read_excel(file.choose())

# As with read_csv, the grouping column contains characters, not factors.
# You can also specify the sheet to use:

another_tibble_from_xl <- read_excel(file.choose(), sheet = "t-test")

# For more details, see http://www.sthda.com/english/wiki/reading-data-from-excel-files-xls-xlsx-into-r

# ******************************
# Running statistical tests

# In many cases, running a statistical test in R requires a grouping variable that 
# is used to indicate which numeric values are associated with a particular level of a factor.
# Since character data are read in as factors in data frames, loading the data using read.csv() is good.
# However, R seems to be able to use tibbles where the levels are character strings as well, so read_excel() is also OK. 

# --------------------------------
# t-test of means

# We can easily run a t-test of meanis on the dataset we have been practicing loading.

heights_dframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/t-test.csv")
t.test(height ~ grouping, data=heights_dframe, var.equal=TRUE, conf.level=0.95)

# The first attribute of the t.test function states which columns of the data frame are used.
# The data column is first (the dependent variable), followed by a tilde and 
# the name of the factor column (the independent variable).  The 
# value of the data key specifies the data frame to use.  The other paramters provide
# technical details for the test.

# --------------------------------
# linear model and regression

# Several statistical tests involve creating a linear model, then running additional functions on that model.
# The simplest is a linear regression, which is performed directly when the model is created.

# The linear model can be directly constructed from two vectors.  In this example,
# x is the independent variable, and y is the dependent variable:

x <- c(1.5, 6.9, 3.2, 4.6)
y <- c(3.2, 13.0, 5.9, 8.9)
model <- lm(y ~ x)

# Displaying the model shows the slope and intercept:
model

# We usually don't want to hard-code the data in the script, so the data are usually in a dataframe.
# Here's some fake data on the effect of treat size on the rate that dogs wag their tails.
dogtail_dframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/dog-tail.csv")
model <- lm(wag_rate ~ treat_size, data=dogtail_dframe)

# This will show us the basic results of the regression:
model

# This will show us detailed results, including the R-squared value, which we usually want to know:
summary(model)

# --------------------------------
# linear model and ANOVA

# Another very common statistical test is analysis of variance (ANOVA).
# To perform an ANOVA, first create a linear model with the numeric data as the dependent
# variable and the factor (category) data as the independent variable.  Then run the ANOVA function on the model.

# This example uses some real data showing how a cockroach eye responds to red, green, and blue light.
# Notice that the data frame has a third column that we aren't using in the analysis.
# R will just ignore it.
erg_dframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
model <- lm(response ~ color, data = erg_dframe)  # fit a linear model to the data
anova(model)  #run the ANOVA on the model

# ***************************
# Plots

# It's pretty simple to create plots using R's built-in graphing functions.  
# For fancier plots, you need to learn to use the ggplot library.

# --------------------------------
# Adding a scatter plot to a regression

# Here's a scatter plot of the dog tail-wagging data:

dogtail_dframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/dog-tail.csv")
plot(wag_rate ~ treat_size, data=dogtailDframe)

# The best-fit trend line from the regression can be added to the plot:
model <- lm(wag_rate ~ treat_size, data=dogtail_dframe)
abline(model)

# Show the regression data:
model

# Adding a bar chart to an ANOVA

# --------------------------------
# Creating a bar plot

# If the values to be used for the bars are already in a vector, it's easy to make a bar plot.
# However, if the values to be plotted are the means of a level of a factor, an extra 
# step is required.

# The tapply() function applies a function to grouped values.  
# The first attribute is the vector to which the function should be applied
# The second attribute is the factor whose levels are used to group
# The third attribrute is the function to be applied to the grouped values
erg_dframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
average_responses <- tapply(erg_dframe$response, erg_dframe$color, mean)
average_responses

# The result of the function can be sent into the barplot() function to generate the plot
barplot(average_responses)

# Another way to display the data is a box and whisker plot, which does not require first averaging the levels:
plot(erg_dframe$color, y = erg_dframe$response)

# The plot can be conbined with the ANOVA into a single script that analyzes and visualizes the data:
erg_dframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
average_responses <- tapply(erg_dframe$response, erg_dframe$color, mean)
barplot(average_responses)
model <- lm(response ~ color, data = erg_dframe)  # fit a linear model to the data
anova(model)

# ***************************
# Exploring a dataset
#
# Data on Metro Nashville schools is at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/gis/wg/Metro_Nashville_Schools.csv
# Don't forget that to get the actual data (as opposed to the web page) you need to get the Raw file link by right-clicking on the Raw button.
# Read the file in as a data frame.  Use the environment to look at the data frame.  How are the missing data represented?
schools_dframe <- read.csv(file="https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")

# To get a summary of the first few rows of the table, use the head() function.
head(schools_dframe)

# The data do not include the total number of students, so we can calculate it by adding the Male and Female columns:
total_students <- schools_dframe$Male + schools_dframe$Female
# Notice that since both columns are vectors, adding the vectors performs the operation 
# on every item in the vector and creates another vector as the output.

# Find the fraction of students that are white:
frac_white <- schools_dframe$White / total_students

# We can make a plot of fraction white by zip code:
plot(schools_dframe$Zip.Code, y = frac_white)

# This isn't really what we want since we really want zip code to be a factor but it's a number.
class(schools_dframe$Zip.Code)

# We can coerce it to be a factor
zip_code_factor <- as.factor(schools_dframe$Zip.Code)

# Try the plot again:
plot(zip_code_factor, y = frac_white)

# Plot by school level:
plot(schools_dframe$School.Level, y = frac_white)
