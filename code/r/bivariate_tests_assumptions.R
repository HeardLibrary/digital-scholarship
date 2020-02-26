# ------------------
# Information from last week
# ------------------

# We want to pull out the following responses from the two listed datasets,
# then merge them into one. Page numbers are from the x-Frequencies.pdf document
# where x is the dataset identifier.

# DS0001
# AID Unique participant identifier
# IYEAR YEAR OF INTERVIEW-W1 p. 3 no missing values
# BIO_SEX BIOLOGICAL SEX-W1 p. 4 missing value 6 1=male, 2=female
# H1GI1Y S1Q1 BIRTH YEAR-W1 p. 6 missing value 96
# H1PF1 S18Q1 Mom warm and loving p. 364 missing values 6-8
# H1PF2 S18Q2 Mom encurages independence p. 364 missing values 6-8
# H1PF3 S18Q3 Mom discusses ethics p. 365 missing values 6-9
# H1PF4 S18Q4 Mom good communication p. 365 missing values 6-9
# H1PF5 S18Q5 Mom good relationship p. 366 missing values 6-9
# H1PF23 S18Q23 Dad warm and loving p. 375 missing values 6-9
# H1PF24 S18Q24 Dad good communication p. 376 missing values 6-9
# H1PF25 S18Q25 Dad good relationship p. 376 missing values 6-9
# 
# DS0022
# AID Unique participant identifier
# H4TO1 S23Q1 Ever smoked entire cigarette p. 399 missing values 6-8
# H4TO2 S23Q2 Age 1st smoked entire cigarette p. 399 missing values 96-98
# H4TO3 S23Q3 Ever smoked cigs regularly p. 400 missing values 6-8
# H4TO4 S23Q4 Age smoled cigs regularly p. 401 missing values 96-98
# H4TO5 S23Q5 Num days smokd cigs lst 30 days p. 402
# H4GH6 S4Q6 Weight lbs p. 50 missing values 996 and 998
# H4GH5F S4Q5F Height feet p. 49 missing value 98
# H4GH5I S4Q5I Height inches p. 49 missing value 98

# ------------------
# Re-calculate maternal closeness (from last week)
# ------------------

# library(tidyverse) # use if you installed the whole tidyverse
library(readr) # for reading tibbles
library(dplyr) # tibble manipulation
setwd("~/nls_data/class/")

# load data
inner_raw <- read_csv("inner_raw.csv")

