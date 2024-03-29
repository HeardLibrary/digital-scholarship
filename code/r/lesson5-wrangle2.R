# ------------------
# Data wrangling (part 2)
# ------------------

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

# CHANGING COLUMNS

# Changing the data type of a column
schools_tibble$`Zip Code` <- factor(schools_tibble$`Zip Code`)
str(schools_tibble)

# REPLACING VALUES
# Format is mutate(tibble_name, column_to_replace = replace(source_column, condition, replacement_value)
mutate(schools_tibble, `School Level` = replace(`School Level`, `School Level` == "Elementary School", "Primary School"))
# There are other ways to do this, but this is the tidyverse way

# Probably a good idea to clear your Global Environment again here

# JOINS

# See R For Data Science chapter 13 for explanation https://r4ds.had.co.nz/relational-data.html
# See dplyr documentation at https://dplyr.tidyverse.org/reference/join.html#join-types for details

# data from Wold Bank World Development Indicators: Women and Development http://wdi.worldbank.org/table/WV.5
# cleaned up at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/wv5_women_and_development.csv
womens_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/r/wv5_women_and_development.csv")

# data from World Bank Poverty Headcount Ratio https://data.worldbank.org/indicator/SI.POV.DDAY?locations=1W&start=1981&end=2015&view=chart
# cleaned up at https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/poverty_data_714650.csv
poverty_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/r/poverty_data_714650.csv")

# for a full outer join (all rows from both tables) outputting all columns:
outer_joined_data <- full_join(womens_data, poverty_data, by = c("country"="Country Name"), copy = FALSE, suffix = c(".wom", ".pov") )
outer_sorted_data <- arrange(outer_joined_data, country)

# for a inner join (only common rows in both tables) outputting all columns:
inner_joined_data <- inner_join(womens_data, poverty_data, by = c("country"="Country Name"), copy = FALSE, suffix = c(".wom", ".pov") )
inner_sorted_data <- arrange(inner_joined_data, country)

# Note that the full outer joined data includes "Arab World" (only in the poverty data); inner join does not

# Now that we have combined the dataset, we can check for a relationship between the female employment percentage and
# the 2015 percentage of poverty for countries in the joined dataset
plot(outer_sorted_data$`2015` ~ outer_sorted_data$female_employment_percentage)
model <- lm(outer_sorted_data$`2015` ~ outer_sorted_data$female_employment_percentage)
abline(model)
summary(model)

# Clear data here again

# ------------------
# Pipelines using pipes
# ------------------

# Wickham and Grolemund Chapter 18 Pipes https://r4ds.had.co.nz/pipes.html

# Pipes were developed in the magrittr package

library(magrittr)

# Reformulating the schools data
# Load tibble, select high school rows, create total column, create subset with fractional values

schools_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")
high_schools_data <- filter(schools_tibble, `School Level` == "High School")
data_with_total <- mutate(high_schools_data, total_students = Male + Female)
fractional <- mutate(data_with_total, econ_disadvantaged = `Economically Disadvantaged`/total_students, limited_english = `Limited English Proficiency`/total_students)
output <- select(fractional, `School Name`, total_students, econ_disadvantaged, limited_english)

# Pipe symbol %>% sends output from one function into the next function as the data source
# Data source in function needs to be the first argument.
# In the pipeline, the first argument is omitted.

# Output goes to the console

read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv") %>%
  filter(`School Level` == "High School") %>%
  mutate(total_students = Male + Female) %>%
  mutate(econ_disadvantaged = `Economically Disadvantaged`/total_students, limited_english = `Limited English Proficiency`/total_students) %>%
  select(`School Name`, total_students, econ_disadvantaged, limited_english)

# Piping eliminates the need for many named intermediate objects and is easier to follow

# To assign the output value of the pipe to an object, use the assignment operator

summary <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv") %>%
  filter(`School Level` == "High School") %>%
  mutate(total_students = Male + Female) %>%
  mutate(econ_disadvantaged = `Economically Disadvantaged`/total_students, limited_english = `Limited English Proficiency`/total_students) %>%
  select(`School Name`, total_students, econ_disadvantaged, limited_english)

summary

# output directly to a file

# find out where the file is going
getwd()

read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv") %>%
  filter(`School Level` == "High School") %>%
  mutate(total_students = Male + Female) %>%
  mutate(econ_disadvantaged = `Economically Disadvantaged`/total_students, limited_english = `Limited English Proficiency`/total_students) %>%
  select(`School Name`, total_students, econ_disadvantaged, limited_english) %>% 
  write_csv("schools-output.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# If the data are already in a tibble (or generic data frame), the tibble can be piped in directly:

schools_tibble %>%
  filter(`School Level` == "High School") %>%
  mutate(total_students = Male + Female)

# etc.