library(tidyverse)
library(magrittr)

# Datasets from The Analysis of Biological Data by Whitlock and Schluter
# https://whitlockschluter.zoology.ubc.ca/data

hemoglobin_frame <- read.csv(file="https://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter02/chap02e3cHumanHemoglobinElevation.csv")
hemoglobin_frame$population <- as.factor(hemoglobin_frame$population)
usa_hemoglobin <- filter(hemoglobin_frame, population == "USA")

# ---------------
# Visualizing distributions
# ---------------

# Histograms are a variation on bar plots that understand "binning"

# Bins are used to assign the data into size categories
ggplot(usa_hemoglobin, aes(hemoglobin)) + # can just list dataset rather than "data = dataset"
  geom_histogram(binwidth = 0.1)

ggplot(usa_hemoglobin, aes(hemoglobin)) + 
  geom_histogram(bins = 50) # 30 bins is the default

ggplot(usa_hemoglobin, aes(hemoglobin)) + 
  geom_histogram(binwidth = 0.5)

ggplot(usa_hemoglobin, aes(hemoglobin)) + 
  geom_histogram(binwidth = 1)

# Can use color aesthetic to plot multiple distributions
ggplot(hemoglobin_frame, aes(hemoglobin)) + 
  geom_histogram(aes(color = population), fill = "NA", binwidth = 0.5) # NA makes the bars transparent

# Density plot is better when there are plenty of data and the curve is smooth
# plot a single level (US)
ggplot(usa_hemoglobin, aes(hemoglobin)) +
  geom_density()

# plot multiple levels of the factor
ggplot(hemoglobin_frame, aes(hemoglobin)) +
  geom_density(alpha = 0.2, aes(fill = population, color = population)) # use alpha to control transparency

# Normal quantile (Q-Q) plot is probably a better way to visualize differences in distributions
ggplot(hemoglobin_frame, aes(sample = hemoglobin)) + 
  geom_qq(aes(color = population)) +
  stat_qq_line(aes(color = population))

# Variations on box plots
ggplot(hemoglobin_frame, aes(population, hemoglobin)) + 
  geom_boxplot()

ggplot(hemoglobin_frame, aes(population, hemoglobin)) + 
  geom_boxplot(aes(color = population))

ggplot(hemoglobin_frame, aes(population, hemoglobin)) + 
  geom_violin()

# Dot plot not so great for this many points
ggplot(hemoglobin_frame, aes(x = population, y = hemoglobin)) + 
  geom_dotplot(binaxis = "y", stackdir = "center", dotsize = .5, binwidth = .25, aes(color = population, fill = population))

# ---------------
# Preparing some data to play with
# ---------------

erg_frame <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
erg_frame$color <- as.factor(erg_frame$color) # convert from character strings to factor (categories)

# Calculate the mean for each color
erg_mean_frame <- erg_frame %>% 
  group_by(color) %>% 
  summarize(mean_response = mean(response)) 

# ---------------
# Understanding "shortcut" geoms and the stat argument
# ---------------

# Most general graph type
ggplot(erg_mean_frame, aes(x=color, y=mean_response)) +
  layer(
    mapping = NULL, 
    data = NULL,
    geom = "bar", 
    stat = "identity",
    position = "identity"
  )

# geom_bar defaults the layer to "bar" geom and all other arguments except stat
ggplot(erg_mean_frame, aes(x=color, y=mean_response)) +
  geom_bar(
    stat="identity"
  ) 

# geom_col defaults the stat argument in geom_bar to "identity"
ggplot(erg_mean_frame, aes(x=color, y=mean_response)) +
  geom_col(
  )

# ---------------
# Displaying experimental differences
# ---------------

# Approach #1: Use separately-created stats to create a column plot using the individual mean values
ggplot(erg_mean_frame, aes(x = color, y = mean_response)) +
  geom_col()

# Approach #2: Calculate the stats on the fly from the raw (un-summarized) data
# as the plot is created using "stat" argument
ggplot(erg_frame, aes(x = color, y = response)) +
  geom_bar(stat = "summary", fun = "mean") # stat = "summary" overrides the default counting method

# Use a different summary function.
ggplot(erg_frame, aes(x = color, y = response)) +
  geom_bar(stat = "summary", fun = "median")

# Illustration of "count" stat
ggplot(erg_frame, aes(x = color)) +
  geom_bar(stat = "count")

ggplot(erg_frame, aes(x = color)) +
  geom_bar()

# Adding error bars to a bar plot
# In this case, we are using standard error of the mean (SEM)
# NOTE: SEM is a measure of the uncertainty of the mean, NOT the variability of the data as in std. dev.

# Create a function to calculate the SEM
sem <- function(x){
  sd(x)/sqrt(length(x))
}

erg_sem_frame <- erg_frame %>% 
  group_by(color) %>% 
  summarize(sem_response = sem(response)) 

# put means and SE into same data frame
graphing_data <- data.frame(mean = erg_mean_frame$mean_response, SE = erg_sem_frame$sem_response, color = erg_mean_frame$color)

# identity stat leaves the data the same. Normally geom_bar uses "count" as the stat
ggplot(graphing_data, aes(x=color, y=mean)) +
  geom_bar(stat="identity", aes(fill = color)) + # same as geom_col(aes(fill = color))
  geom_errorbar(aes(ymin=mean-SE, ymax=mean+SE),
                width=.2) +
  scale_fill_manual(values=c("blue", "green", "red")) +
  labs(
    x = "color of incident light",
    y = "electroretinogram response (mV)",
    title = "Sensitivity of cockroach eyes to varying colors (error bars: SEM)"
  ) +
  theme(legend.position = "none")

# ---------------
# Statistically calculated line geoms
# ---------------

# Although not explicitly given as a "stat" argument, the geom_smooth is performing a stat
# function by summarizing a set of data using a statistical method.

# Data from https://whitlockschluter.zoology.ubc.ca/data/chapter17
lion_noses <- read.csv(file="https://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter17/chap17e1LionNoses.csv")

# geom_smooth defaults to the "loess" stat for curve fitting if < 1000 points
ggplot(lion_noses, mapping = aes(x = proportionBlack, y = ageInYears)) + 
  geom_point() +
  geom_smooth() +
  labs(y="age (years)", x = "proportion black")

# Suppress the standard error range around the curve
ggplot(lion_noses, mapping = aes(x = proportionBlack, y = ageInYears)) + 
  geom_point() +
  geom_smooth(se = FALSE) +
  labs(y="age (years)", x = "proportion black")

# Linear model stat produces best fit line (i.e. defaults to y~x)
ggplot(lion_noses, mapping = aes(x = proportionBlack, y = ageInYears)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  labs(y="age (years)", x = "proportion black")

# Display line without SE range
ggplot(lion_noses, mapping = aes(x = proportionBlack, y = ageInYears)) + 
  geom_point() +
  geom_smooth(method = "lm", se = FALSE) +
  labs(y="age (years)", x = "proportion black")

# Use second-order polynomial (quadratic) fit in linear model instead of line
# I did not find an obvious list explaining the possible range of formulas that can be used.
# But Googling/Stack Overflow will probably allow you to find the function you want.
ggplot(lion_noses, mapping = aes(x = proportionBlack, y = ageInYears)) + 
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2)) +
  labs(y="age (years)", x = "proportion black")

# Another example: fit an exponential curve through the data
ggplot(lion_noses, mapping = aes(x = proportionBlack, y = ageInYears)) + 
  geom_point() +
  geom_smooth(method = "lm", formula = y ~ exp(x)) +
  labs(y="age (years)", x = "proportion black")

