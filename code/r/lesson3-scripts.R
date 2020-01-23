# ------------------
# More file stuff (for reference)
# ------------------

# When you hard code a file name in a script in a script with no path, 
# R will assume the file is in your current working directory.
# If you don't know what that is, you can find out using:

getwd()

# You can change the working directory using the setwd() function.  For example:
setwd("~/Documents/r/")
# would change the working directory to the "r" subdirectory of the Documents folder on a Mac.

# The openxlsx package can read an Excel file into a data frame.
# To load the package then read in the file:

library(openxlsx)
data_frame <- read.xlsx(xlsxFile = "my_file.xlsx", sheet = 'name_of_sheet')

# The sheet argument is optional.
# you can also use file.choose() to select the file interactively:

data_frame <- read.xlsx(file.choose())

# ----------------
# Exploring the relationship between two continuous variables
# ----------------

# The Nashville schools data contains information about the number of economically disadvantaged students
# and the number of students with limited English proficiency. It might be interesting to see if 
# limited English was related to being economically disadvantaged.

# Reload schools data if necessary

schools_data <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")

# Calculate the fraction of students that are economically 
# disadvantaged and the fraction that have limited English proficiency.
# Recall that the operations (adding and dividing) will be carried out in a 
# pairwise manner on all items in the vectors.

total_students <- schools_data$Male + schools_data$Female
fraction_limited_proficiency <- schools_data$Limited.English.Proficiency / total_students
fraction_economically_disadvantaged <- schools_data$Economically.Disadvantaged / total_students

# It's easy to create an X,Y scatterplot of the data using the syntax:
# plot(y ~ x)

plot(fraction_economically_disadvantaged ~ fraction_limited_proficiency)

# The plot appears in the lower right pane.

# Evaluating the relationship:

# Fit these two data to a linear model using
# model <- lm(y ~ x)
# but replacing x with the limited English proficiency variable
# and y with the exonomically disadvantaged variable

model <- lm(fraction_economically_disadvantaged ~ fraction_limited_proficiency)

# Displaying the model will tell us the details of the best fit line on our scatterplot

model

# We can add the best fit line to our plot using the abline() function:

abline(model)

# The relationship looks pretty weak.  We can test it statistically by looking at the
# full statistics for the regression:

summary(model)

# The P-value for the regression is totally non-significant at 0.554
# The fit to the line is also terrible with a very low R-squared of 0.002175
# Since we can't assign cause and effect to the variables, there isn't any good reason 
# for the choice of which variables to assign to X and Y.  
# You can try reversing X and Y to see what happens.

# Here is a script that does all of the steps at once:

schools_data <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")
total_students <- schools_data$Male + schools_data$Female
fraction_limited_proficiency <- schools_data$Limited.English.Proficiency / total_students
fraction_economically_disadvantaged <- schools_data$Economically.Disadvantaged / total_students
plot(fraction_economically_disadvantaged ~ fraction_limited_proficiency)
model <- lm(fraction_economically_disadvantaged ~ fraction_limited_proficiency)
model
abline(model)
summary(model)

# Clear all of the panes, then highlight the entire script and click Run to 
# see what happens if you run the whole script.

# -----------------
# Factors
# -----------------

# Create vectors

water_conditions <- c("wet", "wet", "dry", "wet", "dry", "wet")
height <- c(25, 21, 14, 13, 10, 18)

# Convert the character string vector into a factor

water_factor <- factor(water_conditions)

# Display the values of each data structure

water_conditions
water_factor
height

# ----------------------
# Exploring the differences between levels of a factor
# ----------------------

# This example uses some real data showing how a cockroach eye responds to different colors of light.

erg_dframe <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/red-green-anova-example.csv")

# Notice that the data frame has a third column that we aren't using in the analysis.
# R will just ignore it.

# If the values to be used for the bars are already in a vector, it's easy to make a bar plot.
# However, if the values to be plotted are the means of a level of a factor, an extra 
# step is required.

