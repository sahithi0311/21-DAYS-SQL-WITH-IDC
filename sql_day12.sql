### Day 12 (15/11): NULL Values and IS NULL/IS NOT NULL
-- Topics: NULL handling, IS NULL, IS NOT NULL, COALESCE

## Practice Questions:
-- 1. Find all weeks in services_weekly where no special event occurred.
SELECT week FROM services_weekly WHERE event IS NULL OR event = '';

-- 2. Count how many records have null or empty event values.
SELECT COUNT(*) AS null_or_empty_events FROM services_weekly WHERE event IS NULL OR event = '';
-- For full breakdown data.
SELECT COUNT(*) AS total_rows, COUNT(event) AS non_null_events,COUNT(*) - COUNT(event) AS null_events,
    SUM(CASE WHEN event = '' THEN 1 ELSE 0 END) AS empty_events FROM services_weekly;

-- 3. List all services that had at least one week with a special event.
SELECT DISTINCT service FROM services_weekly WHERE event IS NOT NULL AND event <> '';

/* Day 12(15/11) Challenge: Analyze the event impact by comparing weeks with events vs weeks without events. 
Show: event status ('With Event' or 'No Event'), count of weeks, average patient satisfaction, 
and average staff morale. Order by average patient satisfaction descending. */

SELECT 
    CASE
        WHEN event IS NULL 
             OR TRIM(event) = ''
             OR LOWER(TRIM(event)) = 'none'
        THEN 'No Event'
        ELSE 'With Event'
    END AS event_status,
    COUNT(*) AS week_count,
    ROUND(AVG(patient_satisfaction), 2) AS avg_patient_satisfaction,
    ROUND(AVG(staff_morale), 2) AS avg_staff_morale
FROM services_weekly GROUP BY event_status ORDER BY avg_patient_satisfaction DESC;

