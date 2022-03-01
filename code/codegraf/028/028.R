library(dplyr) # to wrangle tibbles
library(readr) # to read tibbles
library(magrittr) # for pipes

# ------------------
# Regression for prediction
# ------------------

# World Bank data
# data on Women and Development downloaded from their Data Catalog at http://wdi.worldbank.org/table/WV.5
wb_data_raw <- read.csv("https://gist.github.com/baskaufs/510972a23e3153edc133e33a2fcdf3d1/raw/ce8d6f160d5716b418a9874c22e614d95946a9be/wv_5_women_and_development.csv", na.strings = "..")
wb_data <- wb_data_raw[1:217,] %>%
  filter(!is.na(female_life_expectancy_at_birth_2017)) %>%
  filter(!is.na(percentage_of_women_ages_20.24_first.married_by_age_18))
plot(wb_data$female_life_expectancy_at_birth_2017 ~ wb_data$percentage_of_women_ages_20.24_first.married_by_age_18)
model <- lm(wb_data$female_life_expectancy_at_birth_2017 ~ wb_data$percentage_of_women_ages_20.24_first.married_by_age_18)
model
abline(model)
summary(model)

# ------------------
# Regression as a statistical test
# ------------------

# Example from The Analysis of Biological Data (2nd Ed.) by Witlock and Schluter
# https://whitlockschluter.zoology.ubc.ca/r-code/rcode17
iris <- read.csv(url("http://www.zoology.ubc.ca/~schluter/WhitlockSchluter/wp-content/data/chapter17/chap17f6_3IrisPollination.csv"))

plot(grainsDeposited ~ tubeLengthMm, data = iris)
iris_model <- lm(grainsDeposited ~ tubeLengthMm, data = iris)
abline(iris_model)

res <- residuals(iris_model)
plot(res ~ iris$tubeLengthMm)
hist(res)
plot(iris_model)
shapiro.test(res)

# Square root transformation.
iris$transformed_grains <- sqrt(iris$grainsDeposited)

plot(transformed_grains ~ tubeLengthMm, data = iris)
transformed_model <- lm(transformed_grains ~ tubeLengthMm, data = iris)
abline(transformed_model)
transformed_res <- residuals(transformed_model)
hist(transformed_res)
plot(transformed_model)
shapiro.test(residuals(transformed_model))
summary(transformed_model)

# Siegel nonparametric linear regression
# See https://rcompanion.org/handbook/F_12.html
# Non-parametric alternative, will have to install mblm the first time you use it
library(mblm)
model <- mblm(grainsDeposited ~ tubeLengthMm, data = iris)
summary(model)

# See http://extremelearning.com.au/the-siegel-and-theil-sen-non-parametric-estimators-for-linear-regression/
# for more on the Siegel method

# ------------------
# Correlation
# ------------------

# Correlation between knowing someone with COVID-19 symptoms and rate of mask use 
# https://www.washingtonpost.com/business/2020/10/23/pandemic-data-chart-masks/

covid_mask_all <- read.csv("https://gist.githubusercontent.com/baskaufs/97d77d5ee7ed947e28f5ea7f76b85967/raw/3c2788d25edfb34de970abc82330661524c3689f/covid-mask-symptoms.csv")
# Remove the state abbreviation column
covid_mask <- transmute(covid_mask_all, pct_symptoms, pct_wear_mask)
plot(pct_symptoms ~ pct_wear_mask, data = covid_mask)
cor.test(covid_mask$pct_symptoms, covid_mask$pct_wear_mask)

# MVN library performs tests for bivariate normality
# see https://cran.r-project.org/web/packages/MVN/vignettes/MVN.pdf

# library to test for multivariate normality, probably will need to install (and it's a big one)
library(MVN)

# Royston test depends on Shapiro-Wilk's test (univariate test for normality), valid for 3 < N < 5000

result <- mvn(data = covid_mask, mvnTest = "royston", univariatePlot = "qqplot")
result <- mvn(data = covid_mask, mvnTest = "royston", univariatePlot = "histogram")
result

# Correlation using built-in dataset "iris"
data("iris") # measurements of flower parts of three iris species
setosa <- iris[1:50, 3:4] # subset the data for only the setosa species and petal data

plot(setosa$Petal.Length ~ setosa$Petal.Width)
# perform a correlation test
petal_cor <- cor.test(setosa$Petal.Length, setosa$Petal.Width)
petal_cor

result <- mvn(data = setosa, mvnTest = "royston", univariatePlot = "qqplot")
result <- mvn(data = setosa, mvnTest = "royston", univariatePlot = "histogram")
result

transf <- transmute(setosa, Petal.Length, transformed_width = log(Petal.Width))
result <- mvn(data = transf, mvnTest = "royston", univariatePlot = "histogram")
result

# Non-parametric alternatives to correlation: Kendall and Spearman rank correlation tests
ken <- cor.test(setosa$Petal.Length, setosa$Petal.Width, method="kendall")
ken

spear <- cor.test(setosa$Petal.Length, setosa$Petal.Width, method="spearman")
spear
