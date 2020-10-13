# -------------
# Factors
# -------------

water_conditions <- c("wet", "wet", "dry", "wet", "dry", "wet")
height <- c(25, 21, 14, 13, 10, 18)
water_factor <- factor(water_conditions)
water_conditions
water_factor
height

# Creating a data frame from vectors
group <- c("reptile", "arachnid", "annelid", "insect") # character strings
number_legs <- c(4,8,0,6) # numbers
organism_info <- data.frame(group, number_legs)

# Human heights data file: https://github.com/HeardLibrary/digital-scholarship/blob/master/data/r/t-test.csv
df_from_file <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/t-test.csv")

df_from_file$grouping
class(df_from_file$grouping)
df_from_file$height
class(df_from_file$height)

sex <- as.character(df_from_file$grouping)
df_from_file$grouping
sex
class(sex)

library("readr")
tibble_from_file <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/t-test.csv")

# -------------
# t-test of means
# -------------

t.test(height ~ grouping, data=df_from_file, var.equal=TRUE)

library("dplyr")
men <- filter(df_from_file, df_from_file$grouping == "men")

# histogram of heights
hist(men$height)

# create a density plot to examine normality
d <- density(men$height)
plot(d) # plots the results

# normal quantile plot
qqnorm(men$height, datax = TRUE)

#Shapiro-Wilkes test for normality
shapiro.test(men$height)

women <- filter(df_from_file, df_from_file$grouping == "women")

# histogram of heights
hist(women$height)

# create a density plot to examine normality
d <- density(women$height)
plot(d) # plots the results

# normal quantile plot
qqnorm(women$height, datax = TRUE)

#Shapiro-Wilkes test for normality
shapiro.test(women$height)

# Bartlett's test for equal variance
bartlett.test(height ~ grouping, data=df_from_file)


