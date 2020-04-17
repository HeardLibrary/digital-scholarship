# This script is based on a presentation given by Kate Brady in 2019
# See https://github.com/kbrady/data_viz_working_group_r_talk 
# for the source material modified for this script.

# For more background on ggplot, see this chapter of R For Data Science (free online)
# https://r4ds.had.co.nz/data-visualisation.html
# It has a link to Hadley Wickham's seminal paper A Layered Grammar of Graphics, which describes the
# conceptual underpinnings of ggplot. It's an important read for anyone who is interested in data viz.

# The "Data Visualization Cheatsheet" at https://rstudio.com/resources/cheatsheets/ 
# is a highly recommended resource that summarizes all of the key aspects of ggplot.
# Unvortunately,tt's really somewhat poster-sized, so it might be hard to see 
# on a small screen.

# ----------------------
# Preliminaries
# ----------------------

# load libraries
# you may need to install these libraries. Some are included in tidyverse
library("ggplot2") # visualization library
library("png") # library to read png images
library("plyr") # 
library("repr") # to set plot dimensions
options(repr.plot.width=10, repr.plot.height=6)


# read in data downloaded from https://data.nashville.gov/browse?category=Education
schools <- read.csv(file="https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv")

# have a column with the total number of students in each school (as we did in the past)
schools$Total <- schools$Male + schools$Female

# Recall discussion in previous lesson about what should be factors.
# zip codes should be a categorical, not numerical
schools$Zip.Code <- as.factor(schools$Zip.Code)

# order school types in a way that makes sense
school_levels = c('Elementary School',
                  'Middle School',
                  'High School',
                  'Charter',
                  'Non-Traditional',
                  'Non-Traditional - Hybrid',
                  'Alternative Learning Center',
                  'Special Education',
                  'GATE Center',
                  'Adult'
)
# The levels attribute allows us to control the ordering of factors
schools$School.Level <- factor(schools$School.Level, levels = school_levels)

head(schools)

# ----------------------
# Setting up basic ggplot for count of school types
# ----------------------

# set the data
data <- schools #[schools$Total > 300, ] # alternative to limit to school types with more than 300 students
# set the geometry (sometimes we have to specify a statstic)
geometry <- geom_bar(stat="count") #, width=.1)
# choose the aesthetics
aesthetic <- aes(x=School.Level)

ggplot(data, aesthetic) #+
 #geometry +
 #geom_point(stat="count", size=5) + 
 #coord_flip()

ggplot(data, aesthetic) +
  geometry #+
#geom_point(stat="count", size=5) + 
#coord_flip()

ggplot(data, aesthetic) +
  geometry +
  geom_point(stat="count", size=5) #+ 
#coord_flip()

ggplot(data, aesthetic) +
  geometry +
  geom_point(stat="count", size=5) + 
  coord_flip()

# ----------------------
# ggplot for schools by size with type as color
# ----------------------

# use Nasvhille schools as data again, with option to reduce categories
data <- schools [schools$School.Level %in% c("High School", "Elementary School", "Middle School", "Charter"), ]

# this time put the total number of students in each school on the x axis
# use fill to indicate the type of school
aesthetic <- aes(x=Total, fill=School.Level)

# use the histogram geometry
geometry <- geom_histogram(binwidth=100)
# uncomment the line below to use dotplot 
# geometry <- geom_dotplot(aes(color=School.Level), binwidth=100, dotsize=.4, stackgroups=TRUE, binpositions="all")

# plot it
ggplot(data, aesthetic) + geometry

# ----------------------
# ggplot for schools by size and type (box and whisker)
# ----------------------

# use Nasvhille schools as data again
data <- schools [schools$School.Level %in% c("High School", "Elementary School", "Middle School", "Charter"), ]

# use the boxplot geometry
geometry <- geom_boxplot()

# put the total number of students in each school on the x axis and the school type on the y axis
aesthetic <- aes(x=School.Level, y=Total)

ggplot(data, aesthetic) + 
  geometry + 
  # geom_point(stat = "identity", alpha=.5) + # uncomment to show the values as points
  # geom_point(stat = "summary", fun.y = "mean", size=3, shape="square", color="blue") + # uncomment to show the mean as a blue square
  # geom_point(stat = "summary", fun.y = "median", shape="|", size=10, color="red") + # uncomment to show the median as a red line
  # swap the x and y axes
  coord_flip()

# ----------------------
# ggplot for schools by grade and size with school level as color (fancy calculations)
# ----------------------

# make a list of the columns that start with "Grade."
grade_names <- lapply(
  Filter(
    function(x) { startsWith(x, "Grade") },
    colnames(schools)), # go through each column
  function(x) { substring(x, nchar("Grade.")+1) })

