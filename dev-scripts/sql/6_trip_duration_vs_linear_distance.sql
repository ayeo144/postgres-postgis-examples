-- Some analysis using the trip duration data and distances calculated using the points

-- Calculate the correlation coefficient between trip duration and linear distance, just for the sake of it...
SELECT corr(
    trip_duration, 
    ST_Distance(
        ST_Transform(tbl.pickup_point, 3626), -- transform from WGS84 to the EPSG code of NYC so we can calculate distance in meters...
        ST_Transform(tbl.dropoff_point, 3626)
    )
) FROM journeys_spatial AS tbl;


-- Average distance for grouped trip durations.
--
--
-- Selecting the discrete trip duration class, and the average distance travelled by a taxi journey
-- within that trip duration class, from a table containing the pickup and dropoff points and the
-- categorised trip duration values.
--
-- Simplified: 
--      SELECT trip_duration_class, average_distance 
--      FROM tbl_points_and_trip_duration_class
--      GROUP BY trip_duration_class;
--
-- The 'tbl_points_and_trip_duration_class' is created by selecting from the original table and using
-- a CASE statement to group the trip_duration values and relable them.


SELECT  

d.trip_duration_class,   
AVG(
    ST_Distance(
        ST_Transform(d.pickup_point, 3626),
        ST_Transform(d.dropoff_point, 3626)
    )
) AS average_distance

FROM (
    SELECT 
    tbl.pickup_point,
    tbl.dropoff_point,
    (
        CASE 
            WHEN tbl.trip_duration BETWEEN 0 AND 1000000 THEN 1
            WHEN tbl.trip_duration BETWEEN 1000000 AND 2000000 THEN 2
            WHEN tbl.trip_duration BETWEEN 2000000 AND 3000000 THEN 3
            ELSE 4
        END
    ) AS trip_duration_class
    FROM journeys_spatial AS tbl
) AS d

GROUP BY d.trip_duration_class;