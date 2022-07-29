DROP TABLE IF EXISTS journeys_spatial;

-- Create a copy of the raw data table that we will make changes to
CREATE TABLE journeys_spatial AS (SELECT * FROM journeys_raw);

-- Add geometry columns
SELECT AddGeometryColumn ('public', 'journeys_spatial', 'pickup_point', 4326, 'POINT', 2);
SELECT AddGeometryColumn ('public', 'journeys_spatial', 'dropoff_point', 4326, 'POINT', 2);

-- Update the geometry columns with points created from the lon/lat values
UPDATE journeys_spatial
SET pickup_point = ST_SetSRID(
    ST_MakePoint(
        pickup_longitude,
        pickup_latitude
    ),
    4326
);

UPDATE journeys_spatial
SET dropoff_point = ST_SetSRID(
    ST_MakePoint(
        dropoff_longitude,
        dropoff_latitude
    ),
    4326
);