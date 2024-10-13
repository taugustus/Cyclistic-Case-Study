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
install.packages("writexl")
install.packages("openxlsx")

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
library(writexl)
library(openxlsx)


# Upload v4 .csv files into data frames

setwd("~/Documents/Google Data Analytics Certificate Course/Case Study/Case Study Data/Divvy_Trips_Data/Divvy_Trip_Data_csv")

divvy_trips_09_2023_v4 <- read_csv("2023_09_divvy_tripdata_v4.csv") # 09-2023 Divvy trips
divvy_trips_10_2023_v4 <- read_csv("2023_10_divvy_tripdata_v4.csv") # 10-2023 Divvy trips
divvy_trips_11_2023_v4 <- read_csv("2023_11_divvy_tripdata_v4.csv") # 11-2023 Divvy trips
divvy_trips_12_2023_v4 <- read_csv("2023_12_divvy_tripdata_v4.csv") # 12-2023 Divvy trips
divvy_trips_01_2024_v4 <- read_csv("2024_01_divvy_tripdata_v4.csv") # 01-2024 Divvy trips
divvy_trips_02_2024_v4 <- read_csv("2024_02_divvy_tripdata_v4.csv") # 02-2024 Divvy trips
divvy_trips_03_2024_v4 <- read_csv("2024_03_divvy_tripdata_v4.csv") # 03-2024 Divvy trips
divvy_trips_04_2024_v4 <- read_csv("2024_04_divvy_tripdata_v4.csv") # 04-2024 Divvy trips
divvy_trips_05_2024_v4 <- read_csv("2024_05_divvy_tripdata_v4.csv") # 05-2024 Divvy trips
divvy_trips_06_2024_v4 <- read_csv("2024_06_divvy_tripdata_v4.csv") # 06-2024 Divvy trips
divvy_trips_07_2024_v4 <- read_csv("2024_07_divvy_tripdata_v4.csv") # 07-2024 Divvy trips
divvy_trips_08_2024_v4 <- read_csv("2024_08_divvy_tripdata_v4.csv") # 08-2024 Divvy trips


# Consolidate all 12 trip datasets into a single data frame for aggregated calculations for 12-month period

dt_year <- rbind(divvy_trips_09_2023_v4, divvy_trips_10_2023_v4, divvy_trips_11_2023_v4, divvy_trips_12_2023_v4, divvy_trips_01_2024_v4, divvy_trips_02_2024_v4, divvy_trips_03_2024_v4, divvy_trips_04_2024_v4, divvy_trips_05_2024_v4, divvy_trips_06_2024_v4, divvy_trips_07_2024_v4, divvy_trips_08_2024_v4)

View(dt_year)
glimpse(dt_year)

# Create duplicate version of dt_year to convert date & time formats for time calculations

dt_year_v2 <- dt_year # create new dt_year_v2 data frame

dt_year_v2$ride_start_date <- as.Date(dt_year_v2$ride_start_date, format = "%m/%d/%y") # convert ride start date column to date type
dt_year_v2$ride_end_date <- as.Date(dt_year_v2$ride_end_date, format = "%m/%d/%y") # convert ride end date column to date type
dt_year_v2$start_day <- weekdays(dt_year_v2$ride_start_date) # convert to weekday name
dt_year_v2$ride_month_v2 <- lubridate::month(dt_year_v2$ride_start_date, label = TRUE, abbr = FALSE) # convert to month name

dt_year_v2$ride_start_time <- as.POSIXlt(dt_year_v2$ride_start_time, format="%H:%M%S") # convert ride start time column to time type
dt_year_v2$hour_start <- format(dt_year_v2$ride_start_time, "%H") # create new column to extract hour from ride start time column
dt_year_v2$hour_start_v2 <- format(dt_year_v2$ride_start_time, "%I %p") # create new column to extract hour from ride start time column and convert to AM/PM string

dt_year_v2 <- separate(dt_year_v2, col = ride_start_time,
           into = c("err_date", "ride_start_time"),
           sep = 10) # separates erroneous timestamp into error date and correct time
dt_year_v2$err_date <- NULL # remove error date column

