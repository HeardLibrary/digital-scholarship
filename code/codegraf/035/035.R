# !!! Run once if you haven't already installed:
install.packages("patchwork") # library for arranging plots

# Run every time
library(tidyverse)
library(magrittr)

# ---------------
# Side-by-side plots using patchwork
# ---------------

# patchwork is another alternative library, see
# https://ggplot2-book.org/arranging-plots.html
library(patchwork)

# Dataset from The Analysis of Biological Data by Whitlock and Schluter
# https://whitlockschluter.zoology.ubc.ca/data

hemoglobin_frame <- read.csv(file="https://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter02/chap02e3cHumanHemoglobinElevation.csv")
hemoglobin_frame$population <- as.factor(hemoglobin_frame$population)
usa_hemoglobin <- filter(hemoglobin_frame, population == "USA")

# Assign each subplot to a named object

# Overlapping distribution plot
plot1 <- ggplot(hemoglobin_frame, aes(hemoglobin)) +
  geom_density(alpha = 0.2, aes(fill = population, color = population)) + # use alpha to control transparency
  theme(legend.position = c(0.8, 0.8))

# Normal quantile (Q-Q) plot
plot2 <- ggplot(hemoglobin_frame, aes(sample = hemoglobin)) + 
  geom_qq(aes(color = population)) +
  stat_qq_line(aes(color = population)) +
  theme(legend.position = c(0.8, 0.2))

# Use patchwork capability to arrange plots side-by-side
# See https://ggplot2-book.org/arranging-plots.html#laying-out-plots-side-by-side
plot1 + plot2
plot1 / plot2

# Apply labels for parts of figures
combined_plot <- plot1 + plot2 + plot_annotation(tag_levels = c("A"))
combined_plot # Output is another ggplot object, which can be saved and printed

# Overlaying plots using inset_element()
# https://ggplot2-book.org/arranging-plots.html#arranging-plots-on-top-of-each-other
qq_no_legend <- ggplot(hemoglobin_frame, aes(sample = hemoglobin)) + 
  geom_qq(aes(color = population)) +
  stat_qq_line(aes(color = population)) +
  theme(legend.position = "none")

ggplot(hemoglobin_frame, aes(hemoglobin)) +
  geom_density(alpha = 0.2, aes(fill = population, color = population)) + # use alpha to control transparency
  theme(legend.position = "bottom") +
  inset_element(qq_no_legend, left = 0.5, bottom = 0.6, right = 0.95, top = 0.95)

# ---------------
# Approaches for collapsing variables and reducing number of levels
# ---------------

# 2013 Data from Bureau of Transportation Statistics, Airline On-Time Performance Data
# https://www.transtats.bts.gov/

airline <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/r/flight_data_subset.csv")
airline$`Carrier Name` <- as.factor(airline$`Carrier Name`)

# See https://www.stat.berkeley.edu/~s133/dates.html for information about converting various date formats
airline$Date <- as.Date(airline$Date, format='%m/%d/%Y')

# Time series and delay are continuous, airline and airport are discrete

# Limit the dataset to one kind of delay and only to O'Hare airport
ord <- airline %>%
  filter(`Airport Name` == "Chicago O'Hare International") %>%
  filter(`Ontime Category` == "Delayed by Late Aircraft")

# longitudinal plot, a.k.a. spaghetti plot (follows trajectory over time)
# See https://ggplot2-book.org/collective-geoms.html#multiple-groups-one-aesthetic
# Use group() aesthetic
ggplot(ord, aes(x = Date, y = `Minutes of Delay per Flight`, group = `Carrier Name`)) + 
  geom_line(na.rm = TRUE) +
  geom_point()


# Graph only one airport (drop out other dimensions, i.e. categorical variables)
# create an array of shape numbers
shapes <- 0:19

ggplot(ord, aes(x = Date, y = `Minutes of Delay per Flight`, color = `Carrier Name`)) + 
  geom_line(na.rm = TRUE) +
  geom_point(aes(shape = `Carrier Name`), size = 3) +
  scale_shape_manual(values=shapes)

# ---------------
# Collapse one of the dimensions using summarise:
# ---------------

# Graph all of the flights at all airports (eliminate airport as a factor), sorted by airline

all_airports_total_flights <- airline %>% 
  filter(`Ontime Category` == "Delayed by Late Aircraft") %>%
  group_by(`Carrier Name`, `Date`) %>% # group_by() is from the dplyr package
  summarise(total_flights = sum(`Number of Flights`))  # summarise() also from dplyr
head(all_airports_total_flights)

all_airports_total_delays <- airline %>% 
  filter(`Ontime Category` == "Delayed by Late Aircraft") %>%
  group_by(`Carrier Name`, `Date`) %>% 
  summarise(total_delay = sum(`Minutes of Delay`))
