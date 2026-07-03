-- Clustering data to unveil Maji Ndogo's water crisis
SELECT *
FROM employee;
-- Cleaning the data
-- we need to fill in emails of our employees for easy informaton dissemination 
-- UPDATE and SET changes

-- First up, let's remove the space between the first and last names using REPLACE(). You can try this:
SELECT
REPLACE(employee_name, ' ','.') -- Replace the space with a full stop
FROM
employee;

-- Then we can use LOWER() with the result we just got. Now the name part is correct.
SELECT
LOWER(REPLACE(employee_name, ' ','.')) -- Make it all lower case
FROM
employee;

-- We then use CONCAT() to add the rest of the email address:
SELECT
CONCAT(
LOWER(REPLACE(employee_name, ' ', '.')), '@ndogowater.gov') AS new_email -- add it all together
FROM
employee;

-- UPDATE EMAIL COLUMN WITHEMAIL ADDRESSES

UPDATE employee
SET email = CONCAT(LOWER(REPLACE(employee_name, ' ', '.')),
'@ndogowater.gov');

-- VIEW EMPLOYEE TABLE TO MAKE SURE EMAIL HAS BEEN UPDATED
SELECT *
FROM employee;

-- PHONE NUMBER CLEANING -- I will use the trim function to remove trailing spaces
SELECT
LENGTH(phone_number) -- phone number has 13 characters instead of 12
FROM
employee;
 
SELECT
    phone_number,
   length(TRIM(phone_number)) AS cleaned_phone_number
FROM employee;

UPDATE employee
SET phone_number = TRIM(phone_number);

SELECT 
LENGTH(phone_number)
FROM employee;

SELECT*
FROM employee;

-- Count of employee in each town
-- To know the unique town_name, use the DISTINCT function
SELECT DISTINCT town_name
FROM employee;

SELECT
town_name,
COUNT(employee_name) AS number_of_employee_per_town
FROM employee
GROUP BY town_name;
-- Extract first 3 employees with the highest visits

SELECT
assigned_employee_id,
COUNT(record_id) AS number_of_visits
FROM visits
GROUP BY assigned_employee_id
ORDER BY number_of_visits DESC
LIMIT 3;

-- employees name phone number and email that matches the employees_id
SELECT 
employee_name, email, phone_number
FROM employee
WHERE assigned_employee_id IN ( 1, 30, 34);

-- Count the number of records per town
SELECT 
town_name,
COUNT(location_id) AS record_per_town,
town_name
FROM location
GROUP BY town_name;

-- Count the number of records per province
SELECT 
COUNT(location_id) AS record_per_town,
province_name
FROM location
GROUP BY province_name;

-- A result showing town_name, province_name
-- An aggregated count of each record for each town
-- Grouped by town_name and province_name
-- Record result by province_name
SELECT 
town_name,
province_name,
COUNT(town_name) AS record_per_town
FROM location
GROUP BY town_name, province_name
ORDER BY province_name, record_per_town DESC;

-- Number of record for each loaction type
SELECT 
COUNT(location_id) AS record_per_town,
location_type
FROM location
GROUP BY location_type;

-- We can see that there are more rural sources than urban, but it's really hard to understand those numbers. Percentages are more relatable.
-- If we use SQL as a very overpowered calculator:
SELECT 23740 / (15910 + 23740) * 100;
-- We can see that 60% of all water sources in the data set are in rural communities.

-- Number of people surveyed
SELECT*
FROM water_source;

SELECT
SUM(number_of_people_served)
FROM water_source; -- 27628140

-- Number of wells, rivers, taps and water_source in majindogo
SELECT 
type_of_water_source,
COUNT(source_id) AS number_of_sources
FROM water_source
GROUP BY type_of_water_source
ORDER BY number_of_sources DESC;

-- Average number of people served_by_water_source
SELECT
    type_of_water_source,
    ROUND (AVG(number_of_people_served)) AS avg_people_served
FROM water_source
GROUP BY type_of_water_source;

-- Total number of people served by each source 

SELECT
    type_of_water_source,
    SUM(number_of_people_served) AS total_people_served
FROM water_source
GROUP BY type_of_water_source
ORDER BY total_people_served DESC;

-- Show result in percentage
SELECT
type_of_water_source,
 ROUND((SUM(number_of_people_served)/27628140)*100) AS percentage_of_people_source
FROM water_source
GROUP BY type_of_water_source
ORDER BY percentage_of_people_source DESC;

-- A query that ranks each type of water source
-- base on total number of people using it
SELECT
    type_of_water_source,
    SUM(number_of_people_served) AS total_people_per_source,
    RANK() OVER (ORDER BY SUM(number_of_people_served) DESC)
    AS rank_by_population
FROM water_source
GROUP BY type_of_water_source;

-- So create a query to do this, and keep these requirements in mind:
-- Sources within each type should be assigned a rank
-- Limit the results to only improvable sources.
-- think how to partition, filter and order the results set.
-- 0rder the result to see the top of the list
SELECT
	source_id,
    type_of_water_source,
    SUM(number_of_people_served) AS number_of_people_served,
    RANK() OVER (
    PARTITION BY type_of_water_source
    ORDER BY SUM(number_of_people_served) DESC)
    AS Priority_rank
