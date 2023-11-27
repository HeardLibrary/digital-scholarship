# gallup_extractor.R - Extracts data from Gallup microdata files.
# (c) 2023 Vanderbilt University. This program is released under a GNU General Public License v3.0 http://www.gnu.org/licenses/gpl-3.0
# Author: Steve Baskauf
# Date: 2020-11-27

library(tidyverse)
library(haven) # Library to read Stata .dta files

# NOTE: one could probably use one of the three "wave" subsets rather than the whole giant file containing
# all of the data. That would require figuring out which wave correspondes to which hear. I think mostly
# they are just assigned consecutively with wave 1 = 2005 or 2006.
#file_path = "/Users/baskausj/Library/CloudStorage/Box-Box/VU Gallup Microdata/Tripp__worldPoll__08082023/Tripp__worldPoll__08082023.dta"
file_path = "/Users/baskausj/Downloads/gallup/Gallup_World_Poll_021723.dta"

stata_dataframe <- read_dta(file_path) # when trying to load full dataset, first time I got "Error: vector memory exhausted (limit reached?)"
# see https://stackoverflow.com/questions/51295402/r-on-macos-error-vector-memory-exhausted-limit-reached
# As suggested in the post, I edited the .Renviron file to a max size of 100Gb. After doing that, the file 
# did load, although it took over an hour. The memory use was 7.25 GB, which RStudio reported as 40% of Mac OS memory.
head(stata_dataframe, 10)
dim(stata_dataframe)

# Filter rows by Turkey
sub_frame <- filter(stata_dataframe, countrynew=="Turkey")
head(sub_frame)
dim(sub_frame)

# Save the filtered file in .dta format (not really necessary if also filtering by years)
write_dta(sub_frame, "/Users/baskausj/Downloads/turkey.dta")

# Filter for 2016 or 2019 or 2022
year_subframe <- filter(sub_frame, YEAR_CALENDAR=="2016" | YEAR_CALENDAR=="2019" | YEAR_CALENDAR=="2022")

# Save the filtered file in .dta format
write_dta(year_subframe, "/Users/baskausj/Downloads/turkey_years.dta")
