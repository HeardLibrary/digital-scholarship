---
permalink: /script/r/nlsaah/
title: National Longitudinal Study of Adolescent to Adult Health
breadcrumb: NLSAAH
---

# National Longitudinal Study of Adolescent to Adult Health, 1994-2008

**Citation:** Harris, Kathleen Mullan, and Udry, J. Richard. National Longitudinal Study of Adolescent to Adult Health (Add Health), 1994-2008 \[Public Use\]. Carolina Population Center, University of North Carolina-Chapel Hill \[distributor\], Inter-university Consortium for Political and Social Research \[distributor\], 2018-08-06. <https://doi.org/10.3886/ICPSR21600.v21>

**Project website:** <https://www.cpc.unc.edu/projects/addhealth>

The data from this study are published in the *Inter-university Consortium for Political and Social Research (ICPSR)* [data archive](https://www.icpsr.umich.edu/icpsrweb/).  

# Accessing the data

## Sign up for an ICPSR account

Go to the [login page](https://www.icpsr.umich.edu/rpxlogin) and click on the `Create Account` button.  Follow the instructions to establish your username (email) and password.

## Download the data

1. Go to the [study data page](https://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/21600/datadocumentation) for the study.

2. We will start by looking at the `DS1 Wave 1: In-Home Questionnaire, Public Use Sample` dataset. To download it separately, click the Download button to the right of its heading and select `Delimited`. 

3. After the download is completed, go to your download directory and unzip the archive. The file we want is in the `ICPSR_21800` folder, then in the `DS0001` folder, called `21600-0001-Data.tsv`.  If necessary move the file to somewhere where you can easily navigate to it.

# Loading the data into RStudio

```
# read in tab separated value file
nls_ds1 <- read.csv(file.choose(), header = TRUE, sep = "\t")

# display the data in the column labeled "BIO_SEX"
nls_ds1$BIO_SEX

# convert the coded data into factors values of male and female
sex <- factor(nls_ds1$BIO_SEX,
              levels = c(1, 2),
              labels = c("male", "female"))

# summarize the data
table(sex)
barplot(table(sex))
```



----
Revised 2020-01-14
