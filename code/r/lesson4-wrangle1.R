# ------------------
# Data wrangling (part 1)
# ------------------

# tidyverse is an "umbrella" package that contains many individual packages for wrangling data
# Loading it allows you to avoid loading many separate packages. 
# Alternatively, each required library can be loaded separately

# library(tidyverse)

# The authoritative work on this topic is "R For Data Science" by Hadley Wickham and Garrett Grolemund
# available online at https://r4ds.had.co.nz/
# Relevant chapters are linked in appropriate places in the script.

# Also recommended is the Data Carpentries lesson "Data Analysis and Visualization in R for Ecologists"
# "Manipulating data" lesson https://datacarpentry.org/R-ecology-lesson/03-dplyr.html

# ------------------
# Tibbles
# ------------------

# tidyverse packages operate on tibbles, a special type of data frame. 
# When data frames are operated upon by a tidyverse function, the output is generally a tibble.
# The readr package provides analogs to read.csv() that loads CSV data as a tibble. 
# In particular, it does not automatically turn character strings into factors

library(readr)

# compare the two data structures by clicking on their listings in the global environment pane
erg_dframe <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
erg_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")

# They basically look the same
# Now compare their table summaries
str(erg_dframe)
str(erg_tibble)

# Notice the difference in how the block and color columns are read in.
# If the file has tab delimiters instead of commas, you can use read_tsv()

# For reference: how to write a tibble to a CSV file
write_csv(tibble_name, "file_name.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# Example uses common options (include column names, replace existing file if any).
# See https://readr.tidyverse.org/reference/write_delim.html for details.

# Clear your workspace before continuing.

# ------------------
# Tidy Data
# ------------------

# Wickham and Grolemund Chapter 12 Tidy data https://r4ds.had.co.nz/tidy-data.html

# For videos describing the cockroach electroretinogram (ERG) experiment, see https://youtu.be/aAdnZsggZZw

# tidyr is a library specifically for "tidying" data
library(tidyr)

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

