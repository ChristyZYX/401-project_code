
# Load packages -----------------------------------------------------------

pacman::p_load(tidyverse,rvest) # new pkg for data validation reporting


# read file wages by industry --------------------------------------------

wages <-  read_csv('/Users/zhang/OneDrive/Desktop/ISA 401/Final project/Wages by industry.csv') 


# transform wages table into the long data ---------------------------------------------

wages <-  pivot_longer(wages, c(
                      '2010:Q1', '2010:Q2', '2010:Q3','2010:Q4',
                      '2011:Q1', '2011:Q2', '2011:Q3','2011:Q4',
                      '2012:Q1', '2012:Q2', '2012:Q3','2012:Q4',
                      '2013:Q1', '2013:Q2', '2013:Q3','2013:Q4',
                      '2014:Q1', '2014:Q2', '2014:Q3','2014:Q4',
                      '2015:Q1', '2015:Q2', '2015:Q3','2015:Q4',
                      '2016:Q1', '2016:Q2', '2016:Q3','2016:Q4',
                      '2017:Q1', '2017:Q2', '2017:Q3','2017:Q4',
                      '2018:Q1', '2018:Q2', '2018:Q3','2018:Q4',
                      '2019:Q1', '2019:Q2', '2019:Q3','2019:Q4',
                      '2020:Q1', '2020:Q2', '2020:Q3','2020:Q4',
                      '2021:Q1', '2021:Q2', '2021:Q3','2021:Q4',
                      ), names_to = "year", values_to = "values")
str(wages) # check the data type for each variables

# targeting clean data ----------------------------------------------------
library("dplyr")
wages_2 <- wages %>%          
  mutate(Year_Quarter = year)
wages_2    
wages.clean_1 <- subset(wages_2,select =-c(GeoFips, LineCode)) # drop meaningless columns

wages.clean <- separate(wages.clean_1, year, into = c("Year", "Quarter"), sep = ':')
wages.clean

# Create a percentage change column -----------------------------------------------------

options(scipen = 999)
wages.clean = wages.clean %>% 
  mutate(pct_chng = 100*(values - lag(values)) / lag(values) )

write.csv(wages.clean,"/Users/zhang/OneDrive/Desktop/ISA 401/Final project/Wages_clean.csv", row.names = FALSE)
