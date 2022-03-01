# --------------------------
# Vectors
# --------------------------

# create a vector of numbers
number_vector <- c(1, 3, 6, 10, 15)

# create a vector of character strings
animal <- c("frog", "spider", "worm", "bee")

# create sequences
number_range <- 3:9
count_down <- 10:0
go_negative <- 5:-3

# display properties of a vector
length(animal)
mode(animal)

# referencing parts of a vector
animal[3]
animal[2] <- "arachnid"
animal[2:4]

# single items are vectors
an_item <- "some character string"
length(an_item)
an_item[1]

# operations on vectors
sqrt(number_vector)
number_vector * 3

# two-vector operation
a <- c(10, 30, 100)
b <- c(5, 10, 20)
c <- a/b
c

# --------------------------
# Packages
# --------------------------

library(readr)
schools_tibble <- read_csv("https://raw.githubusercontent.com/HeardLibrary/digital-scholarship/master/data/gis/wg/Metro_Nashville_Schools.csv")