# make a function that makes a (school, grade) row
getFrameForGrade <- function(grade_name) {
  key <- paste("Grade.", grade_name, sep="")
  grade_counts <- data.frame(schools[ , c("School.Level", "School.Name", key)])
  grade_counts$Grade <- grade_name
  names(grade_counts)[names(grade_counts) == key] <- "Students"
  return(grade_counts)
}

grade_info <- Reduce(rbind, lapply(grade_names, getFrameForGrade))

# make sure the grades are plotted in the correct order
grade_info$Grade <- factor(grade_info$Grade, levels = grade_names)

# head(schools)
head(grade_info)


# use the grade_info as the data
data <- grade_info #[complete.cases(grade_info), ]

# map grade to the x axis, the number of students to the y axis, use the fill color to indicate the school level
aesthetic <- aes(x=Grade, y=Students, fill=School.Level)

# use the bar chart geometry
geometry <- geom_bar(stat="sum", position = "stack")

# plot it
ggplot(data, aesthetic) + geometry + coord_flip()

# ----------------------
# ggplot putting data on a map
# ----------------------

# uncomment to load a map image and turn it into a geometry
map_imp <- readPNG('nashville_map.png')
map_plot <- annotation_raster(map_imp, ymin = min(schools$Latitude, na.rm=TRUE), ymax= max(schools$Latitude, na.rm=TRUE), xmin = min(schools$Longitude, na.rm=TRUE), xmax = max(schools$Longitude, na.rm=TRUE))

# use the high schools as the data
data <- schools[schools$School.Level %in% c("High School"), ]

# map latitude to the y axis and longitude to the x axis
aesthetic <- aes(y=Latitude, x=Longitude)

# make the plot
ggplot(data, aesthetic) + 
   map_plot + 
   coord_fixed() + 
   ggtitle("Where Nashville Goes to School") + # add a title
   geom_point(color="red", size=5)

# ----------------------
# ggplot putting data on a map with dots colored by fraction white
# ----------------------

# use all public schools as the data
data <- schools[schools$School.Level %in% c("Elementary School", "Middle School", "High School"), ]

# map latitude to the y axis and longitude to the x axis
# commented are some aesthetics to add
aesthetic <- aes(y=Latitude, x=Longitude, shape=School.Level, color=Hispanic.Latino/Total, size=Total)

# races
# White
# Black.or.African.American
# Hispanic.Latino
# Asian
# Native.Hawaiian.or.Other.Pacific.Islander
# American.Indian.or.Alaska.Native

ggplot(data, aesthetic) + 
  map_plot + 
  coord_fixed() +
  scale_colour_gradient(low = "blue", high = "red") + # uncomment to change the color gradient
  ggtitle("How segregated is Nashville?") + 
  geom_point()
  
# ----------------------
# ggplot complex data wrangling to plot race by school
# ----------------------

race_names <- c(
  "White",
  "Black.or.African.American",
  "Hispanic.Latino",
  "Asian",
  "Native.Hawaiian.or.Other.Pacific.Islander",
  "American.Indian.or.Alaska.Native"
)

getFrameForRace <- function(race_name) {
  race_counts <- data.frame(schools[ , c("School.Level", "School.Name", "School.ID", race_name, "Total")])
  race_counts$Race <- race_name
  race_counts$Fraction <- race_counts[ , race_name]/race_counts$Total
  names(race_counts)[names(race_counts) == race_name] <- "Students"
  return(race_counts)
}

race_info <- Reduce(rbind, lapply(race_names, getFrameForRace))

# make sure the grades are plotted in the correct order
race_info$Race <- factor(race_info$Race, levels = race_names)

# order by fraction of <race_to_order_by> students
race_to_order_by <- "White"
school_names <- schools[,c("School.Name", race_to_order_by, "Total")]
school_names$Fraction <- school_names[,race_to_order_by]/school_names$Total
school_names <- school_names[order(-school_names[, "Fraction"]), ]
school_names <- school_names$School.Name

race_info$School.Name <- factor(race_info$School.Name, levels = school_names)

# head(schools)
head(race_info)


data <- race_info[race_info$School.Level %in% c("Elementary School", "Middle School", "High School"), ]
data <- data[complete.cases(data), ]
aesthetic <- aes(x=School.Name, y=Fraction, fill=Race)#, width=Total/1800)
geometry <- geom_bar(stat="identity", position="stack")

ggplot(data, aesthetic) + geometry + 
   facet_grid( ~ School.Level) + 
   theme(axis.title.y=element_blank(),
           axis.text.y=element_blank(),
           axis.ticks.y=element_blank()) +
  coord_flip()
