# !!! Run once if you haven't already installed:
install.packages("svglite") # adds SVG support to ggtext
install.packages("openxlsx")
# install.packages("ggtext")

# For detailed information on color scales and legends, see
# https://ggplot2-book.org/scale-colour.html

# Run every time
library(tidyverse)
library(magrittr)
library(openxlsx)

schools_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")

# Convert absolute numbers in several columns to relative (fractions) and remove missing data
rel_data <- mutate(schools_data, total = Male + Female) %>%
  mutate(limited_proficiency = `Limited English Proficiency`/total * 100, economically_disadvantaged = `Economically Disadvantaged`/total * 100, percent_white = `White`/total * 100) %>%
  filter(!is.na(limited_proficiency)) %>%
  filter(!is.na(economically_disadvantaged))

# Setting a single color for a geom by name. "color" or "colour" allowed, can't set globally
ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(color = "red") +
  geom_smooth(method = "lm", color = "black")

# Setting color by hex code. See for example: https://image-color-picker.com/hex-code-picker
ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(color = "#349c35") +
  geom_smooth(method = "lm", color = "#9C349B")

# Filter the data for only three school levels
three_level <-  rel_data %>%
  filter(`School Level` == "Middle School" | `School Level` == "High School" | `School Level` == "Elementary School" )

# Setting the color based on a factor, small number of categories, auto colors
ggplot(data = three_level, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = as.factor(`School Level`))) + # not required to convert to factor if character
  geom_smooth(method = "lm", color = "black")

# many categories, auto colors
ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = as.factor(`School Level`))) + # not required to convert to factor if character
  geom_smooth(method = "lm", color = "black")

# setting an accessible palatte for color vision deficiency from http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
cbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7", "#999999")
# To use for fills, add
# scale_fill_manual(values=cbPalette)
# To use for line and point colors, add
# scale_colour_manual(values=cbPalette)

# See http://www.sthda.com/english/wiki/colors-in-r for more on pre-defined color palettes.

ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = as.factor(`School Level`))) + # not required to convert to factor if character
  geom_smooth(method = "lm", color = "black") +
  scale_colour_manual(values=cbPalette)

ggplot(data = three_level, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = as.factor(`School Level`))) + # not required to convert to factor if character
  geom_smooth(method = "lm", color = "black") +
  scale_colour_manual(values=cbPalette)

# Setting color based on magnitude of a continuous variable, auto colors
ggplot(data = three_level, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = percent_white))

# Setting color based on magnitude, specify rainbow colors as a gradient
ggplot(data = three_level, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = percent_white)) +
  scale_colour_gradientn(colours=rainbow(4)) # the number controls the number of colors included

# ------------
# Controlling point markers
# ------------

# Code to display shapes from http://sape.inf.usi.ch/quick-reference/ggplot2/shape
# Shapes 32 to 127 correspond to ASCII codes for characters.
d=data.frame(p=c(0:25,32:127))
ggplot() +
  scale_y_continuous(name="") +
  scale_x_continuous(name="") +
  scale_shape_identity() +
  geom_point(data=d, mapping=aes(x=p%%16, y=p%/%16, shape=p), size=5, fill="red") +
  geom_text(data=d, mapping=aes(x=p%%16, y=p%/%16+0.25, label=p), size=3)

# Size goes up from 1

# Shapes 21 to 25 are fillable with a different color
ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(shape = 24, size = 5, color = "blue", fill = "yellow") +
  geom_smooth(method = "lm", color = "black")

# Shapes 15 through 20 are solid and fill value has no effect (and can be omitted)
ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(shape = 17, size = 5, color = "blue", fill = "yellow") +
  geom_smooth(method = "lm", color = "black")

# Shapes 0 through 14 are outlines and fill value has no effect (and can be omitted)
ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(shape = 2, size = 5, color = "blue", fill = "yellow") +
  geom_smooth(method = "lm", color = "black")

# Controlling marker size by continuous variable
ggplot(data = rel_data, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(size = percent_white), shape = 2, color = "blue") +
  geom_smooth(method = "lm", color = "black")

# Controlling marker shape by a categorical variable (factor)
ggplot(data = three_level, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(shape = `School Level`), size = 3, color = "blue") +
  geom_smooth(method = "lm", color = "black")

# ------------
# filled plots
# ------------

# Single color control is similar to line and dot plots, with an added fill argument
# The color argument determines the outline color
ggplot(data = schools_data) +
  geom_histogram(mapping = aes(x = Female), binwidth = 100, color = "red", fill = "gray")

ggplot(data = schools_data) +
  geom_histogram(mapping = aes(x = Female), binwidth = 100, color = "#349c35", fill = "#9C349B")

# Variable color through aesthetic
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = `School Level`, fill = `School Level`), color = "red")

# Controlling luminance and chroma (saturation), aesthetic (variable) color only

# luminance controls the amount of black added to the color
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = `School Level`, fill = `School Level`), color = "red") +
  scale_fill_hue(l = 50) # vary luminance from 0 to 100

# chroma corresponds roughly to color intensity
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = `School Level`, fill = `School Level`), color = "red") +
  scale_fill_hue(c = 400) # vary chroma from 0 to about 400

ggplot(data = three_level) +
  geom_bar(mapping = aes(x = `School Level`, fill = `School Level`), color = "red") +
  scale_fill_hue(c = 80, l = 20)

# ------------
# Including a second categorical variable in a filled plot
# ------------

# First type of plot: bar plot (geom_bar)
# Y value is summative (defaults to counts)

# Number and type of school by Zip code
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = as.factor(`Zip Code`), fill = `School Level`))

# position = "fill" makes all bars the same size and shows fraction
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = as.factor(`Zip Code`), fill = `School Level`), position = "fill")

