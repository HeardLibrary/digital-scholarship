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

The form of the data that we've downloaded is `tab separated values` (TSV).  TSV and variants with other separators, such as `comma separated values (CSV)` are very common tabular data storage and transfer formats.  (See [this information](https://heardlibrary.github.io/digital-scholarship/script/python/inout/#csv-files) for more information about CSV files and how you can look at them.)

The R `read.csv` function can be used to read fielded text files with delimeters other than comma if the separator is indicated.  The tab character that's used as a delimeter is indicated as "\t".  The rest of this script uses syntax that we haven't discussed yet, but you can try running it to explore the data a little bit.

There is an example [here](https://heardlibrary.github.io/digital-scholarship/script/r/structures/#data-frames) showing how you can examine the data of a loaded data frame (`nls_ds1`) in our example.  Take a look at the data frame to see how the data are organized.

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

## For next time

You should go ahead and download the entire data set, unzip it, and put it somewhere on your computer where you can locate it again.  Go to the [Data and documentation page](https://www.icpsr.umich.edu/icpsrweb/ICPSR/studies/21600/datadocumentation) and click on the big `Download` button above the list of individual datasets.  Select `Delimited` as the format to download.

----
Revised 2020-01-14
