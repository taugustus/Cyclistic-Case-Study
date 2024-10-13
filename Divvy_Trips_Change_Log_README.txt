Divvy Trips Change Log for Case Study #1: Cyclistic Rider Behavior



Data Cleaning And Manipulation


MS Excel - Divvy Trip Data


Version 1 Files
* downloaded all 12 zip files, unzipped, and housed in temporary folder on desktop
* created subfolder to house original data as master copy
* opened each file and saved as .xlsx file to edit in excel - saved master copies of .xlsx into same subfolder as original .csv files - .xlsx master files are identified as Version 1 files


Version 2 Files
* cleaned and manipulated .xlsx files in order to apply functions, formulas, etc to create additional parameters for observation
* changed format of started_at and ended_at columns
	- formatted column as custom timestamp yyyy-mm-dd h:mm:ss
	- Format > Cells > Custom > yyyy-mm-dd h:mm:ss
	- sorted entire sheet by started_at values ascending
* created columns to separate started_at and ended_at values into corresponding dates/time:
	- new column: ride_start_date
		+ used INT command to separate date from started_at timestamp; created integer value
		+ formatted column to custom yyyy-mm-dd to change into date
		+ Formate > Cells > Custom > yyyy-mm-dd
	- new column: ride_start_time
		+ used formula to subtract started_at from ride_start_date to separate time from timestamp
		+ =(started_at)-(ride_start_date); created integer value
		+ formatted column to custom hh:mm:ss to change into time
		+ Formate > Cells > Custom > hh:mm:ss
	- new column: ride_end_date
		+ used INT command to separate date from ended_at timestamp; created integer value
		+ formatted column to custom yyyy-mm-dd to change into date
		+ Formate > Cells > Custom > yyyy-mm-dd
	- new column: ride_end_time
		+ used formula to subtract ended_at from ride_start_date to separate time from timestamp
		+ =(ended_at)-(ride_end_date); created integer value
		+ formatted column to custom hh:mm:ss to change into time
		+ Formate > Cells > Custom > hh:mm:ss
* created ride_length column
	- calculated the length of each ride by subtracting the column ride_start_time from column ride_end_time; =(ride_end_time)-(ride_start_time)
	- formatted column to custom h:mm
	- Format > Cells > Custom > h:mm
	- for overnight times, calculated using MOD command; =MOD((ride_end_time)-(ride_start_time), 1)
* created ride_time_of_day column
	- calculated whether ride was started during AM or PM based on ride_start_time by using customized IF and MOD commands; =IF(MOD(ride_start_time,1)>=0.5,"PM","AM")
* created day_of_week column
	- calculated day of week of ride based on started_at using the WEEKDAY() command; =WEEKDAY(started_at, 1)
	- formatted column as General value
	- Format > Cells > General
* created ride_month column
	- Entered month by sourcing from ride_start_date column; =(ride_start_date)
	- formatted column as custom m
	- Formate > Cells > Custom > m
* created start_location column
	- joined both start_lat and start_lng columns to create full location coordinates for station
	- used CONCATENATE command to join; =CONCATENATE(start_lng, " ", start_lat)
* created end_location column
	- joined both end_lat and end_lng columns to create full location coordinates for station
	- used CONCATENATE command to join; =CONCATENATE(end_lng, " ", end_lat)
* used VLOOKUP to find missing values within start_station_name and end_station_name columns
	- imported divvy_bicycle_stations_v2 sheet into workbook to use as reference for VLOOKUP
	- i.e. =VLOOKUP(end_station_name, Divvy_Bicycle_Stations!(range), (col_ref), TRUE); used TRUE argument to obtain closest coordinates match due to varying start_location/end_location structures
	- missing values within start_station_id and end_station_id columns were not recovered due to the nature of certain stations having more than one station_id associated with station_name prior to performing VLOOKUP
* saved modified files as Version 2 .xlsx file and housed in a .xlsx subfolder within the main temporary data folder on desktop


Version 3 Files
* re-scrubbed start_station_name & end_station_name columns on each file to ensure values were the most accurate for analysis
	- reviewed VLOOKUP command on #NA values to confirm validness (i.e. missing values in start_location/end_location columns)
	- if #N/A values had associated values in start_station_id/end_station_id columns, created XLOOKUP command within corresponding start_station_name/end_station_name cells to fill with correct values, using divvy_bicycle_stations_v2 sheet as reference (i.e. XLOOKUP(start_station_name, Divvy_Bicycle_Stations!(range), (range))
	- corrected any values produced by VLOOKUP command that did not align with similar non-missing start_station_name/end_station_name values (i.e. discrepancies in start_station_id/end_station_id values to corresponding stations, comparisons of start_location/end_location values to Location_Coord values in divvy_bicycle_stations sheet)
* saved modified files as Version 3 .xlsx file and created associated Version 3 .csv file; housed in a .csv subfolder within the temporary data folder on desktop



MS Excel - Divvy Bicycle Stations


Version 1 File
* downloaded .csv file and housed in temporary folder on desktop
* created subfolder to house original data as master copy
* opened file and saved as .xlsx file to edit in excel - saved master copy of .xlsx into same subfolder as original .csv file


Version 2 File
* created Location_Coord column
	- joined both Latitude and Longitude columns to create full location coordinates for station
	- used CONCATENATE command to join; =CONCATENATE(Longitude, " ", Latitude)
	- moved column to 2nd column location in workbook so it would be next to Station_Name column for easier reference using VLOOKUP
* attempted to merge older station lists provided by City of Chicago, however, lists were out-of-date and produced duplicate locations
* saved copy as Version 2 .xlsx file
* moved a copy of workbook into each Divvy Trip Data .xlsx file to use for VLOOKUP commands to attempt identifying missing station values within dataset



