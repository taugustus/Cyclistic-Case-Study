# Install packages into RStudio

install.packages("tidyverse")
install.packages("dplyr")
install.packages("tidyr")
install.packages("readr")
install.packages("stringr")
install.packages("purrr")
install.packages("janitor")
install.packages("skimr")
install.packages("data.table")
install.packages("lubridate")
install.packages("tibbletime")

# Upload installed packages into system

library(tidyverse)
library(dplyr)
library(readr)
library(janitor)
library(stringr)
library(purrr)
library(skimr)
library(lubridate)
library(data.table)
library(lubridate)
library(tibbletime)
library(hms)
library(tidyr)

# Upload v4 .csv files into data frames

setwd("~/Documents/Google Data Analytics Certificate Course/Case Study/Case Study Data/Divvy_Trips_Data/Divvy_Trip_Data_csv")

divvy_trips_05_2024_v4 <- read_csv("2024_05_divvy_tripdata_v4.csv") # 05-2024 Divvy trips


# Create duplicate version of divvy_trips_05_2024_v4 to convert date & time formats for time calculations

divvy_trips_05_2024_v5 <- divvy_trips_05_2024_v4 # create new divvy_trips_05_2024_v5 data frame

divvy_trips_05_2024_v5$ride_start_date <- as.Date(divvy_trips_05_2024_v5$ride_start_date, format = "%m/%d/%y") # convert ride start date column to date type
divvy_trips_05_2024_v5$ride_end_date <- as.Date(divvy_trips_05_2024_v5$ride_end_date, format = "%m/%d/%y") # convert ride end date column to date type
divvy_trips_05_2024_v5$start_day <- weekdays(divvy_trips_05_2024_v5$ride_start_date) # convert to weekday name
divvy_trips_05_2024_v5$ride_month_v2 <- lubridate::month(divvy_trips_05_2024_v5$ride_start_date, label = TRUE, abbr = FALSE) # convert to month name

divvy_trips_05_2024_v5$ride_start_time <- as.POSIXlt(divvy_trips_05_2024_v5$ride_start_time, format="%H:%M%S") # convert ride start time column to time type
divvy_trips_05_2024_v5$hour_start <- format(divvy_trips_05_2024_v5$ride_start_time, "%H") # create new column to extract hour from ride start time column
divvy_trips_05_2024_v5$hour_start_v2 <- format(divvy_trips_05_2024_v5$ride_start_time, "%I %p") # create new column to extract hour from ride start time column and convert to AM/PM string

divvy_trips_05_2024_v5 <- separate(divvy_trips_05_2024_v5, col = ride_start_time,
           into = c("err_date", "ride_start_time"),
           sep = 10) # separates erroneous timestamp into error date and correct time
divvy_trips_05_2024_v5$err_date <- NULL # remove error date column

View(divvy_trips_05_2024_v5)
glimpse(divvy_trips_05_2024_v5)


# Calculate aggregated values for 05-2024

# Total Ride Count
divvy_trips_05_2024_v4 %>% count(member_casual) # total rides for 05-2024 per Member/Casual

# Average Ride Minutes
mean(divvy_trips_05_2024_v4$ride_mins) # average ride minutes per trip for 05-2024
divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  summarise(avg_ride = mean(ride_mins)) # average ride mins per ride for 05-2024 per Member/Casual

# Min Ride Minutes
min(divvy_trips_05_2024_v4$ride_mins) # minimum ride trip minutes within 05-2024
divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  summarise(min_ride = min(ride_mins)) # minimum ride trip minutes within 05-2024 by Member/Casual

# Max Ride Minutes
max(divvy_trips_05_2024_v4$ride_mins) # maximum ride trip minutes within 05-2024
divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  summarise(max_ride = max(ride_mins)) # maximum ride trip minutes within 05-2024 by Member/Casual

# Ride Count by Day of Week
divvy_trips_05_2024_v5 %>%
  count(start_day) # total rides for 05-2024 broken down into day of week
divvy_trips_05_2024_v5 %>%
  group_by(member_casual) %>% 
  count(start_day) # total rides for 05-2024 broken down into day of week per Member/Casual

# Ride Count by AM/PM
divvy_trips_05_2024_v4 %>%
  count(ride_time_of_day) # total rides broken down into time of day
divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  count(ride_time_of_day) # total rides broken down into time of day per Member/Casual
divvy_trips_05_2024_v5 %>%
  group_by(ride_month_v2) %>%
  count(ride_time_of_day) # total rides broken down into time of day per month
