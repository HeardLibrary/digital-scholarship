# -----------------------------
# Homework
# -----------------------------

# The World Bank has assembled data on World Development Indicators.  We will examine some
# data on Women and Development downloaded from their Data Catalog at
# http://wdi.worldbank.org/table/WV.5 A downloaded Excel file is archived at
# https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/WV.5_Women_and_Development.xlsx
# The Excel file has a lot of extraneous rows that would not read into R, as well as 
# non-standard missing data values.  The data have been cleaned up a little in this CSV:
# https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/wv5_women_and_development.csv

# 1. Load the CSV file and summarize the column headers
womens_data <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/wv5_women_and_development.csv")
str(womens_data)

# 2. Notice that the last 12 lines contain summary data and not data from individual countries.
# For the male and female life expectancy at birth columns, extract only the country data from the 
# whole column vector. Check that it worked by looking at the last six values in the 
# resulting vector
male_life_expect <- womens_data$male_life_expectancy_at_birth_2017[1:215]
female_life_expect <- womens_data$female_life_expectancy_at_birth_2017[1:215]
tail(male_life_expect)

# 3. Plot female life expectancy vs. male life expectancy and include the best fit trendline.
# Based on the model information, how much longer do women typically live than men?
plot(female_life_expect ~ male_life_expect)
model <- lm(female_life_expect ~ male_life_expect)
abline(model)
model
# based on the intercept, females live 2.9 years longer.

# 4. What kind of data structure is the nondiscrimination_clause_mentions_gender_in_the_constitution
# column? Convert it to a factor (omitting the last 12 lines).  

# vector of integers
nondiscrimination <- factor(womens_data$nondiscrimination_clause_mentions_gender_in_the_constitution[1:215],
                            levels = c(0,1),
                            labels = c("no", "yes"))

# 5. Create a box and whisker plot comparing female life expectency in countries where the 
# constitution mentions gender in a non-discrimination clause and where it does not.
plot(female_life_expect ~ nondiscrimination)

# Do women live longer in countries where constitutions mention gender in a non-discrimination clause?

# No, the mean is higher for "no"