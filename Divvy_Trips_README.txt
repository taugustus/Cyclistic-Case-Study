This file contains metadata for the Divvy bike-share trip data tables from 9/2023 - 8/2024


Disclaimer:

For the purpose of the case study, the data has been made available by Motivate International Inc. under the Data License Agreement, view at https://divvybikes.com/data-license-agreement

For more information, visit http://DivvyBikes.com/data or email questions to data@DivvyBikes.com


Each trip has been anonymized to protect rider privacy 



Metadata for Divvy Trip Data Table:

Variables:

* ride_id               # Ride id - unique
* rideable_type         # Bike types - Classic and Electric
* started_at            # Trip start day and time
* ended_at              # Trip end day and time
* start_station_name    # Trip start station
* start_station_id      # Trip start station id
* end_station_name      # Trip end station
* end_station_id        # Trip end station id
* start_lat             # Trip start latitude  
* start_lng             # Trip start longitude   
* end_lat               # Trip end latitude  
* end_lat               # Trip end longitude   
* member_casual         # Rider type - Member or Casual 


Notes:

* First row contains column names
* Total aggregated records = 5,699,639 rows (modified: 5,570,059 rows)
* Single Ride and Day Pass are identified as Casual
* Annual Memberships are identified as Member
* Stations can house both Classic and Electric bike types
* The data has been processed to remove trips that are taken by staff as they service and inspect the system; and any trips that were below 60 seconds in length (potentially false starts or users trying to re-dock a bike to ensure it was secure)