divvy_trips_05_2024_v5 %>%
  group_by(ride_month_v2, member_casual) %>%
  count(ride_time_of_day) # total rides broken down into time of day per month & Member/Casual

# Ride Count by Start Hour of Day
dt_start_time <- divvy_trips_05_2024_v5 %>%
  count(hour_start_v2) # total rides by hour of day for 05-2024
dt_start_time <- divvy_trips_05_2024_v5 %>%
  group_by(member_casual) %>% 
  count(hour_start_v2) # total rides for 05-2024 by hour of day per Member/Casual
dt_start_time_member <- divvy_trips_05_2024_v5 %>%
  group_by(member_casual) %>%
  filter(member_casual == "member") %>% 
  count(hour_start_v2) # total rides for 05-2024 by hour of day per Member
dt_start_time_casual <- divvy_trips_05_2024_v5 %>%
  group_by(member_casual) %>%
  filter(member_casual == "casual") %>% 
  count(hour_start_v2) # total rides for 05-2024 by hour of day per Casual

# Ride Count by Start Hour of Day (by Day of Week)
dt_start_time_day <- divvy_trips_05_2024_v5 %>%
  group_by(start_day) %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 05-2024
dt_start_time_day <- divvy_trips_05_2024_v5 %>%
  group_by(start_day, member_casual) %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 05-2024 per Member/Casual
dt_start_time_day_member <- divvy_trips_05_2024_v5 %>%
  group_by(start_day, member_casual) %>% 
  filter(member_casual == "member") %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 05-2024 per Member
dt_start_time_day_casual <- divvy_trips_05_2024_v5 %>%
  group_by(start_day, member_casual) %>% 
  filter(member_casual == "casual") %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 05-2024 per Casual

# Ride Count by Ride Type
divvy_trips_05_2024_v4 %>% count(rideable_type) # total rides for 05-2024 per ride type
divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  count(rideable_type) # total rides for 05-2024 per ride type by Member/Casual
divvy_trips_05_2024_v5 %>%
  group_by(ride_month_v2, member_casual) %>% 
  count(rideable_type) # total rides for 05-2024 per ride type by month & Member/Casual
divvy_trips_05_2024_v5 %>%
  group_by(start_day, hour_start_v2, member_casual) %>% 
  count(rideable_type) # total rides for 05-2024 per ride type by day of week, time of day, & Member/Casual

# Ride Count by Start Station
dt_start_stations <- divvy_trips_05_2024_v4 %>%
  count(start_station_name) # total rides for 05-2024 by start station
dt_start_stations <- divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  count(start_station_name) # total rides for 05-2024 by start station per Member/Casual
dt_start_stations_member <- divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  filter(member_casual == "member") %>% 
  count(start_station_name) # total rides for 05-2024 by start station per Member
dt_start_stations_casual <- divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  filter(member_casual == "casual") %>% 
  count(start_station_name) # total rides for 05-2024 by start station per Casual

# Ride Count by End Station
dt_end_stations <- divvy_trips_05_2024_v4 %>%
  count(end_station_name) # total rides for 05-2024 by end station
dt_end_stations <- divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  count(end_station_name) # total rides for 05-2024 by end station per Member/Casual
dt_end_stations_member <- divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  filter(member_casual == "member") %>% 
  count(end_station_name) # total rides for 05-2024 by end station per Member
dt_end_stations_casual <- divvy_trips_05_2024_v4 %>%
  group_by(member_casual) %>% 
  filter(member_casual == "casual") %>% 
  count(end_station_name) # total rides for 05-2024 by end station per Casual

# Most Popular Start Station by Start Time

dt_start_station_max <- divvy_trips_05_2024_v5 %>%
  group_by(start_station_name, hour_start_v2) %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max ride by hour for 05-2024 per station

dt_start_station_max_v2 <- divvy_trips_05_2024_v5 %>%
  group_by(start_station_name, member_casual, hour_start_v2) %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max ride by hour for 05-2024 per station and Member/Casual

dt_start_station_max_member <- divvy_trips_05_2024_v5 %>%
  group_by(start_station_name, member_casual, hour_start_v2) %>% 
  filter(member_casual == "member") %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max Member rides by hour for 05-2024 per station

dt_start_station_max_casual <- divvy_trips_05_2024_v5 %>%
  group_by(start_station_name, member_casual, hour_start_v2) %>% 
  filter(member_casual == "casual") %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max Casual rides by hour for 05-2024 per station
