### Day 6 (09/11): GROUP BY Clause
-- Topics: Data grouping, aggregation by category, and summary reports.

### Practice Questions:
-- 1. Count the number of patients by each service.
SELECT 
    service, 
    COUNT(*) AS total_patients
FROM patients
GROUP BY service;
-- 2. Calculate the average age of patients grouped by service.
SELECT 
    service, 
    ROUND(AVG(age), 2) AS avg_age
FROM patients
GROUP BY service
ORDER BY avg_age DESC;
-- 3. Find the total number of staff members per role.
SELECT 
    role, 
    COUNT(*) AS total_staff
FROM staff
GROUP BY role
ORDER BY total_staff DESC;
        
        
### Day 6  Challenge: For each hospital service, calculate the total number of patients admitted, total patients refused, 
-- and the admission rate (percentage of requests that were admitted). Order by admission rate descending.
SELECT service,
    SUM(patients_admitted) AS total_admitted,
    SUM(patients_refused) AS total_refused,
    ROUND(100.0 * SUM(patients_admitted) / (SUM(patients_admitted) + SUM(patients_refused)), 2) AS admission_rate
FROM services_weekly GROUP BY service ORDER BY admission_rate DESC;
                       