# The tapply() function applies a function to grouped values.  
# The first attribute is the vector to which the function should be applied
# The second attribute is the factor whose levels are used to group
# The third attribrute is the function to be applied to the grouped values

average_responses <- tapply(erg_dframe$response, erg_dframe$color, mean)

# The result is a kind of data structure (a matrix) that can relate factors and values:

average_responses

# The result of the function can be sent into the barplot() function to generate the plot

barplot(average_responses)

# Another way to plot the data is a box and whisker plot, which does not require first averaging the levels.
# The first argument of the plot() function is the factor and the second is the numeric variable to plot:

plot(erg_dframe$response ~ erg_dframe$color)

# Evaluating the difference statistically

# To determine if the difference between the red and green response is significant, we can run a t-test of means.
# In the first argument, the numeric variable comes before the tilde (~) and the factor comes after.

t.test(response ~ color, data=erg_dframe, var.equal=TRUE, conf.level=0.95)

# We can see that the p-value is much smaller than 0.05, so the difference is highly significant.

# --------------------------
# Extension: linear model and ANOVA
# --------------------------

# The previous example showed a comparison between the means of two levels of a factor.
# If a factor has more than two levels, a more complicated test is required.
# An appropriate statistical test in this situation is analysis of variance (ANOVA).

# Run the following code block to replace the previous data with data for three colors instead of two:

erg_dframe <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")

# Examine the distribution of data among the three levels of the experiment:

plot(erg_dframe$response ~ erg_dframe$color)

# It appears that there are large differences among the variables, with the red response much lower than blue and green.
# We can test this with an ANOVA.

# To perform an ANOVA, first create a linear model with the numeric data (color) listed before the tilde
# and the factor (category) data listed after the tilde.

model <- lm(erg_dframe$response ~ erg_dframe$color)

# An alternate way to specify the data is to list the source dataframe as a separate argument. That allows us to abbreviate the column names:

model <- lm(response ~ color, data = erg_dframe)

# To get the statistics the test, run the ANOVA function on the model:

anova(model)

# We can see that the p-value is very low (4.441 x 10^-6), indicating that the differences are highly significant.  
# Here's the script all in one place:

erg_dframe <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
plot(erg_dframe$response ~ erg_dframe$color)
model <- lm(erg_dframe$response ~ erg_dframe$color)
anova(model)

# -------------------------
# A general pattern
# -------------------------

# A general pattern that we see in the plot(), lm(), and t.test() functions is that the dependent variable
# is listed before the tilde and the independent variable is listed after the tilde (e.g. y ~ x).
# This is true regardless of whether the independent variable is a continuous number (as in plot and lm for regression) or 
# a discontinuous factor (as in t.test and lm for ANOVA).

# You should also note that in this and the following example we are grossly simplifying the process of statistical analysis.
# We have not checked any assumptions of the tests we are running, transformed data to make it more normal, etc.

# ------------------------
# Investigating the schools data
# ------------------------

# Reload schools data if necessary

schools_data <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")

# The data do not include the total number of students, so we can calculate it by adding the Male and Female columns:

total_students <- schools_data$Male + schools_data$Female

# Find the fraction of students that are white:

frac_white <- schools_data$White / total_students

# We can make a plot of fraction white by zip code:

plot(frac_white ~ schools_data$Zip.Code)

# Is this what we want?
# Are zip code and school name vectors or factors? What should they be?

schools_data$Zip.Code
schools_data$School.Name

# Convert to the other form

zip_code <- factor(schools_data$Zip.Code)
school_name <- as.character(schools_data$School.Name)

# Display the results

zip_code
school_name

# Try the plot again:

plot(frac_white ~ zip_code)

# Is this what we want?
# CHALLENGE: run an ANOVA on the zip code data to see if the differences in fraction white among zip codes are significant

