library(car)

# ------------------
# One-factor analysis of variance (ANOVA)
# ------------------

ergDframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
model <- lm(response ~ color, data = ergDframe)  # fit a linear model to the data

# test residuals for normality
resid <- residuals(model)
hist(resid)
shapiro.test(resid)

# test for homogeneity of variances
plot(resid ~ ergDframe$color)
plot(model)

bartlett.test(response ~ color, data = ergDframe)

#library(car)
leveneTest(response ~ color, data=ergDframe, center=mean) # Levene's test
leveneTest(response ~ color, data=ergDframe) # Brown-Forsythe test

# perform log transformation
ergDframe$log <- log(ergDframe$response)

model_log <- lm(log ~ color, data = ergDframe)  # fit a linear model to the data
resid_log <- residuals(model_log)
hist(resid_log)
shapiro.test(resid_log)

plot(resid_log ~ ergDframe$color)
plot(model_log)

bartlett.test(log ~ color, data = ergDframe)

#library(car)
leveneTest(log ~ color, data=ergDframe, center=mean) # Levene's test
leveneTest(log ~ color, data=ergDframe) # Brown-Forsythe test
anova(model_log)  #run the ANOVA on the model

# Comparison of t-test to ANOVA with 2 levels of one factor
red_green <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/red-green-anova-example.csv")
red_green$log <- log(red_green$response)
rg_model <- lm(log ~ color, data = red_green)
anova(rg_model)
t.test(log ~ color, data = red_green, var.equal = TRUE)

# Tukey-Kramer post-hoc tests
av <- aov(model_log) # must create an ANOVA object for TukeyHSD
summary(av)
TukeyHSD(av)

# Kruskal-Wallis test (non-parametric)
kruskal.test(response ~ color, data=ergDframe)

# ------------------
# Two-factor analysis of variance (ANOVA)
# ------------------

# Two factor ANOVA with both effects fixed
soap_dataframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/fake-soap-experiment.csv")
anova_object <- aov(counts ~ soap * triclosan, data = soap_dataframe)

# Test assumption of normality
res <- residuals(anova_object)
hist(res)
shapiro.test(res)

# Examine distribution of residuals and normal quantile plot
plot(anova_object)

#library(car)
leveneTest(counts ~ soap * triclosan, data = soap_dataframe, center=mean) # Levene's test

# generate the ANOVA table
summary(anova_object)

# Mixed model ANOVA (ANOVA with blocking)
# the lme4 package generates mixed models
library(lmerTest) # variant of lme4 package that gives P values

erg_dataframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
# generate a mixed model using lmer
mixed_model <- lmer(response ~ color + (1 | block), data = erg_dataframe)

# test assumptions
res <- residuals(mixed_model)
hist(res)
shapiro.test(res)

anova(mixed_model)
summary(mixed_model)

# Comparison of paired t-test and ANOVA with blocking
erg_dataframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/red-green-anova-example.csv")
t.test(response ~ color, data = erg_dataframe, paired = TRUE)

mixed_model <- lmer(response ~ color + (1 | block), data = erg_dataframe)
anova(mixed_model)









