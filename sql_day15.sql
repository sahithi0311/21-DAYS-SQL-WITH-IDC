### Day 15 (19/11): Multiple Joins
-- Topics: Joining more than two tables, complex relationships

### Practice Questions:

-- 1. Join patients, staff, and staff_schedule to show patient service and staff availability.
SELECT p.patient_id,p.name AS patient_name,p.service,s.staff_id,s.staff_name,ss.week,ss.present
FROM patients p
INNER JOIN staff s ON p.service = s.service
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
ORDER BY p.patient_id, ss.week;
-- 2. Combine services_weekly with staff and staff_schedule for comprehensive service analysis.
SELECT sw.week,sw.month,sw.service,sw.patients_request,
sw.patients_admitted,sw.patients_refused,s.staff_id,s.staff_name,ss.present AS staff_present
FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id AND sw.week = ss.week
ORDER BY sw.week, sw.service;

-- 3. Create a multi-table report showing patient admissions with staff information.
SELECT p.patient_id,p.name AS patient_name,p.service,p.arrival_date,
s.staff_id,s.staff_name, ss.week,ss.present
FROM patients p
LEFT JOIN staff s ON p.service = s.service
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id
ORDER BY p.patient_id, ss.week;

/* Day 15 Challenge:
Question:** Create a comprehensive service analysis report for week 20 showing: 
service name, total patients admitted that week, total patients refused, average patient satisfaction, 
count of staff assigned to service, and count of staff present that week. 
Order by patients admitted descending.*/

SELECT sw.service AS Service_name,
    SUM(sw.patients_admitted) AS total_admitted,
    SUM(sw.patients_refused) AS total_refused,
    ROUND(AVG(sw.patient_satisfaction), 2) AS avg_satisfaction,
    COUNT(DISTINCT s.staff_id) AS total_staff_assigned,
    COUNT(ss.present) AS staff_present_week20 FROM services_weekly sw
LEFT JOIN staff s ON sw.service = s.service
LEFT JOIN staff_schedule ss ON s.staff_id = ss.staff_id AND sw.week = ss.week
WHERE sw.week = 20 GROUP BY sw.service ORDER BY total_admitted DESC;