RStudio - Divvy Trip Data


Version 4 Files

**Please refer to R script "Divvy Trips - Step 1 - Cleaning & Manipulation" for code steps used in additional cleaning and manipulation of trip files for analysis**

* opened RStudio desktop version and installed/loaded the following packages: tidyverse, dplyr, readr, purrr, skimr, stringr, janitor, tidyr, lubridate and here
* updated file path to subfolder in temporary desktop folder housing all .csv files and uploaded Version 3 .csv Divvy Trip Data files into RStudio using read_csv(); created data frames of each month
* removed empty NA rows that were transferred from the .csv file conversions from the .xlsx files
	- extra null rows populated in trip files for 10-2023, 11-2023, 01-2024, 02-2024, and 03-2024
	- utilized the rowSums(is.na(data.frame)) != ncol(data.frame),] function to remove rows; generated new, updated data frames from results (v2 tables)
	- deleted original tables so only updated data frames would be available for use
* re-evaluated possible trip duplicates for data tables from 05-2024 thru 08-2024
	- all 12 month files featured rides that began on the last day of the month and ended on the first day of the following month (i.e. started_at = 2024-04-30 23:59:46, ended_at = 2024-05-01 00:59:33), however, files from 06-2024 thru 08-2024 also included trip data from previous month that overlapped into featured month file (i.e. for 06-2024, started_at contained values from 05-2024 and 06-2024, and ended_at values from 06-2024 and 07-2024
	- performed a full join between two month tables utilizing ride_id to merge datasets and used length(unique(merged_data$rider_id) to verify count of unique values and compare to row count of merged datasets; no duplicates were present between any of the datasets
* Evaluated values produced in ride_length columns for accuracy
	- converted ride_length data type from hh:mm:ss time string to minutes using as.numeric(), added results under new column as ride_mins and relocated column next to ride_length for comparison >> all under new revised data frames (v3) 
	- reviewed ride_mins values = 0 and >= 20 for correct reporting (i.e. checked started_at and ended_at values for accuracy on times that elapsed for associated trip)
	- removed trips where ride_mins = o; rides less than 1 minute recognized as invaluable to study, no time elapsed for trip
	- removed trips where ride_mins = 1,439; under all applicable cases, ended_at > started_at (i.e. started_at = 2023-09-22 13:18:54, ended_at = 2023-09-22 13:18:53, ride_length = 23.59), identified as invaluable to study as no real time elapsed for trip (possible system technicalities during timestamp recording)
	- updated data frames were developed to reflect changes (v4)
* Re-evaluated #NA values in start_station_name and end_station_name columns for relevancy to case study
	- determinant to remove any #NA rows was based on how much information available for observation on each trip
	- did not remove any #NA values, and identified these trips as possible outliners in certain visual observations due to lack of station info for associated trip (i.e. missing start_station_name/end_station_name and/or start_location/end_location values)
	- possible station outliners could still contribute to overall observation of rider behavior with other key parameters available (i.e. ride_length, quantitative values for trips, etc)
* trips were not consolidated into associated year quarters (i.e. Q1, Q2, etc) due to Q3 2023 and Q3 2024 consisting of only partial data for observation under the time frame for the case study
	- incomplete data for Q3 2023; 07-2023 and 08-2023 excluded from 12-month review
	- incomplete data for Q3 2024; 09-2024 Divvy trip data unavailable for review as of 10/03/2024 and excluded from 12-month review
	- including inconclusive quarters would skew quarter models, and present bias in the observation
* exported copy of v4 datasets as Version 3 .csv files; housed in .csv subfolder on desktop



Analyzing Trip Data


RStudio - Divvy Trip Data


**Please refer to R script "Divvy Trips - Step 2 - Analyzing Trip Data" for code steps used in analyzing Divvy trip data**

* opened RStudio desktop version and installed/loaded the following packages: tidyverse, dplyr, readr, purrr, skimr, stringr, janitor, tidyr, lubridate and data.table
* updated file path to subfolder in temporary desktop folder housing all .csv files and uploaded Version 4 .csv Divvy Trip Data files into RStudio using read_csv(); created data frames of each month
* consolidated trip tables for all 12 months to generate a single data frame for aggregated insights for 12-month period
	- created duplicate v2 year data set and converted date and time columns to calculate date and time values
		+ created new column start_day to show day of week name
		+ created new column ride_month_v2 to show month name
		+ generated new column hour_start by extracting hh from hh:mm:ss format on ride_start_time
		+ generated new column hour_start_v2, extracting hh from hh:mm:ss format on ride_start_time and converting into AM/PM string
* Performed aggregated values for year
	- ride count for year and per member/casual
	- average ride minutes for year and per member/casual
	- min ride minutes for ride within year and per member/casual
	- max ride minutes for ride within year and per member/casual
	- total ride count for year by day of week
		+ calculations broken down into year and month, overall and per member/casual
	- total ride count for year by month and per member/casual
	- total ride count per time of day
		+ utilized ride_time_of_day to calculate total rides by morning (00:00:00-11:59:59 aka AM) vs afternoon (12:00:00-23:59:59 aka PM) and calculated rides per month and member/casual
	- total ride count by start hour of day
		+ calculated ride count using ride_time_start, overall and per member/casual
	- total ride count for year per ride type and per member/casual
		+ calculations broken down into year, month, and day of week by time of day (AM/PM), overall and per member/casual
	- total ride count for year by start station and end station, overall and per member/casual
	- most popular time and station for rides, overall and per member/casual
* exported aggregated 12-month-period copy of Divvy trip data .csv file; housed in .csv subfolder on desktop


