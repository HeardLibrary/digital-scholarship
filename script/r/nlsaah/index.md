---
permalink: /script/r/nlsaah/
title: National Longitudinal Study of Adolescent to Adult Health
breadcrumb: NLSAAH
---

# National Longitudinal Study of Adolescent to Adult Health, 1994-2008

**Citation:** Harris, Kathleen Mullan, and Udry, J. Richard. National Longitudinal Study of Adolescent to Adult Health (Add Health), 1994-2008 \[Public Use\]. Carolina Population Center, University of North Carolina-Chapel Hill \[distributor\], Inter-university Consortium for Political and Social Research \[distributor\], 2018-08-06. <https://doi.org/10.3886/ICPSR21600.v21>

**Project website:** <https://www.cpc.unc.edu/projects/addhealth>

The data from this study are published in the *Inter-university Consortium for Political and Social Research (ICPSR)* [data archive](https://www.icpsr.umich.edu/icpsrweb/).  

# First session: Accessing the data

## Sign up for an ICPSR account

Go to the [login page](https://www.icpsr.umich.edu/rpxlogin) and click on the `Create Account` button.  Follow the instructions to establish your username (email) and password.

## Download the data

1. Go to the [study data page](https://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/21600/datadocumentation) for the study.

2. We will be looking at the `DS1 Wave 1: In-Home Questionnaire, Public Use Sample` and `DS22 Wave IV: In-Home Questionnaire, Public Use Sample` datasets. To download each one, click the Download button to the right of its heading and select `Delimited`. 

3. After the download is completed, go to your download directory and unzip the archive. The files we want are in the `ICPSR_21800` folder, then in the `DS0001` and `DS0022` folders, called `21600-0001-Data.tsv` and `21600-0022-Data.tsv` respectively.  If necessary move the files to somewhere where you can easily navigate to it. Optimally, it will be a location that you know how to write a path for in the script.

# Loading the data into RStudio

The form of the data that we've downloaded is `tab separated values` (TSV).  TSV and variants with other separators, such as `comma separated values (CSV)` are very common tabular data storage and transfer formats.  (See [this information](https://heardlibrary.github.io/digital-scholarship/script/python/inout/#csv-files) for more information about CSV files and how you can look at them.)

The R `read.csv` function can be used to read fielded text files with delimeters other than comma if the separator is indicated.  The tab character that's used as a delimeter is indicated as "\t".  

```
nls_ds1 <- read.csv(file.choose(), header = TRUE, sep = "\t")
```

The `read.csv()` function loads the data into a regular data frame. The `readr` library (part of the `tidyverse` library) contains two functions that read the data into tibbles rather than generic data frames. They are `read_csv()` (with an underscore rather than a dot) for comma delineated files and `read_tsv()` for tab delineated files.

Here's a script that reads in the files and does a bit of manipulation. You can try running it to make sure you've successfully loaded the data.

```
library(readr) # for reading tibbles

# read in tab separated value file
nls_ds1 <- read_tsv(file.choose())

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

# Wrangling the data

The datasets are really big and might actually cause your computer to run out of memory if you have too many applications running. So one task we want to accomplish is to pull a subset of data out of of the origial datasets.

A second issue is that the data include various forms of missing data ("don't know", "won't say", "not applicable", etc.). We may not want such data included in the analysis and therefore need to replace those values with missing data (NA) values.

The third item is that we'd like to have two new variables to use in future analyses: a calculation of the *body mass index* (BMI) and a new index called "maternal closeness" that has a value of 1 if the five maternal closeness indications all have values of 1, and a value of 0 if they are a number other than 1. Missing values should continue to be missing values.

The template assignment is [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/r/wrangle-nls.R). Answers are [here](https://github.com/HeardLibrary/digital-scholarship/blob/master/code/r/wrangle-nls-answers.R).

----
Revised 2020-02-18
