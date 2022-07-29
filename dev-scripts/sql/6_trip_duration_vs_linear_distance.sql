-- Some analysis using the trip duration data and distances calculated using the points

-- Calculate the correlation coefficient between trip duration and linear distance, just for the sake of it...
SELECT corr(
    trip_duration, 
    ST_Distance(
        ST_Transform(tbl.pickup_point, 3626), -- transform from WGS84 to the EPSG code of NYC so we can calculate distance in meters...
        ST_Transform(tbl.dropoff_point, 3626)
    )
) FROM journeys_spatial AS tbl;