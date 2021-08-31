# Run these installation commands ONLY ONCE
install.packages("tidyverse")
install.packages("maps")
install.packages("car")

# Script starts here
library(tidyverse)
library(magrittr)

#-------------
# Data visualization: Map schools in Davidson County, Tennessee
#-------------
# Load shape of Davidson County
davidson <- map_data("county", "tennessee")  %>%
  filter(subregion == "davidson")

# Load schools data for only elementary, middle, and high schools
schools_data <- read_csv("https://github.com/HeardLibrary/digital-scholarship/raw/master/data/gis/wg/Metro_Nashville_Schools.csv") %>%
  filter(`School Level` == "Middle School" | `School Level` == "High School" | `School Level` == "Elementary School" )

# Create a plot with the county outline and school locations
ggplot() +
  geom_polygon(data = davidson, mapping = aes(long, lat, group = group), fill = "white", colour = "grey50") + 
  geom_point(data = schools_data, mapping = aes(x = Longitude, y = Latitude, colour = `School Level`)) + 
  coord_quickmap()

# Convert absolute numbers of limited proficiency to relative and plot
rel_data <- mutate(schools_data, total = Male + Female) %>%
  mutate(limited_proficiency = `Limited English Proficiency`/total * 100) %>%
  filter(!is.na(limited_proficiency)) 

ggplot(data = rel_data) +
  geom_boxplot(mapping = aes(`School Level`, limited_proficiency, colour = `School Level`)) +
  labs(y="limited English proficiency (percent)", x = "school level")

# ------------------
# Data wrangling: combine and clean datasets
# ------------------

# read in the two datasets and create tibbles for them
sex <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/sex.csv")
head(sex)
bmi <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/bmi.csv")
head(bmi)

# perform outer join to merge the two tibbles
combined_outer_join <- full_join(sex, bmi, by = c("code"), copy = FALSE, suffix = c(".close", ".phys") )
head(combined_outer_join)

combined_inner_join <- inner_join(sex, bmi, by = c("code"), copy = FALSE, suffix = c(".close", ".phys") )
head(combined_inner_join)

# examine weight data for problems
summary(combined_inner_join$weight)
no_na <- mutate(combined_inner_join, weight = replace(weight, weight==999, NA))
summary(no_na$weight)

# calculate change missing values to NA, then calculate BMI
bmi_tibble <- combined_inner_join %>%
  # change coding of sex
  mutate(sex = replace(sex, sex==1, "male")) %>%
  mutate(sex = replace(sex, sex==2, "female")) %>%
  # replace missing data numbers with NA
  mutate(weight = replace(weight, weight==999, NA)) %>% # weight missing values 999
  mutate(feet = replace(feet, feet==99, NA)) %>% # feet missing value 99
  mutate(inches = replace(inches, inches==99, NA)) %>% # inches missing value 99
  # calculate the BMI value
  # BMI formula is mass in kg divided by (height in m squared)
  mutate(height_m = feet*12 + inches) %>% # convert feet and inches to inches
  mutate(height_m = height_m*2.54/100) %>% # convert inches to meters
  mutate(mass_kg = weight*0.453592) %>% # convert pounds to kg
  mutate(bmi = mass_kg/height_m^2) # calculate BMI
head(bmi_tibble)

# use ggplot to plot height vs. age, colored by sex with smooth geom
ggplot(data = bmi_tibble, mapping = aes(x = height_m, y = bmi, color = sex)) + 
  geom_point() +
  geom_smooth(method = "lm", se = TRUE) +
  labs(y="body mass index", x = "height (m)", color = "sex")

# NOTE: if you are not using RStudio Cloud, run the following line to find out your working directory.
# This is where the file created in the next part will be saved.
getwd()

transmute(bmi_tibble, sex, bmi) %>%
  filter(!is.na(bmi)) %>%
  write_csv("deidentified_bmi.csv", na = "NA", append = FALSE, col_names = TRUE, escape = "double")
# To download the file in RStudio Cloud, go to the Files pane, check the box for the file, drop down More, then select Export...

# ------------------
# Statistical analysis: One-factor analysis of variance (ANOVA)
# ------------------
library(car)

# Load the data and fit a model to it
ergDframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
# Visualize data
ggplot(ergDframe, aes(color, response)) + 
  geom_boxplot()
# fit a linear model to the data
model <- lm(response ~ as.factor(color), data = ergDframe)

# test residuals for normality
resid <- residuals(model)
hist(resid)
shapiro.test(resid)

# examine and test for homogeneity of variances
plot(resid ~ as.factor(ergDframe$color))
plot(model)
leveneTest(response ~ color, data=ergDframe, center=mean) # Levene's test

# perform log transformation and fit model to new data
ergDframe$log <- log(ergDframe$response)
head(ergDframe)
model_log <- lm(log ~ color, data = ergDframe)  # fit a linear model to the data

# test the transformed data for normality
resid_log <- residuals(model_log)
hist(resid_log)
shapiro.test(resid_log)

# examine transformed data for homogeneity of variances
plot(resid_log ~ as.factor(ergDframe$color))
plot(model_log)
leveneTest(log ~ color, data=ergDframe, center=mean) # Levene's test

# Satisfied with the transformation, so run the ANOVA on the model
anova(model_log)

# Tukey-Kramer post-hoc tests
av <- aov(model_log) # must create an ANOVA object for TukeyHSD
summary(av)
TukeyHSD(av)