View(dt_year_v2)
glimpse(dt_year_v2)

write.csv(dt_year_v2, file = "Aggregate_2023_09_2024_08_divvy_tripdata.csv", row.names = FALSE) # Aggregate 09-2023 to 08-2024 Divvy trips

# Optional data frame for print

dt_year_v3 <- dt_year_v2 # create new dt_year_v3 data frame

dt_year_v3$started_at <- NULL # remove started at column
dt_year_v3$ended_at <- NULL # remove ended at column
dt_year_v3$start_location <- NULL # remove start location column
dt_year_v3$end_location <- NULL # remove end location column
dt_year_v3$start_station_id <- NULL # remove started station id column
dt_year_v3$end_station_id <- NULL # remove end station id column
dt_year_v3$ride_month <- NULL # remove ride month column
dt_year_v3$day_of_week <- NULL # remove day of week column
dt_year_v3$ride_time_of_day <- NULL # remove ride time of day column
dt_year_v3$ride_end_date <- NULL # remove ride end date column
dt_year_v3$ride_end_time <- NULL # remove ride end time column
dt_year_v3$ride_length <- NULL # remove ride length column
dt_year_v3$ride_start_time <- NULL # remove ride start time column

dt_year_v3 <- rename(dt_year_v3, "ride_month" = "ride_month_v2", "ride_start_hour" = "hour_start_v2")

dt_year_v3 <- dt_year_v3 %>% 
  unite(ride_start, ride_start_date, ride_start_time, sep = " ") # combine ride start date & time into one column


write.csv(dt_year_v3, file = "Aggregate_divvy_tripdata_2023_2024_alt.csv", row.names=FALSE) # Aggregate 09-2023 to 08-2024 Divvy trips (reduced size)


# Calculate aggregated values for 12-month period 09-2023 to 08-2024

# Total Ride Count
dt_year %>% count(member_casual) # total rides for year per Member/Casual

# Average Ride Minutes
mean(dt_year$ride_mins) # average ride minutes per trip for year
dt_year %>%
  group_by(member_casual) %>% 
  summarise(avg_ride = mean(ride_mins)) # average ride mins per ride for year per Member/Casual

# Min Ride Minutes
min(dt_year$ride_mins) # minimum ride trip minutes within year
dt_year %>%
  group_by(member_casual) %>% 
  summarise(min_ride = min(ride_mins)) # minimum ride trip minutes within year by Member/Casual

# Max Ride Minutes
max(dt_year$ride_mins) # maximum ride trip minutes within year
dt_year %>%
  group_by(member_casual) %>% 
  summarise(max_ride = max(ride_mins)) # maximum ride trip minutes within year by Member/Casual

# Ride Count by Day of Week
dt_year_v2 %>%
  count(start_day) # total rides for year broken down into day of week
dt_year_v2 %>%
  group_by(ride_month_v2) %>% 
  count(start_day) # total rides broken down into day of week per month
dt_year_v2 %>%
  group_by(member_casual) %>% 
  count(start_day) # total rides broken down into day of week per Member/Casual
dt_year_v2 %>%
  group_by(ride_month_v2, member_casual) %>% 
  count(start_day) # total rides broken down into day of week per month & Member/Casual

# Ride Count by Month
dt_year_v2 %>%
  count(ride_month_v2) # total rides broken down into month
dt_year_v2 %>%
  group_by(member_casual) %>% 
  count(ride_month_v2) # total rides broken down into month per Member/Casual

# Ride Count by AM/PM
dt_year %>%
  count(ride_time_of_day) # total rides broken down into time of day
dt_year %>%
  group_by(member_casual) %>% 
  count(ride_time_of_day) # total rides broken down into time of day per Member/Casual
dt_year_v2 %>%
  group_by(ride_month_v2) %>%
  count(ride_time_of_day) # total rides broken down into time of day per month
dt_year_v2 %>%
  group_by(ride_month_v2, member_casual) %>%
  count(ride_time_of_day) # total rides broken down into time of day per month & Member/Casual

