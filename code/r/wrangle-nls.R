# ------------------
# Homework assignment #1: Select subset of responses and merge datasets
# ------------------

# We want to pull out the following responses from the two listed datasets,
# then merge them into one. Page numbers are from the x-Frequencies.pdf document
# where x is the dataset identifier.

# DS0001
# AID Unique participant identifier
# H1PF1 S18Q1 Mom warm and loving p. 364
# H1PF2 S18Q2 Mom encurages independence p. 364
# H1PF3 S18Q3 Mom discusses ethics p. 365
# H1PF4 S18Q4 Mom good communication p. 365
# H1PF5 S18Q5 Mom good relationship p. 366
# H1PF23 S18Q23 Dad warm and loving p. 375
# H1PF24 S18Q24 Dad good communication p. 376
# H1PF25 S18Q25 Dad good relationship p. 376
# 
# DS0022
# AID Unique participant identifier
# H4TO1 S23Q1 Ever smoked entire cigarette p. 399
# H4TO2 S23Q2 Age 1st smoked entire cigarette p. 399
# H4TO3 S23Q3 Ever smoked cigs regularly p. 400
# H4TO4 S23Q4 Age smoled cigs regularly p. 401
# H4TO5 S23Q5 Num days smokd cigs lst 30 days p. 402
# H4GH6 S4Q6 Weight lbs p. 50 missing values 996 and 998
# H4GH5F S4Q5F Height feet p. 49 missing value 98
# H4GH5I S4Q5I Height inches p. 49 missing value 98

# load necessary packages

# library(tidyverse) # use if you installed the whole tidyverse
library(readr) # for reading tibbles
library(dplyr) # tibble manipulation

# set working directory to location of downloaded files

setwd("~/nls_data/class/")

# read in the two datasets and create tibbles for them

closeness <- read_tsv("21600-0001-Data.tsv")
physical <- read_tsv("21600-0022-Data.tsv")

# extract columns for analysis from big tibbles into small tibbles

# *code here*

# perform outer join to merge the two small tibbles
combined_outer_join <- # *code here*
head(combined_outer_join)

combined_inner_join <- # *code here*
head(combined_inner_join)

# save files to avoid having to load the big datasets into memory
write_csv(combined_outer_join, "outer_raw.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")
write_csv(combined_inner_join, "inner_raw.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# ------------------
# Homework assignment #2: Calculate a BMI column
# ------------------

# Easiest to do by creating a column for height in meters and column for mass in kg first.
# Start here if already saved small files
# BMI formula is mass in kg divided by (height in m squared)

# library(tidyverse) # use if you installed the whole tidyverse
library(readr) # for reading tibbles
library(dplyr) # tibble manipulation
setwd("~/nls_data/class/")

# load data
inner_raw <- read_csv("inner_raw.csv")

# examine weight data
summary(inner_raw$H4GH6)
no_na <- mutate(inner_raw, H4GH6 = replace(H4GH6, H4GH6>=990, NA))
summary(no_na$H4GH6)

# calculate BMI
bmi_tibble <- inner_raw %>%
  # *code here*
  
# ------------------
# Homework assignment #3: Calculate a maternal closeness column
# ------------------

# change missing values to NA, then calculate maternal closeness
with_maternal <- bmi_tibble %>%
  # *code here*
  
write_csv(with_maternal, "mutated_data.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")
