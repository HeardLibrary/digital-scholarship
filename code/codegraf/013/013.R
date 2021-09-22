# --------------------
# Missing data
# --------------------

vector_with_missing <- c(1, 2, NA, 3)
length(vector_with_missing)

# Some functions will not return a value if there are missing data
mean(vector_with_missing)
mean(vector_with_missing, na.rm = TRUE) # remove NAs, then calculate

# --------------------
# Loading CSV data with missing data
# --------------------

# See https://gist.github.com/baskaufs/6664d6873121f02c47dbe77a743de65d for the test CSV used in this exercise

# Load the CSV from a URL
library(readr)
url <- "https://gist.github.com/baskaufs/6664d6873121f02c47dbe77a743de65d/raw/c0f63a806795327fc159585475b75037239aaba5/people.csv"
data_tibble <- read_csv(url) # "" and "NA" converted to NA. All other strings unchanged.

data_frame <- read.csv(url) # "NA" converted to NA. Strings unchanged. Empty numeric cells to NA.
data_frame <- read.csv(url, na.strings = c("-9999", "NaN", "NA" ,"")) # all specified strings read as NA
data_frame <- read.csv(url, colClasses = "character") # everything (including numbers) read as characters (except "NA" read as NA)
# The situation is further complicated by the way character columns are read in as factors.

# --------------------
# Calculating basic statistical quantities
# --------------------

# examine basic stats for human heights
human_data <- read.csv("https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv")
length(human_data$height)
mean(human_data$height)
sd(human_data$height)
summary(human_data$height)
quantile(human_data$height)

# some stats for number of students in schools by category
url <- "https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv"
schools_data <- read_csv(url)

mean(schools_data$Female)
mean(schools_data$Asian)
mean(schools_data$Asian, na.rm = TRUE)

quantile(schools_data$Female)
quantile(schools_data$Asian)
quantile(schools_data$Asian, na.rm = TRUE)

# --------------------
# Replacing missing values with zeros using R
# --------------------

# is.na() function
is.na(NA)
is.na(3)

# Changes the values in the asian vector, but not within the data frame
schools_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")
asian <- schools_data$Asian # Asian column of data frame assigned to a named vector object
booleans_vector <- is.na(asian)
asian[booleans_vector] <- 0
mean(asian)

# Changes the value "in place" within the data frame
schools_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")
mean(schools_data$Asian, na.rm = TRUE)
schools_data$Asian[is.na(schools_data$Asian)] <- 0
mean(schools_data$Asian)

# --------------------
# Plots
# --------------------

# hist() function for histograms
human_data <- read.csv("https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv")
hist(human_data$height)

schools_data <- read.csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")
hist(schools_data$Female)

# Two-dimensional plots

# A simple way to compare two categories of data is a box and whisker plot.
# The category x is a discontinuous factor and the measurement y is a continuous variable. Use the form:
# plot(y ~ x)
# This only works for a data frame where characters are converted to factors.

plot(human_data$height ~ as.factor(human_data$grouping))

# It's easy to create an X,Y scatterplot of two continuous variables using the syntax:
# plot(y ~ x)
# Both x and y must be continuous numeric values.
plot(schools_data$Economically.Disadvantaged ~ schools_data$Limited.English.Proficiency)

# Fit these two data to a linear model using
# model <- lm(y ~ x)
# but replacing x with the limited English proficiency variable
# and y with the economically disadvantaged variable

model <- lm(schools_data$Economically.Disadvantaged ~ schools_data$Limited.English.Proficiency)

# Displaying the model will tell us the details of the best fit line on our scatterplot

model

# We can add the best fit line to our plot using the abline() function:

abline(model)

# The relationship looks pretty diffuse.  We can test it statistically by looking at the
# full statistics for the regression:

summary(model)