# calculate change missing values to NA, then calculate BMI
with_maternal <- inner_raw %>%
  # replace missing data numbers with NA
  mutate(H1GI1Y = replace(H1GI1Y, H1GI1Y==96, NA)) %>% # birth year missing value 96
  mutate(BIO_SEX = replace(BIO_SEX, BIO_SEX==6, NA)) %>% # biological sex missing value 6
  mutate(BIO_SEX = replace(BIO_SEX, BIO_SEX==1, "male")) %>% # biological sex missing value 6
  mutate(BIO_SEX = replace(BIO_SEX, BIO_SEX==2, "female")) %>% # biological sex missing value 6
  mutate(H4TO1 = replace(H4TO1, H4TO1>=6, NA)) %>% # smoked a cigarette? missing value 6-8
  mutate(H4TO2 = replace(H4TO2, H4TO2>=96, NA)) %>% # age 1st smoked missing value 96-98
  mutate(H4TO3 = replace(H4TO3, H4TO3>=6, NA)) %>% # smoked regularly? missing value 6-8
  mutate(H4TO4 = replace(H4TO4, H4TO4>=96, NA)) %>% # age smoked regularly missing values 96-98
  mutate(H4TO5 = replace(H4TO5, H4TO5>=32, NA)) %>% # number days/month smoked missing values greater than 31
  mutate(H4GH6 = replace(H4GH6, H4GH6>=990, NA)) %>% # weight missing values 996 and 998
  mutate(H4GH5F = replace(H4GH5F, H4GH5F==98, NA)) %>% # feet missing value 98
  mutate(H4GH5I = replace(H4GH5I, H4GH5I==98, NA)) %>% # inches missing value 98
  # calculate age
  mutate(age = IYEAR - H1GI1Y) %>% # interview year minus birth year
  # calulate the BMI value
  mutate(height_m = H4GH5F*12 + H4GH5I) %>% # convert feet and inches to inches
  mutate(height_m = height_m*2.54/100) %>% # convert inches to meters
  mutate(mass_kg = H4GH6*0.453592) %>% # convert pounds to kg
  mutate(bmi = mass_kg/height_m^2)  %>% # calculate BMI
  mutate(H1PF1 = replace(H1PF1, H1PF1>=6, NA)) %>%
  mutate(H1PF2 = replace(H1PF2, H1PF2>=6, NA)) %>%
  mutate(H1PF3 = replace(H1PF3, H1PF3>=6, NA)) %>%
  mutate(H1PF4 = replace(H1PF4, H1PF4>=6, NA)) %>%
  mutate(H1PF5 = replace(H1PF5, H1PF5>=6, NA)) %>%
  mutate(H1PF23 = replace(H1PF23, H1PF23>=6, NA)) %>%
  mutate(H1PF24 = replace(H1PF24, H1PF24>=6, NA)) %>%
  mutate(H1PF25 = replace(H1PF25, H1PF25>=6, NA)) %>%
  mutate(mc_H1PF1 = ifelse(!H1PF1==1 & !is.na(H1PF1), 0, ifelse(H1PF1==1, 1, NA))) %>%
  mutate(mc_H1PF2 = ifelse(!H1PF2==1 & !is.na(H1PF2), 0, ifelse(H1PF2==1, 1, NA))) %>%
  mutate(mc_H1PF3 = ifelse(!H1PF3==1 & !is.na(H1PF3), 0, ifelse(H1PF3==1, 1, NA))) %>%
  mutate(mc_H1PF4 = ifelse(!H1PF4==1 & !is.na(H1PF4), 0, ifelse(H1PF4==1, 1, NA))) %>%
  mutate(mc_H1PF5 = ifelse(!H1PF5==1 & !is.na(H1PF5), 0, ifelse(H1PF5==1, 1, NA))) %>%
  mutate(maternal_closeness = ifelse(mc_H1PF1==1 & mc_H1PF2==1 & mc_H1PF3==1 & mc_H1PF4==1 & mc_H1PF5==1, 1, ifelse(is.na(H1PF1) | is.na(H1PF2) | is.na(H1PF3) | is.na(H1PF4) | is.na(H1PF5), NA, 0))) %>%
  mutate(maternal_closeness_factor = factor(maternal_closeness, levels = c(0, 1),labels = c("distant", "close")))