# Ride Count by Start Hour of Day
dt_start_time <- dt_year_v2 %>%
  count(hour_start_v2) # total rides by hour of day for year period
dt_start_time <- dt_year_v2 %>%
  group_by(member_casual) %>% 
  count(hour_start_v2) # total rides by hour of day for 12-month period per Member/Casual
dt_start_time_member <- dt_year_v2 %>%
  group_by(member_casual) %>%
  filter(member_casual == "member") %>% 
  count(hour_start_v2) # total rides by hour of day for 12-month period per Member
dt_start_time_casual <- dt_year_v2 %>%
  group_by(member_casual) %>%
  filter(member_casual == "casual") %>% 
  count(hour_start_v2) # total rides by hour of day for 12-month period per Casual

# Ride Count by Start Hour of Day (by Day of Week)
dt_start_time_day <- dt_year_v2 %>%
  group_by(start_day) %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 12-month period
dt_start_time_day <- dt_year_v2 %>%
  group_by(start_day, member_casual) %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 12-month period per Member/Casual
dt_start_time_day_member <- dt_year_v2 %>%
  group_by(start_day, member_casual) %>% 
  filter(member_casual == "member") %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 12-month period per Member
dt_start_time_day_casual <- dt_year_v2 %>%
  group_by(start_day, member_casual) %>% 
  filter(member_casual == "casual") %>% 
  count(hour_start_v2) # total rides by hour of day for each day of week for 12-month period per Casual

# Ride Count by Ride Type
dt_year %>% count(rideable_type) # total rides for year per ride type
dt_year %>%
  group_by(member_casual) %>% 
  count(rideable_type) # total rides for year per ride type by Member/Casual
dt_year_v2 %>%
  group_by(ride_month_v2, member_casual) %>% 
  count(rideable_type) # total rides for year per ride type by month & Member/Casual
dt_year_v2 %>%
  group_by(start_day, hour_start_v2, member_casual) %>% 
  count(rideable_type) # total rides for year per ride type by day of week, time of day, & Member/Casual

# Ride Count by Start Station
dt_start_stations <- dt_year %>%
  count(start_station_name) # total rides for year by start station
dt_start_stations <- dt_year %>%
  group_by(member_casual) %>% 
  count(start_station_name) # total rides for year by start station per Member/Casual
dt_start_stations_member <- dt_year %>%
  group_by(member_casual) %>% 
  filter(member_casual == "member") %>% 
  count(start_station_name) # total rides for year by start station per Member
dt_start_stations_casual <- dt_year %>%
  group_by(member_casual) %>% 
  filter(member_casual == "casual") %>% 
  count(start_station_name) # total rides for year by start station per Casual

# Ride Count by End Station
dt_end_stations <- dt_year %>%
  count(end_station_name) # total rides for year by end station
dt_end_stations <- dt_year %>%
  group_by(member_casual) %>% 
  count(end_station_name) # total rides for year by end station per Member/Casual
dt_end_stations_member <- dt_year %>%
  group_by(member_casual) %>% 
  filter(member_casual == "member") %>% 
  count(end_station_name) # total rides for year by end station per Member
dt_end_stations_casual <- dt_year %>%
  group_by(member_casual) %>% 
  filter(member_casual == "casual") %>% 
  count(end_station_name) # total rides for year by end station per Casual

# Most Popular Start Station by Start Time

dt_start_station_max <- dt_year_v2 %>%
  group_by(start_station_name, hour_start_v2) %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max ride by hour per station

dt_start_station_max_v2 <- dt_year_v2 %>%
  group_by(start_station_name, member_casual, hour_start_v2) %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max ride by hour per station and Member/Casual

dt_start_station_max_member <- dt_year_v2 %>%
  group_by(start_station_name, member_casual, hour_start_v2) %>% 
  filter(member_casual == "member") %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max Member rides by hour per station

dt_start_station_max_casual <- dt_year_v2 %>%
  group_by(start_station_name, member_casual, hour_start_v2) %>% 
  filter(member_casual == "casual") %>% 
  count(hour_start_v2) %>% 
  summarise(max(n)) # max Casual rides by hour per station
