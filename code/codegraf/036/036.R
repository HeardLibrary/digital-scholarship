# Run once only
install.packages("maps")

# Run every time
library(tidyverse)
library(magrittr)

# Datasets from The Analysis of Biological Data by Whitlock and Schluter
# https://whitlockschluter.zoology.ubc.ca/data

# ---------------
# Controlling axis scales
# ---------------

# Reversing axes

lion_noses <- read.csv("https://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter17/chap17e1LionNoses.csv")

ggplot(data = lion_noses, aes(x = proportionBlack, y = ageInYears)) +
  geom_point() +
  geom_smooth(method = "lm")

# scale functions can be used to control breakpoints on axes
ggplot(data = lion_noses, aes(x = proportionBlack, y = ageInYears)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_continuous(breaks = scales::breaks_extended(n = 10)) + # set number of breaks, n is a suggestion
  scale_y_continuous(breaks = scales::breaks_width(2)) # set width of breaks
  
ggplot(data = lion_noses, aes(x = proportionBlack, y = ageInYears)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_reverse()

# Changing to a log scale

fish_species <- read_csv("https://whitlockschluter.zoology.ubc.ca/wp-content/data/chapter17/chap17f5_3DesertPoolFish.csv")

# Notice that the fit to the data is terrible when the scale is linear
ggplot(data = fish_species, aes(x = poolArea, y = nFishSpecies)) +
  geom_point() +
  geom_smooth(method = "lm")

# Switch to base 10 log scale on X axis
# Notice that the linear fit is done on the log-transformed data, not the raw data
ggplot(data = fish_species, aes(x = poolArea, y = nFishSpecies)) +
  geom_point() +
  geom_smooth(method = "lm") +
  scale_x_log10()

# ------------------
# Polar coordinates
# ------------------

# Recreate data for energy use for top 5 states
# Wrangle data to remove unwanted rows and columns, and sort descending
co2_wide <- read.xlsx(xlsxFile = "https://github.com/HeardLibrary/digital-scholarship/raw/master/data/codegraf/co2_state_2016_sector.xlsx") %>%
  head(-1) # remove the last "total" row
co2 <- co2_wide[order(co2_wide$Total, decreasing = TRUE, na.last = TRUE), ] %>% # sort with state with biggest total first
  head(5) %>% # use the five biggest CO2 outputting states
  pivot_longer(cols = c("Commercial", "Electric.Power", "Residential", "Industrial", "Transportation"), names_to = "sector", values_to = "metric_tons")
# Convert the two categorical columns to factors
co2$sector <- as.factor(co2$sector)
co2$State <- as.factor(co2$State)

# Create bar plots for each state in a separate facet
ggplot(data = co2, aes(x= "", y=metric_tons, fill = sector)) + # The x variable is a dummy variable
  geom_bar(stat = "identity", width = 1, color = "black", position = "fill") + # "fill" makes the bars fractional
  facet_wrap(~State)

ggplot(data = co2, aes(x= "", y=metric_tons, fill = sector)) +
  geom_bar(stat = "identity", width = 1, color = "black", position = "fill") +
  coord_polar(theta = "y") + # use the y variable for the polar coordinate
  facet_wrap(~State) +
  theme_void() # add this to get rid of distracting background and labels

# ------------------
# Maps
# ------------------

# Load built-in county map data for Tennessee
tennessee_counties <- map_data("county", "tennessee")
head(tennessee_counties)

# Draw polygons using the lat/lon points
ggplot() +
  geom_polygon(data = tennessee_counties, mapping = aes(long, lat, group = group), fill = "white", colour = "grey50") + 
  coord_quickmap() # causes x and y scales to be the same


davidson <- filter(tennessee_counties, subregion == "davidson")

# Load schools data for only elementary, middle, and high schools
schools_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv") %>%
  filter(`School Level` == "Middle School" | `School Level` == "High School" | `School Level` == "Elementary School" )

# Create a plot with the county outline and school locations
ggplot() +
  geom_polygon(data = davidson, mapping = aes(long, lat, group = group), fill = "white", colour = "grey50") + 
  geom_point(data = schools_data, mapping = aes(x = Longitude, y = Latitude, colour = `School Level`)) + 
  coord_quickmap()

# Convert absolute numbers in several columns to relative (fractions) and remove missing data
rel_data <- mutate(schools_data, total = Male + Female) %>%
  mutate(limited_proficiency = `Limited English Proficiency`/total * 100, economically_disadvantaged = `Economically Disadvantaged`/total * 100, percent_white = `White`/total * 100) %>%
  filter(!is.na(limited_proficiency)) %>%
  filter(!is.na(economically_disadvantaged))

# Create a plot showing economically disadvantaged students
ggplot() +
  geom_polygon(data = davidson, mapping = aes(long, lat, group = group), fill = "white", colour = "grey50") + 
  geom_point(data = rel_data, mapping = aes(x = Longitude, y = Latitude, colour = economically_disadvantaged)) + 
  scale_color_gradientn(colours=rainbow(4), trans = 'reverse') +
  coord_quickmap()

# Create a plot showing limited English proficiency
ggplot() +
  geom_polygon(data = davidson, mapping = aes(long, lat, group = group), fill = "white", colour = "grey50") + 
  geom_point(data = rel_data, mapping = aes(x = Longitude, y = Latitude, colour = limited_proficiency)) + 
  scale_color_gradientn(colours=rainbow(4), trans = 'reverse') +
  coord_quickmap()

# More commonly, map data are encoded using the "simple features" standard from the Open Geospatial Consortium
# See https://ggplot2-book.org/maps.html#sf for details

# ---------------
# Surface plots to visualize a third continuous variable
# ---------------

# 3D plotting not really supported by ggplot but by other packages not supported by ggplot, 
# such as plot3D

# Data wrangling section (do not worry about this)

# ---------------
# Data collected from YouTube API and pushed to GitHub by: 
# https://github.com/HeardLibrary/dashboard/blob/master/disc/youtube/youtube_collect_data.ipynb

# Data from YouTube by video (each column)
views <- read_csv("https://github.com/HeardLibrary/dashboard/raw/master/disc/youtube/total_views.csv")
metadata <- read_csv("https://github.com/HeardLibrary/dashboard/raw/master/disc/youtube/video-metadata.csv")

video_columns <- metadata$id # get list of columns to use for the pivot
get_video_number <- metadata$index
names(get_video_number) <- metadata$id

long_views <- pivot_longer(views, 
                           cols = all_of(video_columns),
                           names_to = "video_id", 
                           values_to = "video_views")

new_column <- unname(get_video_number[long_views$video_id])
long_views <- mutate(long_views, video_index = new_column)
# ---------------

# Generating the surface plot

filtered <- long_views %>%
  filter(date >= "2021-02-03") %>%
  filter(video_index < 197)

# Could use xlim() and ylim() to impose limits on the plot rather than the data

# Generate a contour plot
ggplot(data = filtered, aes(x = date, y = video_index)) + 
  geom_contour(aes(z = video_views)) 

# Generate a tile plot where color represents height in the third dimension
ggplot(data = filtered, aes(x = date, y = video_index)) + 
  geom_tile(aes(fill = video_views))

# Change to a log scale
ggplot(data = filtered, aes(x = date, y = video_index)) + 
  geom_tile(aes(fill = video_views)) +
  scale_fill_continuous(trans = "log")

# Use a better color palette
ggplot(data = filtered, aes(x = date, y = video_index)) + 
  geom_tile(aes(fill = video_views)) +
  scale_fill_gradientn(colours=rainbow(4), trans = "log") 

# Increase number of colors in rainbow to get more resolution
ggplot(data = filtered, aes(x = date, y = video_index)) + 
  geom_tile(aes(fill = video_views)) +
  scale_fill_gradientn(colours=rainbow(6), trans = "log") 

# Improve month display on scale
ggplot(data = filtered, aes(x = date, y = video_index)) + 
  geom_tile(aes(fill = video_views)) +
  scale_fill_gradientn(colours=rainbow(6), trans = "log") +
  scale_x_date(date_breaks = "1 months", date_labels = "%B")

# Add lines showing lesson breaks and labels
# Text labeling: https://ggplot2-book.org/annotations.html#text-labels
date_vector = as.Date(c("2021-01-01", "2021-01-01", "2021-01-01", "2021-01-01", "2021-01-01"))
video_index = c(5, 34, 87, 134, 172)
text_vector = c("Introduction", "Beginner Python", "Python structures", "Beginner R", "GitHub")
text_labels <- data.frame(date = date_vector, video_index, text = text_vector)

ggplot(data = filtered, aes(x = date, y = video_index)) + 
  geom_tile(aes(fill = video_views)) +
  scale_fill_gradientn(colours=rainbow(6), trans = "log") +
  geom_hline(yintercept=c(29, 82, 129, 167), color = "black") +
  scale_x_date(date_breaks = "1 months", date_labels = "%B") +
  geom_text(data = text_labels, aes(label = text), hjust = "inward")