head(all_airports_total_delays)

mean_delay <- data.frame(carrier = all_airports_total_delays$`Carrier Name`, date = all_airports_total_delays$`Date`, mean_delay = all_airports_total_delays$total_delay/all_airports_total_flights$total_flights)
head(mean_delay)

# Recreate the same kind of plot, but for all airports
ggplot(mean_delay, aes(x = date, y = mean_delay, color = carrier)) + 
  geom_line() +
  geom_point(aes(shape = carrier), size = 3) +
  scale_shape_manual(values=shapes)

# Move grouping variable color into individual geoms so it isn't mapped globally
# grouping (i.e. color) only applied to line and point, so smooth applied to all data

ggplot(mean_delay, aes(x = date, y = mean_delay)) + 
  geom_line(aes(color = carrier)) +
  geom_point(aes(shape = carrier, color = carrier), size = 3) +
  scale_shape_manual(values=shapes)+ 
  geom_smooth(size = 2, se = FALSE)


# Comparing the two plots
# Assign to variables

ord_plot <- ggplot(ord, aes(x = Date, y = `Minutes of Delay per Flight`, color = `Carrier Name`)) + 
  geom_line(na.rm = TRUE) +
  geom_point(aes(shape = `Carrier Name`), size = 3) +
  scale_shape_manual(values=shapes)

all_plot <- ggplot(mean_delay, aes(x = date, y = mean_delay)) + 
  geom_line(aes(color = carrier)) +
  geom_point(aes(shape = carrier, color = carrier), size = 3) +
  scale_shape_manual(values=shapes)+ 
  geom_smooth(size = 2, se = FALSE)

ord_plot / all_plot

# ---------------
# Reducing the number of levels of a factor (categorical variable)
# ---------------

# Interesting airlines are: United (consistently bad), Southwest (consistently good),
# Hawaiian (inconsistently good), Virgin (inconsistently bad)

small_mean_delay <- mean_delay %>%
  filter(carrier == "United" | carrier == "Virgin" | carrier == "Hawaiian" | carrier == "Southwest")

ggplot(small_mean_delay, aes(x = date, y = mean_delay, color = carrier)) + 
  geom_line()
  
# ---------------
# Explore four airlines: (apply statistic to one variable; collective geom)
# ---------------

# collective geom displays multiple observations with one geometric object.
# Uses the group() aesthetic, often replaced by color() or some other aesthetic that causes grouping.

# The boxplot displays the distribution by airport

# Apply airline filter to original dataset
head(airline)

four_airline <- airline %>%
  filter(`Carrier Name` == "United" | `Carrier Name` == "Virgin" | `Carrier Name` == "Hawaiian" | `Carrier Name` == "Southwest")

# Reorder the airlines as consistently: good, bad; inconsistently: good, bad
four_airline$`Carrier Name` <- factor(four_airline$`Carrier Name`, c("Southwest", "United", "Hawaiian", "Virgin"))

# Need to convert date to factor in order to group the box plots
ggplot(four_airline, aes(x = as.factor(Date), y = `Minutes of Delay per Flight`, color = `Carrier Name`)) + 
  geom_boxplot() +
  guides(x = guide_axis(angle = 90))

# Stretch graph to exclude outliers by applying plot limits
ggplot(four_airline, aes(x = as.factor(Date), y = `Minutes of Delay per Flight`, color = `Carrier Name`)) + 
  geom_boxplot() +
  guides(x = guide_axis(angle = 90)) +
  coord_cartesian(ylim = c(0, 225))
# Not so useful to have them crammed on the same axes

# ---------------
# Faceting subplots
# ---------------

# To facet, I remove the grouping argument (color = `Carrier Name`) from the global aesthetic

base <- ggplot(four_airline, aes(x = as.factor(Date), y = `Minutes of Delay per Flight`)) + 
  geom_boxplot() + 
  xlab(NULL) + 
  ylab(NULL) +
  guides(x = guide_axis(angle = 90))

# Now use the `Carrier Name` variable to divide the plots into facets based on that variable
base + facet_wrap(~`Carrier Name`, nrow = 2)

# The presence of two outliers in the Hawaiian plot compresses all of the plots too much.
# Reduce the Y plot limits to stretch out.

base <- ggplot(four_airline, aes(x = as.factor(Date), y = `Minutes of Delay per Flight`)) + 
  geom_boxplot() + 
  xlab(NULL) + 
  ylab(NULL) +
  guides(x = guide_axis(angle = 90)) +
  coord_cartesian(ylim = c(0, 225))

# The first argument is an object that is categorical (a variable or function)
# facet_wrap divides the subplots into the specified number of rows.
base + facet_wrap(~`Carrier Name`, nrow = 2)

# facet_grid is used to vary the plots in two dimensions by two variables.