write_csv(with_maternal, "mutated_data.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# ------------------
# Correlation
# ------------------

# library to test for multivariate normality
library(MVN)

data("iris") # measurements of flower parts of three iris species (built-in dataset)
setosa <- iris[1:50, 1:4] # subset the data
head(setosa)
plot(setosa$Petal.Length ~ setosa$Petal.Width)

# perform a correlation test
petal_cor <- cor.test(setosa$Petal.Length, setosa$Petal.Width)
petal_cor

# Assumptions of correlation:
# 1. random sample
# 2. bivariate normal distribution

# Bivariate normal distribution:
# 1. linear X/Y relationship
# 2. scatterplot eliptical
# 3. X and Y distributions are separately normal

# MVN library performs tests for bivariate normality
# see https://cran.r-project.org/web/packages/MVN/vignettes/MVN.pdf
# Royston test depends on Shapiro-Wilk's test (univariate test for normality), valid for 3 < N < 5000
result <- mvn(data = setosa, mvnTest = "royston", univariatePlot = "qqplot")
result <- mvn(data = setosa, mvnTest = "royston", univariatePlot = "histogram")
result

# ------------------
# Correlation between smoking and BMI (two continuous variables)
# ------------------

# load if necessary
library(ggplot2)
library(readr) # for reading tibbles
library(dplyr) # tibble manipulation
setwd("~/nls_data/class/")
with_maternal <- read_csv("mutated_data.csv")

# Relationship between number of days/month smoking and BMI
plot(with_maternal$bmi ~ with_maternal$H4TO5)

# slapdash regression to see if interesting
model <- lm(with_maternal$bmi ~ with_maternal$H4TO5)
abline(model)
summary(model)

# since cause and effect is not really known, should be a correlation
bmi_smoking_cor <- cor.test(with_maternal$bmi, with_maternal$H4TO5)
bmi_smoking_cor

# ggplot visualization
# see ggplot cheat sheet at https://rstudio.com/resources/cheatsheets/ under "Data Visualization Cheat Sheet"

# ggplot() creates a coordinate system and specifies data
ggplot(data = with_maternal) + 
  # geom is a layer of data on the plot. geom_point creates scatterplot
  # aesthetic aes() is the visual properties of the layer
  geom_point(mapping = aes(x = H4TO5, y = bmi, color = BIO_SEX), position = position_dodge(width = .3)) +
  # geom_smooth() fits a curve to the data
  geom_smooth(mapping = aes(x = H4TO5, y = bmi, color = BIO_SEX)) + 
  # labels labs() controls the labels of the axes and legend
  labs(y="body mass index (BMI)", x = "days smoked per month", color = "sex")

# test assumptions of bivariate normality
normality_test <- select(with_maternal, H4TO5, bmi)
large_subset_normality <- normality_test[1:1000, 1:2]
large_subset_result <- mvn(data = large_subset_normality, mvnTest = "royston", univariatePlot = "qqplot")
large_subset_result <- mvn(data = large_subset_normality, mvnTest = "royston", univariatePlot = "histogram")
large_subset_result

small_subset_normality <- normality_test[1:20, 1:2]
small_subset_result <- mvn(data = small_subset_normality, mvnTest = "royston", univariatePlot = "qqplot")
small_subset_result <- mvn(data = small_subset_normality, mvnTest = "royston", univariatePlot = "histogram")
small_subset_result
# notice how the reduced power from the small dataset results in difference from normality not significant for bmi

# It's really inappropriate to use correlation here; smoking can't easliy be fixed.
# (We could try a transformation, but it's really bimodal!)

# probably better to just make it a discontinuous variable (factor)
smoking_data <- with_maternal %>%
  mutate(smoker_coded = ifelse(H4TO5<=15 & !is.na(H4TO5), 0, ifelse(H4TO5>15, 1, NA))) %>%
  mutate(smoker_factor = factor(smoker_coded, levels = c(0, 1),labels = c("nonsmoker", "smoker")))
write_csv(smoking_data, "smoking_data.csv", na = "NA", append = FALSE, col_names = TRUE, quote_escape = "double")

# basic box and whisker plot
plot(smoking_data$bmi ~ smoking_data$smoker_factor)

# prettier plot with ggplot
ggplot(data = smoking_data, aes(x=smoker_factor, y=bmi, color=smoker_factor)) +
  geom_boxplot() +
  geom_violin(alpha = 0.3) # alpha controls transparency

# create a density plot to examine normality
d <- density(na.omit(smoking_data$bmi)) # must ignore NAs
plot(d) # plots the results

# do a Shapiro-Wilk test for normality
shapiro.test(smoking_data$bmi[1:4000])
shapiro.test(smoking_data$bmi[1:100])

transformed_bmi <- log(na.omit(smoking_data$bmi))
d <- density(transformed_bmi)
plot(d)
shapiro.test(transformed_bmi[1:4000])
shapiro.test(transformed_bmi[1:100])

transformed_smoking_data <- smoking_data %>%
  mutate(bmi_transformed = log(bmi))

# plot of transformed data
ggplot(data = transformed_smoking_data, aes(x=smoker_factor, y=bmi_transformed, color=smoker_factor)) +
  geom_boxplot() +
  geom_violin(alpha = 0.3)
# Y axis not meaningful any more, but much more normal

# t-test of means assumes normality, so let's go for it
t.test(bmi_transformed ~ smoker_factor, data=transformed_smoking_data, var.equal=TRUE, conf.level=0.95)

# ------------------
# Relationship between maternal closeness and smoking (both discontinuous)
# ------------------

contingency_table <- table(smoking_data$smoker_factor, smoking_data$maternal_closeness_factor)
contingency_table
chisq.test(contingency_table)

# visualize with ggplot
# see https://murraylax.org/rtutorials/viscrosstabs.html
proportion_table <- prop.table(contingency_table)
table_dframe <- as.data.frame(proportion_table)
names(table_dframe) <- c("smoking", "closeness", "frequency")
glimpse(table_dframe)

ggplot(table_dframe, aes(x=closeness, y=frequency, fill=smoking)) + geom_col()



