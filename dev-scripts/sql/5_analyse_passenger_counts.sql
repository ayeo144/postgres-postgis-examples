-- Aim:
-- Create a count of the total number of taxi rides with each number of passengers, place into new table
-- with schema like this:
--
--      passenger_count | number_of_journeys
--              0       |         n
--              1       |         m

CREATE TABLE passenger_count_summary AS (
    SELECT passenger_count, COUNT(*) AS number_of_journeys 
    FROM journeys_spatial 
    GROUP BY passenger_count
);

-- This solution here also works, where we use SUM(1) instead of COUNT(*)
-- Questions:
--      How is this different?
--      Is this more efficient?
--
-- CREATE TABLE passenger_count_summary AS (
--     SELECT passenger_count, SUM(1) AS number_of_journeys 
--     FROM journeys_spatial 
--     GROUP BY passenger_count
-- );
--
-- This is also valid:
-- 
-- CREATE TABLE passenger_count_summary AS (
--     SELECT passenger_count, COUNT(1) AS number_of_journeys 
--     FROM journeys_spatial 
--     GROUP BY passenger_count
-- );