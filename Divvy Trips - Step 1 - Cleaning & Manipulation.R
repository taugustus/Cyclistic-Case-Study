# Install packages into RStudio

install.packages("tidyverse")
install.packages("dplyr")
install.packages("tidyr")
install.packages("readr")
install.packages("stringr")
install.packages("purrr")
install.packages("janitor")
install.packages("skimr")
install.packages("here")


# Upload installed packages into system

library(tidyverse)
library(dplyr)
library(readr)
library(janitor)
library(stringr)
library(purrr)
library(skimr)
library(here)
library(lubridate)
library(hms)

# Upload version 3 .csv files and create data frames by month/year

setwd("~/Documents/Google Data Analytics Certificate Course/Case Study/Case Study Data/Divvy_Trips_Data/Divvy_Trip_Data_csv")

divvy_trips_09_2023 <- read_csv("2023_09_divvy_tripdata_v3.csv") # 09-2023 Divvy trips
divvy_trips_10_2023 <- read_csv("2023_10_divvy_tripdata_v3.csv") # 10-2023 Divvy trips
divvy_trips_11_2023 <- read_csv("2023_11_divvy_tripdata_v3.csv") # 11-2023 Divvy trips
divvy_trips_12_2023 <- read_csv("2023_12_divvy_tripdata_v3.csv") # 12-2023 Divvy trips
divvy_trips_01_2024 <- read_csv("2024_01_divvy_tripdata_v3.csv") # 01-2024 Divvy trips
divvy_trips_02_2024 <- read_csv("2024_02_divvy_tripdata_v3.csv") # 02-2024 Divvy trips
divvy_trips_03_2024 <- read_csv("2024_03_divvy_tripdata_v3.csv") # 03-2024 Divvy trips
divvy_trips_04_2024 <- read_csv("2024_04_divvy_tripdata_v3.csv") # 04-2024 Divvy trips
divvy_trips_05_2024 <- read_csv("2024_05_divvy_tripdata_v3.csv") # 05-2024 Divvy trips
divvy_trips_06_2024 <- read_csv("2024_06_divvy_tripdata_v3.csv") # 06-2024 Divvy trips
divvy_trips_07_2024 <- read_csv("2024_07_divvy_tripdata_v3.csv") # 07-2024 Divvy trips
divvy_trips_08_2024 <- read_csv("2024_08_divvy_tripdata_v3.csv") # 08-2024 Divvy trips

# Remove empty rows that populated from original uploads, create new data frames from results

divvy_trips_01_2024_v2 <- divvy_trips_01_2024[rowSums(is.na(divvy_trips_01_2024)) != ncol(divvy_trips_01_2024),] # 01-2024 Divvy trips
divvy_trips_02_2024_v2 <- divvy_trips_02_2024[rowSums(is.na(divvy_trips_02_2024)) != ncol(divvy_trips_02_2024),] # 02-2024 Divvy trips
divvy_trips_03_2024_v2 <- divvy_trips_03_2024[rowSums(is.na(divvy_trips_03_2024)) != ncol(divvy_trips_03_2024),] # 03-2024 Divvy trips
divvy_trips_10_2023_v2 <- divvy_trips_10_2023[rowSums(is.na(divvy_trips_10_2023)) != ncol(divvy_trips_10_2023),] # 10-2023 Divvy trips
divvy_trips_11_2023_v2 <- divvy_trips_11_2023[rowSums(is.na(divvy_trips_11_2023)) != ncol(divvy_trips_11_2023),] # 11-2023 Divvy trips

# Remove old data frame versions of updated tables

rm(divvy_trips_01_2024, divvy_trips_02_2024, divvy_trips_03_2024, divvy_trips_10_2023, divvy_trips_11_2023)

# Review table summary to view column/row count and confirm data type featured in each column

glimpse(divvy_trips_09_2023) # 09-2023 Divvy trips
glimpse(divvy_trips_10_2023_v2) # 10-2023 Divvy trips
glimpse(divvy_trips_11_2023_v2) # 11-2023 Divvy trips
glimpse(divvy_trips_12_2023) # 12-2023 Divvy trips
glimpse(divvy_trips_01_2024_v2) # 01-2024 Divvy trips
glimpse(divvy_trips_02_2024_v2) # 02-2024 Divvy trips
glimpse(divvy_trips_03_2024_v2) # 03-2024 Divvy trips
glimpse(divvy_trips_04_2024) # 04-2024 Divvy trips
glimpse(divvy_trips_05_2024) # 05-2024 Divvy trips
glimpse(divvy_trips_06_2024) # 06-2024 Divvy trips
glimpse(divvy_trips_07_2024) # 07-2024 Divvy trips
glimpse(divvy_trips_08_2024) # 08-2024 Divvy trips

