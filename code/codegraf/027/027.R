# -------------
# Data that aren't normally distributed
# -------------

library("tidyr")
library("dplyr")

# Load data into a data frame
erg <- read.csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/red-blue-erg-data.csv")
# Tidy data to use grouping variables
erg_tidy <- pivot_longer(erg, 
                         cols = c("blue", "red"), 
                         names_to = "color",
                         values_to = "voltage")

# filter each color and test if normally distributed
red_tibble <- filter(erg_tidy, erg_tidy$color=="red")
hist(red_tibble$voltage)
qqnorm(red_tibble$voltage, datax = TRUE)
shapiro.test(red_tibble$voltage)

blue_tibble <- filter(erg_tidy, color=="blue")
hist(blue_tibble$voltage)
qqnorm(blue_tibble$voltage, datax = TRUE)
shapiro.test(blue_tibble$voltage)

# -------------
# Transforming data
# -------------

# Data that are skewed to the right can often be fixed with a log transformation
transformed_red <- mutate(red_tibble, log_col=log(voltage)) # note: natural log; ln()
hist(transformed_red$log_col)
qqnorm(transformed_red$log_col, datax = TRUE)
shapiro.test(transformed_red$log_col)

transformed_blue <- mutate(blue_tibble, log_col=log(voltage))
hist(transformed_blue$log_col)
qqnorm(transformed_blue$log_col, datax = TRUE)
shapiro.test(transformed_blue$log_col)

# -------------
# Fixing heterogeneity of variances
# -------------

# The same transformation that fixes skewed data may also fix heterogeneous variances

# Bartlett's test without transformation
erg_factor <- mutate(erg_tidy, color=factor(color))
bartlett.test(voltage ~ color, data=erg_tidy)

# Bartlett's test after transformation
transformed_factor <- transmute(erg_tidy, color=factor(color), voltage=log(voltage))
bartlett.test(voltage ~ color, data=transformed_factor)

# -------------
# Results after transformation
# -------------

# Run the t-test of means
t.test(voltage ~ color, data=transformed_factor, var.equal=TRUE)

# Back-transform reported mean values
values <- c(2.2405239, 0.7464018)
transformed_values <- exp(values) # e^values, i.e. inverse of ln()
transformed_values

# -------------
# Non-parametric alternative: Wilcoxon-Mann-Whitney (WMW) test
# -------------

# perform the test on untransformed data since non-parametric
wilcox.test(voltage ~ color, data=erg_factor)
# You can ignore the warning message about ties

# -------------
# Visualization
# -------------

plot(voltage ~ color, data=erg_factor)
plot(voltage ~ color, data=transformed_factor)

# prettier plot with ggplot
library(ggplot2)
# Comment out box plot or violin line for separate plots
ggplot(data = erg_factor, aes(x=color, y=voltage, color=color)) +
  geom_boxplot() +
  geom_violin(alpha = 0.3) # alpha controls transparency
