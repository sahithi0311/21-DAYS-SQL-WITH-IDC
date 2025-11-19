### Day 13 (17/11): INNER JOIN
-- Topics: INNER JOIN, joining two tables, relationship understanding

### Practice Questions:

-- 1. Join patients and staff based on their common service field (show patient and staff who work in same service).
SELECT p.patient_id,p.name AS patient_name,p.service,s.staff_id,s.staff_name,s.role
FROM patients p
INNER JOIN staff s ON p.service = s.service
ORDER BY p.service, p.name;

-- 2. Join services_weekly with staff to show weekly service data with staff information.
SELECT sw.week,sw.month,sw.service,sw.patients_request,sw.patients_admitted,sw.patients_refused,sw.patient_satisfaction,
sw.staff_morale,s.staff_id,s.staff_name,s.role FROM services_weekly sw
INNER JOIN staff s ON sw.service = s.service ORDER BY sw.week, sw.service;

-- 3. Create a report showing patient information along with staff assigned to their service.
SELECT p.patient_id,p.name AS patient_name,p.age,p.service,s.staff_id,s.staff_name,s.role
FROM patients p
INNER JOIN staff s ON p.service = s.service
ORDER BY p.service, p.name;

/* Day 13 Challenge:
**Question:** Create a comprehensive report showing patient_id, patient name, age, service, and 
the total number of staff members available in their service. 
Only include patients from services that have more than 5 staff members. 
Order by number of staff descending, then by patient name. */

SELECT p.patient_id,p.name AS patient_name,p.age,p.service,staff_count.total_staff
FROM patients p
INNER JOIN (SELECT service,COUNT(*) AS total_staff FROM staff GROUP BY service HAVING COUNT(*) > 5)
 AS staff_count ON p.service = staff_count.service
ORDER BY staff_count.total_staff DESC,p.name ASC;

