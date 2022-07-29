-- Compare number of passengers to average trip duration
SELECT passenger_count, avg(trip_duration) FROM journeys_spatial GROUP BY passenger_count;