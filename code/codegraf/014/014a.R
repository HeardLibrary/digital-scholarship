# ------------------
# Tidy Data and data wrangling
# ------------------

# tidyverse is an "umbrella" package that contains many individual packages for wrangling data
# Loading it allows you to avoid loading many separate packages. 
# Alternatively, each required library can be loaded separately.
# If you have not already installed the tidyverse package, this is a good time to do it.
# If you have troupble installing it, you can always install and load its component packages separately.

library(tidyverse)

# The authoritative work on this topic is "R For Data Science" by Hadley Wickham and Garrett Grolemund
# available online at https://r4ds.had.co.nz/
# Relevant chapters are linked in appropriate places in the script.

# Also recommended is the Data Carpentries lesson "Data Analysis and Visualization in R for Ecologists"
# "Manipulating data" lesson https://datacarpentry.org/R-ecology-lesson/03-dplyr.html

# ------------------
# Tidy Data
# ------------------

# Wickham and Grolemund Chapter 12 Tidy data https://r4ds.had.co.nz/tidy-data.html

# For videos describing the cockroach electroretinogram (ERG) experiment, see https://youtu.be/aAdnZsggZZw

# tidyr is a library specifically for "tidying" data
library(tidyr)
library(readr)

# Turn "notebook" data into tidy data
# See https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/notebook_format.csv

erg_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/notebook_format.csv")
View(erg_tibble)

erg_tidy <- pivot_longer(erg_tibble, cols = c("blue", "green", "red"), names_to = "light_color", values_to = "response_voltage")
View(erg_tidy)

# For reference, the pivot_wider() function carries out the inverse process
wide <- pivot_wider(erg_tidy, names_from = "light_color", values_from = "response_voltage")
# Same as originally downloaded file
View(wide)
# Save on local drive
write_csv(wide, "wide_erg_data.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# This is the other possible form one might use in a notebook
more_wide <- pivot_wider(erg_tidy, names_from = "block", values_from = "response_voltage")
View(more_wide)

# Note: pivot_longer() replaces the older function gather() and pivot_wider replaces spread()

# For more examples and practice, see this Software Carpentries lesson:
# http://swcarpentry.github.io/r-novice-gapminder/14-tidyr/index.html

# ------------------
# Creating modified tibbles
# ------------------

# Wickham and Grolemund Chapter 5 Data transformation https://r4ds.had.co.nz/transform.html

# We use the diplyr package to reformulate tibbles
library(dplyr)

# Load schools data
schools_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")
# view columns info
str(schools_tibble)
# Notice that tibbles allow spaces in column names. Use backticks ` to quote the column name with spaces.

# FILTERING ROWS

# Try this:
filter(schools_tibble, `Zip Code` == 37212)
# Double equals is a test for equality. The expression `Zip Code` == 37212 generates a boolean (TRUE or FALSE) for each row

# How could we locate only high schools?
filter(schools_tibble, `School Level` == "High School")

# We could also check for schools that have some number of 12th graders:
filter(schools_tibble, !is.na(`Grade 12`))
# is.na() produces TRUE when there is a missing value (NA). 
# Exclamation point is NOT, so !is.na() produced TRUE when there is not a missing value.

# We can assign the result to another tibble
high_schools_data <- filter(schools_tibble, `School Level` == "High School")

# SELECTING COLUMNS

# review columns info
str(schools_tibble)

# select columns by list
select(schools_tibble, Male, Female)

# select columns by range
select(schools_tibble, `School Year`:`Zip Code`)

# select colummns by starts_with()
select(schools_tibble, starts_with("Grade"))

# More options (shown in Help pane)
?select

# CREATING NEW COLUMNS WITH MUTATE AND TRANSMUTE

# Create an additional total_students column at the end by adding males and females
mutate(schools_tibble, total_students = Male + Female)

# Create a new tibble containing only the new column and others
small_dataset <- transmute(schools_tibble, `School Name`, total_students = Male + Female, `Economically Disadvantaged`)
small_dataset