# Check for any duplicate trips between 05-2024 and 08-2024

dt_05_and_06 <- full_join(divvy_trips_06_2024, divvy_trips_05_2024, by = "ride_id") # consolidated 05-2024 & 06-2024
length(unique(dt_05_and_06$ride_id))

dt_06_and_07 <- full_join(divvy_trips_07_2024, divvy_trips_06_2024, by = "ride_id") # consolidated 06-2024 & 07-2024
length(unique(dt_06_and_07$ride_id))

dt_07_and_08 <- full_join(divvy_trips_07_2024, divvy_trips_08_2024, by = "ride_id") # consolidated 07-2024 & 08-2024
length(unique(dt_07_and_08$ride_id))


# Verify accuracy of ride_lengths for each dataset

divvy_trips_09_2023_v3 <- divvy_trips_09_2023 %>%  # 09-2023 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_09_2023$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_09_2023_v4 <- divvy_trips_09_2023_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_10_2023_v3 <- divvy_trips_10_2023_v2 %>%  # 10-2023 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_10_2023_v2$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_10_2023_v4 <- divvy_trips_10_2023_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_11_2023_v3 <- divvy_trips_11_2023_v2 %>%  # 11-2023 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_11_2023_v2$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_11_2023_v4 <- divvy_trips_11_2023_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_12_2023_v3 <- divvy_trips_12_2023 %>%  # 12-2023 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_12_2023$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_12_2023_v4 <- divvy_trips_12_2023_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_01_2024_v3 <- divvy_trips_01_2024_v2 %>%  # 01-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_01_2024_v2$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_01_2024_v4 <- divvy_trips_01_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_02_2024_v3 <- divvy_trips_02_2024_v2 %>%  # 02-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_02_2024_v2$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_02_2024_v4 <- divvy_trips_02_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_03_2024_v3 <- divvy_trips_03_2024_v2 %>%  # 03-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_03_2024_v2$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_03_2024_v4 <- divvy_trips_03_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_04_2024_v3 <- divvy_trips_04_2024 %>%  # 04-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_04_2024$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_04_2024_v4 <- divvy_trips_04_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_05_2024_v3 <- divvy_trips_05_2024 %>%  # 05-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_05_2024$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_05_2024_v4 <- divvy_trips_05_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_06_2024_v3 <- divvy_trips_06_2024 %>%  # 06-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_06_2024$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_06_2024_v4 <- divvy_trips_06_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_07_2024_v3 <- divvy_trips_07_2024 %>%  # 07-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_07_2024$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_07_2024_v4 <- divvy_trips_07_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

divvy_trips_08_2024_v3 <- divvy_trips_08_2024 %>%  # 08-2024 Divvy trips
  mutate(ride_mins = as.numeric(divvy_trips_08_2024$ride_length/60)) %>% 
  relocate(ride_mins, .after = ride_length)

divvy_trips_08_2024_v4 <- divvy_trips_08_2024_v3 %>%
  filter(ride_mins !=0 & ride_mins !=1439)

# Export v4 data frames into .csv files

write.csv(divvy_trips_09_2023_v4, file = "2023_09_divvy_tripdata_v4.csv") # 09-2023 Divvy trips
write.csv(divvy_trips_10_2023_v4, file = "2023_10_divvy_tripdata_v4.csv") # 10-2023 Divvy trips
write.csv(divvy_trips_11_2023_v4, file = "2023_11_divvy_tripdata_v4.csv") # 11-2023 Divvy trips
write.csv(divvy_trips_12_2023_v4, file = "2023_12_divvy_tripdata_v4.csv") # 12-2023 Divvy trips
write.csv(divvy_trips_01_2024_v4, file = "2024_01_divvy_tripdata_v4.csv") # 01-2024 Divvy trips
write.csv(divvy_trips_02_2024_v4, file = "2024_02_divvy_tripdata_v4.csv") # 02-2024 Divvy trips
write.csv(divvy_trips_03_2024_v4, file = "2024_03_divvy_tripdata_v4.csv") # 03-2024 Divvy trips
write.csv(divvy_trips_04_2024_v4, file = "2024_04_divvy_tripdata_v4.csv") # 04-2024 Divvy trips
write.csv(divvy_trips_05_2024_v4, file = "2024_05_divvy_tripdata_v4.csv") # 05-2024 Divvy trips
write.csv(divvy_trips_06_2024_v4, file = "2024_06_divvy_tripdata_v4.csv") # 06-2024 Divvy trips
write.csv(divvy_trips_07_2024_v4, file = "2024_07_divvy_tripdata_v4.csv") # 07-2024 Divvy trips
write.csv(divvy_trips_08_2024_v4, file = "2024_08_divvy_tripdata_v4.csv") # 08-2024 Divvy trips