# position = "dodge" places bars for an X side-by-side
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = as.factor(`Zip Code`), fill = `School Level`), position = "dodge")

# Second type of plot is a column plot (geom_col)
# Y value is continuous data

library(openxlsx) # Note: the readxl package that is a part of Tidyverse will not read from URLs. This package does.

# Data from https://www.epa.gov/statelocalenergy/state-co2-emissions-fossil-fuel-combustion

# Wrangle data to remove unwanted rows and columns, and sort descending
co2_wide <- read.xlsx(xlsxFile = "https://github.com/HeardLibrary/digital-scholarship/raw/master/data/codegraf/co2_state_2016_sector.xlsx") %>%
  head(-1) # remove the last "total" row
co2 <- co2_wide[order(co2_wide$Total, decreasing = TRUE, na.last = TRUE), ] %>% # sort with state with biggest total first
  head(5) %>% # use the five biggest CO2 outputting states
  pivot_longer(cols = c("Commercial", "Electric.Power", "Residential", "Industrial", "Transportation"), names_to = "sector", values_to = "metric_tons")
# Convert the two categorical columns to factors
co2$sector <- as.factor(co2$sector)
co2$State <- as.factor(co2$State)

# Bars can be organized the same way as in a bar plot
# stacked
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector))

# relative
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "fill")

# side-by-side
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge")

# improve visibility using color-blind palette and outline bars in black
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_manual(values=cbPalette)

# Change the order of the sectors manually and re-draw
co2$sector <- factor(co2$sector, c("Transportation", "Electric.Power", "Industrial", "Residential", "Commercial"))
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_manual(values=cbPalette)

# Change the order of the states by sorting based on the mean of the total CO2 value. Minus sign makes the order descending.
co2$State <- reorder(co2$State, -co2$Total, mean)
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_manual(values=cbPalette)

# To avoid color you can use grayscale. Crosshatch and other patterns aren't available natively.
# For patterns, see https://coolbutuseless.github.io/package/ggpattern/articles/geom-gallery-geometry.html#b-w-example
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_grey()

# ---------------
# Controlling descriptive elements
# --------------

# Legends. Control position using theme(legend.position). Options are "left", "right", "top", "bottom", and "none"
# default position is right
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = "left")

# You can also position the legend within the plot using a vector containing the X, Y positions ranging from 0 to 1
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_manual(values=cbPalette) +
  theme(legend.position = c(.8, .8))

# For more details on annotations, see
# https://ggplot2-book.org/annotations.html

# Axes labels. Default to the column names, but can be specified using labs
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_manual(values=cbPalette) +
  labs(
    x = "states with the largest total",
    y = "CO2 released (million metric tons)"
    ) +
  theme(legend.position = c(.8, .8))

# Title and subtitle
# To enable subscript and superscript, use the ggtext package to enable Markdown formatting.
ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_manual(values=cbPalette) +
  labs(
    x = "states with the largest total",
    y = "CO<sub>2</sub> released (in 10^6 metric tons)",
    title = "Fig. 3. Annual fossil fuel combustion in 2018 (EPA 430-R-18-003)"
    ) +
  theme(legend.position = c(.8, .8), axis.title.y = ggtext::element_markdown())

# Fixing a bad legend title

# Earlier we made this plot:
ggplot(data = three_level, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = as.factor(`School Level`))) + # not required to convert to factor if character
  geom_smooth(method = "lm", color = "black")

# We can fix the bad axis and legend title using labs(). We used color as an aesthetic, so use it to set the legend label
ggplot(data = three_level, mapping = aes(x = limited_proficiency, y = economically_disadvantaged)) +
  geom_point(aes(color = as.factor(`School Level`))) + # not required to convert to factor if character
  geom_smooth(method = "lm", color = "black") +
  labs(
    x = "percent limited English proficiency",
    y = "percent economically disadvantaged",
    color = "School level"
  )

# Fixing bad axes scales. See
# https://ggplot2-book.org/scale-position.html for details

# Earlier we made this plot, which ended up with overlapping Zip code labels:
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = as.factor(`Zip Code`), fill = `School Level`))

# We can rotate the labels by 90 degrees to fix this.
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = as.factor(`Zip Code`), fill = `School Level`)) +
  guides(x = guide_axis(angle = 90))

# We could improve the presentation by ordering the Zip code as a factor
three_level$`Zip Code` <- as.factor(three_level$`Zip Code`) # turn it from character to factor
three_level$`Zip Code` <- reorder(three_level$`Zip Code`, -three_level$total, sum) # order by total student population
ggplot(data = three_level) +
  geom_bar(mapping = aes(x = `Zip Code`, fill = `School Level`)) +
  guides(x = guide_axis(angle = 90)) +
  labs(
    y = "number of schools",
    title = "distribution of schools in Davidson County"
  )

# ---------------
# Exporting plots for publications or presentations
# ---------------

library(ggtext)

# A plot is an object, so it can be assigned to a variable
# In this case, the plot will not be displayed since it's being stored as a named object
grayscale_figure <- ggplot(data = co2) +
  geom_col(mapping = aes(x = State, y= metric_tons, fill = sector), position = "dodge", color = "black") +
  scale_fill_grey()

# Display the plot
grayscale_figure

# Find out your working directory so you'll know where the file is being saved
getwd()

# PNG will become "pixelated" when enlarged, SVG will not and is therefore preferred by publishers
ggsave("figure.png", plot=grayscale_figure, width = 20, height = 30, units = "cm")
# Saving as an SVG requires the svglite package
ggsave("figure.svg", plot=grayscale_figure, width = 20, height = 30, units = "cm")

