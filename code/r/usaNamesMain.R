### Color Palettes: https://www.datanovia.com/en/blog/top-r-color-palettes-to-know-for-great-data-visualization/
### ggplot2 lesson: https://ramnathv.github.io/pycon2014-r/visualize/ggplot2.html 

###################################################
#                    Libraries                    #
###################################################
# R is an incredibly powerful data analysis tool in part because of the incredibly 
# diverse array of plotting packages available for this language.

## Libraries
# **Pacman** is an extremely useful package that allows you to run **install.packages**
# and **library** at the same time, for multiple packages. So, the first thing that we will 
# do is install and load **pacman**.
library(pacman)

# We can then used pacman to load the other packages we need for this project. These packages include,
# * **tidyverse**: this package contains many data editing and plotting tools, including ggplot2
# * **scales**: allows users to manipulate the plot axes more easily
# * **RColorBrewer**: allows you to select from a number of color palettes for plotting within ggplot2
# * **geofacet**: create plots based on a geographical location (will make more sense after some examples)
# * **ggpubr**: easily export ggplot results into PDF, PNG, and other picture formats
# * **ggalt**: some extra goodies to use in ggplot
# * **ggplotAssist**: a plot-&-click RStudio addin that simplifies the use of ggplot
pacman::p_load(tidyverse,scales,RColorBrewer,geofacet,ggpubr,ggalt,ggplotAssist)

###################################################
#     National name data from 1918 to 2018        #
###################################################
# HOW TO DOWNLOAD TODAYS DATA
# Download data from https://github.com/jborycz/USAnames/blob/master/data.zip 

# You can upload data to R by using **read.csv**. I like to keep a pristine version of the original data, 
# so I save it under a different name for editing.
national_name_data_original <- read.csv("data/nationalNames/nationalNames.csv")
national_name_data <- national_name_data_original 

# Let's take a look at these data with the **head** function.
head(national_name_data)

# By using pipes (**%>%**) from the **tidyverse** package we can add useful columns to the dataset. Here we will use, 
# * **group_by** to organize the data,  
# * **mutate** and **row_number** to create a new column called **rank** that ranks the most popular names in each year for males and females,  
# * **substr** to create a column that contains the first letter of each name,  
# * **str_length** to create a column containing the number of letters in each name, and  
# * **sum** to add values in a specific row
# * **dense_rank** ranks ties with same number
# Reset row index
rownames(national_name_data) <- seq(length=nrow(national_name_data))
# Add First letter column, string length column, and limit to top names
national_name_data <- national_name_data %>% group_by(sex, year) %>%                                    # load in data and group
  mutate(rank = row_number(), firstLetter = substr(name, 1, 1), length = str_length(name),              # add new rows to dataframe
         total_people = sum(number), total_names = n(),percent_by_year = 100*(number/total_people)) %>% 
  group_by(name, sex) %>% mutate(allYear_total=sum(number)) %>% arrange(desc(allYear_total),sex) %>%    # reorder to calculate name popularity for all 100 years
  group_by(sex) %>% mutate(allYear_rank = dense_rank(desc(allYear_total)))

# Let's take a look at the data AGAIN with the **head** function
head(national_name_data)

# Let's identify the class of each vector with **str** and **lapply**
str(national_name_data)
lapply(national_name_data,class)

###################################################
#         ggplot from tidyverse package           #
###################################################
## ggplot2
# **ggplot2** is a suite of functions that makes is easier to create complex plots with datasets in R.

### Basic set-up for ggplot2
# ggplot2 allows you to add or edit features in a plot by using the **+** sign. The fundamental function
# is **ggplot2**, which is where you will specify which data you are going to use and the **aesthetics** of
# the plot that you will create with the **aes()** function. Within **aes()** you can specify which data will
# be on the x and y axes and which colors you want the plot to contain.

### Using subset within ggplot2
# Let's narrow our focus down to a smaller subset of names. We can do so with the **subset** function within
# ggplot2. Using **subset** is a great way to leave your data pristine while still creating useful plots. Here
# we will limit the plot to names that were in the top 3 in at least 1 year from 1918 to 2018.

# You can specify aesthetics globally in **ggplot**
linePeople <- ggplot(national_name_data,mapping=aes(x=year, y=total_people,color=sex)) +
  geom_line()
ggexport(plotlist = list(linePeople), filename = "plots/linePeople.png", width = 800, height = 600)

lineNames <- ggplot(national_name_data,mapping=aes(x=year, y=total_names,color=sex)) +
  geom_line()
ggexport(plotlist = list(lineNames), filename = "plots/lineNames.png", width = 800, height = 600)

