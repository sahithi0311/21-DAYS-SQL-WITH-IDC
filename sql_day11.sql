### Day 11 (14/11): DISTINCT and Handling Duplicates
-- Practice Questions: 

-- 1.List all unique services in the patients table
SELECT DISTINCT service FROM patients ORDER BY service;

-- 2. Find all unique staff roles in the hospital
SELECT DISTINCT role FROM staff ORDER BY role;

-- 3.  Get distinct months from the services_weekly table
SELECT DISTINCT month FROM services_weekly ORDER BY month;


/* Day 11 challenge: Find all unique combinations of service and event_type from the services_weekly table
where events are not null or none,
along with the count of occurrences for each combination.
Order the results by count descending. */

SELECT distinct service, event, COUNT(*) AS event_count
FROM services_weekly WHERE event IS NOT NULL 
  AND event != 'None' GROUP BY service, event
ORDER BY event_count DESC;