FROM water_source
GROUP BY source_id, type_of_water_source
HAVING type_of_water_source
NOT IN ("well", "tap_in_home", "tap_in_home_broken");

-- To calculate how long the survey took, we need to get the first and last dates (which functions can find the largest/smallest value), and subtract
-- them. Remember with DateTime data, we can't just subtract the values. We have to use a function to get the difference in days.

SELECT
timestampdiff(day, 
min(time_of_record),
max(time_of_record)) AS survey_duration
FROM visits;

-- How long people have to queue to get water

SELECT
    ROUND(AVG(NULLIF(time_in_queue, 0))) AS average_time_in_queue
FROM visits;

-- SELECT THE AVG QUEUE TIME GROUPED BY DAY OF THE WEEK
SELECT 
DAYNAME (time_of_record) AS day_name,
 ROUND(AVG(NULLIF(time_in_queue, 0))) AS average_time_in_queue
 FROM visits
 GROUP BY day_name;
 -- Calculate average hour spent fetching water 
 
 SELECT 
    ROUND(AVG(NULLIF(time_in_queue, 0)) / 60, 2) AS average_hours_fetching_water
FROM visits
ORDER BY average_hours_fetching_water DESC;
                   
SELECT 
hour(min(time_of_record))
FROM visits;

SELECT 
hour(max(time_of_record))
FROM visits;

SELECT
    HOUR(time_of_record) AS hour_of_day,
    ROUND(AVG(NULLIF(time_in_queue, 0)), 0) AS average_queue_time_minutes
FROM visits
GROUP BY HOUR(time_of_record)
ORDER BY hour_of_day;
-- Time format
SELECT
    TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
    ROUND(AVG(NULLIF(time_in_queue, 0)), 2) AS average_queue_time_minutes
FROM visits
GROUP BY TIME_FORMAT(TIME(time_of_record), '%H:00')
ORDER BY hour_of_day;

SELECT
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
DAYNAME(time_of_record),
CASE
WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
ELSE NULL
END AS Sunday
FROM
visits
WHERE
time_in_queue != 0; -- this exludes other sources with 0 queue times.

SELECT
TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,
-- Sunday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
ELSE NULL
END
),0) AS Sunday,
-- Monday
ROUND(AVG(
CASE
WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
ELSE NULL
END
),0) AS Monday
-- Tuesday
-- Wednesday
FROM
visits
WHERE
time_in_queue != 0 -- this excludes other sources with 0 queue times
GROUP BY
hour_of_day
ORDER BY
hour_of_day;

-- for all the days of the week 
SELECT
    TIME_FORMAT(TIME(time_of_record), '%H:00') AS hour_of_day,

    -- Sunday
    ROUND(AVG(
        CASE
            WHEN DAYNAME(time_of_record) = 'Sunday' THEN time_in_queue
            ELSE NULL
        END
    ), 0) AS Sunday,

    -- Monday
    ROUND(AVG(
        CASE
            WHEN DAYNAME(time_of_record) = 'Monday' THEN time_in_queue
            ELSE NULL
        END
    ), 0) AS Monday,

    -- Tuesday
    ROUND(AVG(
        CASE
            WHEN DAYNAME(time_of_record) = 'Tuesday' THEN time_in_queue
            ELSE NULL
        END
    ), 0) AS Tuesday,

    -- Wednesday
    ROUND(AVG(
        CASE
            WHEN DAYNAME(time_of_record) = 'Wednesday' THEN time_in_queue
            ELSE NULL
        END
    ), 0) AS Wednesday,

    -- Thursday
    ROUND(AVG(
        CASE
            WHEN DAYNAME(time_of_record) = 'Thursday' THEN time_in_queue
            ELSE NULL
        END
    ), 0) AS Thursday,

    -- Friday
    ROUND(AVG(
        CASE
            WHEN DAYNAME(time_of_record) = 'Friday' THEN time_in_queue
            ELSE NULL
        END
    ), 0) AS Friday,

    -- Saturday
    ROUND(AVG(
        CASE
            WHEN DAYNAME(time_of_record) = 'Saturday' THEN time_in_queue
            ELSE NULL
        END
    ), 0) AS Saturday

FROM visits
WHERE time_in_queue != 0
GROUP BY hour_of_day
ORDER BY hour_of_day;

/* Insights
1. Most water sources are rural.
2. 43% of our people are using shared taps. 2000 people often share one tap.
3. 31% of our population has water infrastructure in their homes, but within that group, 45% face non-functional systems due to issues with pipes,
pumps, and reservoirs.
4. 18% of our people are using wells of which, but within that, only 28% are clean..
5. Our citizens often face long wait times for water, averaging more than 120 minutes.
6. In terms of queues:
- Queues are very long on Saturdays.
- Queues are longer in the mornings and evenings.
- Wednesdays and Sundays have the shortest queues.
*/
 













