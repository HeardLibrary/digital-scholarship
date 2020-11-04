library(car)

# ------------------
# Analysis of variance (ANOVA)
# ------------------

ergDframe <- read.csv(file="https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/r/color-anova-example.csv")
model <- lm(response ~ color, data = ergDframe)  # fit a linear model to the data
resid <- residuals(model)
hist(resid)
shapiro.test(resid)

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

# more to come...
