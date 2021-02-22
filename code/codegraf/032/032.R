# Load the CSV from a URL
library(tidyverse) # if you load this, you don't need to load the other libraries
library(readr)
library(ggplot2)

# --------------------
# Plots
# --------------------

# **One-dimensional plot (histogram)**

# Generic R hist() function for histograms
schools_data <- read.csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")
hist(schools_data$Female)

# Create a histogram using ggplot
ggplot(data = schools_data) + geom_histogram(mapping = aes(x = Female), binwidth = 100)

# Assigning one of the functions to a variable
base_plot <- ggplot(data = schools_data)
base_plot + geom_histogram(mapping = aes(x = Female), binwidth = 100)

# For multiline, must have a trailing + sign.
ggplot(data = schools_data) +
  geom_histogram(mapping = aes(x = Female), binwidth = 100)

# **Two-dimensional plot: box and whisker**

human_data <- read.csv("https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv")

# A simple way to compare two categories of data is a box and whisker plot.
# The category x is a discontinuous factor and the measurement y is a continuous variable. 
# The generic R function uses the form:
# plot(y ~ x)
# This only works for a data frame where characters are read in as factors, NOT for tibbles.
# So read.csv() must be used, not read_csv().

str(human_data) 
# Notice that characters were read in as factors (normal for generic dataframes but not tibbles)

plot(human_data$height ~ human_data$grouping)

# ggplot typically uses tibbles, but doesn't seem to have a problem with a generic data frame
ggplot(data = human_data) +
  geom_boxplot(mapping = aes(x = grouping, y = height))

# Let's try reading in the data as a tibble instead of a vanilla data frame:
human_data_tibble <- read_csv("https://gist.githubusercontent.com/baskaufs/1a7a995c1b25d6e88b45/raw/4bb17ccc5c1e62c27627833a4f25380f27d30b35/t-test.csv")

str(human_data_tibble)
# Notice that when the data are read in as a tibble, the character column is not a factor.

# Nevertheless, ggplot still generates the same plot as before.
ggplot(data = human_data_tibble) +
  geom_boxplot(mapping = aes(x = grouping, y = height))

# **Two-dimensional plot: scatterplot**

# The standard R scatterplot uses the same syntax as for box and whisker:
# plot(y ~ x)
# with x as the limited English proficiency variable
# and y as the economically disadvantaged variable
# Both x and y must be continuous numeric values.
plot(schools_data$Economically.Disadvantaged ~ schools_data$Limited.English.Proficiency)

# Create a similar scatterplot using ggplot
ggplot(data = schools_data) +
  geom_point(mapping = aes(x = Limited.English.Proficiency, y = Economically.Disadvantaged))

# Fit these two data to a linear model using
# model <- lm(y ~ x)

model <- lm(schools_data$Economically.Disadvantaged ~ schools_data$Limited.English.Proficiency)

# We can add the best fit line to our plot using the abline() function:

plot(schools_data$Economically.Disadvantaged ~ schools_data$Limited.English.Proficiency)
abline(model)

# Create a scatterplot using ggplot that includes the best fit line through the data
ggplot(data = schools_data) +
  geom_point(mapping = aes(x = Limited.English.Proficiency, y = Economically.Disadvantaged)) +
  geom_smooth(mapping = aes(x = Limited.English.Proficiency, y = Economically.Disadvantaged), method = "lm")

# --------------------
# Alternate formatting
# --------------------

# using global mapping to reduce redundancy
ggplot(data = schools_data, mapping = aes(x = Limited.English.Proficiency, y = Economically.Disadvantaged)) +
  geom_point() +
  geom_smooth(method = "lm")

# additional breakdown for readability, RStudio auto-indents
ggplot(
  data = schools_data, 
  mapping = aes(
    x = Limited.English.Proficiency, 
    y = Economically.Disadvantaged
    )
  ) +
  geom_point() +
  geom_smooth(
    method = "lm"
    )