# Or within each individual geometry. You can combine plots using this method.
columnLine <- ggplot() +
  geom_col(subset(national_name_data, sex=="F"),
           mapping=aes(x=year, y=number, fill=firstLetter)) +
  geom_line(subset(national_name_data, sex=="M"),
           mapping=aes(x=year, y=total_people), color="black")
ggexport(plotlist = list(columnLine), filename = "plots/columnLine.png", width = 800, height = 600)

###################################################
#                  Example plots                  #
###################################################
# We can make plot look nice by adding some **coordinates** and **themes**
column <- ggplot() +
  geom_col(subset(national_name_data, sex=="F" & allYear_rank <=10),
           mapping=aes(x=year, y=number, fill=name)) +
  scale_x_continuous() +
  scale_y_continuous(labels = comma) +
  labs(title="Year vs Number", y="Number", x="Year", caption="data.gov",fill="Name") +
  theme(legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=45))
ggexport(plotlist = list(column), filename = "plots/column.png", width = 800, height = 600)

# ggplot2 has a variety of plots. We can only look at a few in this lesson, but there are many guides online:
# The R Graph Gallery: https://www.r-graph-gallery.com/ 
# Top 50 ggplot2 visualization: http://r-statistics.co/Top50-Ggplot2-Visualizations-MasterList-R-Code.html 
# How to make any plot in ggplot2: http://r-statistics.co/ggplot2-Tutorial-With-R.html 
# ggplot2 cheatsheet: https://rstudio.com/wp-content/uploads/2015/03/ggplot2-cheatsheet.pdf 
# Data carpenty lesson for social scientists: https://datacarpentry.org/r-socialsci/04-ggplot2/index.html 

# **geom_area** You can pipe into ggplot
area <- subset(national_name_data, sex=="F" & allYear_rank <10) %>% 
  ggplot(mapping=aes(x=year, y=number, fill=name)) + 
  geom_area(alpha=0.6 , size=1, color="black",position = "stack") +
  scale_x_continuous(breaks = seq(1920,2020,10)) +
  scale_y_continuous(labels = comma) +
  labs(title="Year vs Number", y="Number", x="Year", caption="data.gov",fill="Name") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=45))
ggexport(plotlist = list(area), filename = "plots/area.png", width = 800, height = 600)

# **geom_area** with names reordered by rank
areaReorder <- subset(national_name_data, sex=="F" & allYear_rank <=10) %>% 
  mutate(name = fct_reorder(as.factor(name), allYear_rank)) %>%
ggplot(mapping=aes(x=year, y=number, fill=name)) + 
  geom_area(alpha=0.6 , size=1, color="black",position = "stack") +
  scale_x_continuous(breaks = seq(1920,2020,10)) +
  scale_y_continuous(labels = comma) +
  labs(title="Year vs Number", y="Number", x="Year", caption="data.gov",fill="Name") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=45))
ggexport(plotlist = list(areaReorder), filename = "plots/areaReorder.png", width = 800, height = 600)

# **geom_violin** 
violin <- ggplot(national_name_data,mapping=aes(x=sex, y=length)) + 
  geom_violin(scale = "width") +
  scale_x_discrete() +
  scale_y_continuous(breaks = seq(1,12,1)) +
  labs(title="Name Length by Sex", y="Length", x="Sex", caption="data.gov") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=0))
ggexport(plotlist = list(violin), filename = "plots/violin.png", width = 800, height = 600)

# **facet_wrap** with **geom_violin**
violinFacet <- ggplot(subset(national_name_data,year %in% seq(1918,2018,10)),mapping=aes(x=sex, y=length)) + 
  geom_violin(scale = "width") +
  facet_wrap(~ year, nrow = 6) +
  scale_x_discrete() +
  scale_y_continuous(breaks = seq(1,12,2)) +
  labs(title="Name Length by Sex", y="Length", x="Sex", caption="data.gov") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=0))
ggexport(plotlist = list(violinFacet), filename = "plots/violinFacet.png", width = 800, height = 1000)

# **facet_wrap** with **geom_boxplot**
boxplotFacet <- ggplot(subset(national_name_data,year %in% seq(1918,2018,10)),
                       mapping=aes(x=firstLetter, y=length, color=firstLetter)) + 
  geom_boxplot() +
  facet_wrap(~ year, nrow = 6) +
  scale_x_discrete() +
  scale_y_continuous(breaks = seq(1,12,2)) +
  labs(title="Name Length vs First Letter", y="Length", x="First Letter", caption="data.gov") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=0))
ggexport(plotlist = list(boxplotFacet), filename = "plots/boxplotFacet.png", width = 800, height = 1000)

# **geom_histogram()**
histogram <- ggplot() + 
  geom_histogram(subset(national_name_data, sex=="F"),mapping=aes(length,fill="F"),binwidth = 1) +
  geom_histogram(subset(national_name_data, sex=="M"),mapping=aes(length,fill="M"),binwidth = 1) +
  scale_x_continuous() +
  scale_y_continuous(label=comma) +
  labs(title="Histogram of Name Lengths by Sex", y="Count", x="Length", caption="data.gov",fill="Sex") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=0))
ggexport(plotlist = list(histogram), filename = "plots/histogram.png", width = 800, height = 1000)

# **geom_histogram() and facet_grid()**
histogramGrid <- ggplot() + 
  geom_histogram(subset(national_name_data),mapping=aes(length,fill=sex),binwidth = 1) +
  facet_grid(. ~ sex) +
  scale_x_continuous() +
  scale_y_continuous(label=comma) +
  labs(title="Histogram of Name Lengths by Sex", y="Count", x="Length", caption="data.gov",fill="Sex") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=0))
ggexport(plotlist = list(histogramGrid), filename = "plots/histogramGrid.png", width = 800, height = 1000)

# **geom_point** and **geom_smooth** and **geom_encircle**
point <- ggplot(subset(national_name_data,allYear_rank <=100 & firstLetter =="J" & sex=="M"),
                mapping=aes(x=year,y=number,color=name),size=3) + 
  geom_point(show.legend = FALSE) +
  geom_smooth(method=loess,linetype="dashed",span = 0.1) +
  geom_encircle(aes(x=year,y=number,color=name),
                data=subset(national_name_data,
                            allYear_rank <=100 & firstLetter =="J" & sex=="M" & number >= 75000),  
                color="red", 
                size=2, 
                expand=0.08) +
  scale_x_continuous(breaks = seq(1920,2020,20)) +
  scale_y_continuous(label=comma) +
#  coord_cartesian(xlim=c(1980,2020),ylim=c(-100,50000)) +  # Zoom into region of plot
  labs(title="Point plot", y="Count", x="Year", caption="data.gov",color="Name") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=18),
        legend.text=element_text(size=12),
        axis.text.x = element_text(face="bold", color="black",size=12, angle=0),
        axis.text.y = element_text(face="bold", color="black",size=12, angle=0))
ggexport(plotlist = list(point), filename = "plots/point.png", width = 800, height = 1000)

###################################################
#         Example plots: State Level Data         #
###################################################
# Load in state name data
state_name_data_original <- read.csv("data/namesByState/stateNames.csv")
state_name_data <- state_name_data_original 

# Limit state data to 100 years
state_name_data <- subset(state_name_data, year >= 1918)
# Reset row index
rownames(state_name_data) <- seq(length=nrow(state_name_data))
# Only top 10 names for each state in each year
state_name_data <- state_name_data %>% group_by(state,sex, year) %>%
  mutate(rank = row_number(), firstLetter = substr(name, 1, 1), length = str_length(name), 
         total_names = n(),total_people = sum(number), total_names = n(), 
         percent_by_year = 100*(number/total_people)) %>%
  group_by(name, sex) %>% mutate(allYear_total=sum(number)) %>% arrange(desc(allYear_total),sex) %>% 
  group_by(sex) %>% mutate(allYear_rank = dense_rank(desc(allYear_total)))

# **geom_area** and **facet_geo** plot
areaFacetGeo <- ggplot(subset(state_name_data, sex=="F" & allYear_rank <=10),
               mapping=aes(x=year, y=number, fill=name)) + 
  geom_area(alpha=0.6 , size=1, color="black",position = "stack") +
  facet_geo(~ state) +
  scale_x_continuous(labels = seq(1918,2018,50),breaks = seq(1918,2018,50)) +
  scale_y_continuous(labels = comma) +
  labs(title="Year vs Number of People", y="Number of People", x="Year", caption="data.gov",fill="Name") +
  theme(plot.title = element_text(face="bold",size=16),
        legend.position = "bottom",
        legend.title = element_text(face="bold",size=14),
        legend.text=element_text(face="bold",size=12),
        axis.text.x = element_text(color="black",size=10, angle=-45),
        axis.text.y = element_text(color="black",size=10, angle=-60))
ggexport(plotlist = list(areaFacetGeo), filename = "plots/areaFacetGeo.png", width = 1200, height = 800)

###################################################
#                    Exercises                    #
###################################################

# 1) Try generating a geom_text plot of the national names data.

# 2) Generate a plot of the popularity of your name or the name of a 
# friend from 1918 to 2018.

# 3) Generate a facet_geo plot of a name of your choice. In which state 
# was this name the most popular? 

# 4) Try to generate one unique plot with the ggplot template we have 
# been using.
