### Day 18 (24/11): UNION and UNION ALL
-- Topics: UNION, UNION ALL, combining result sets

### Practice Questions:
-- 1. Combine patient names and staff names into a single list.
SELECT name AS full_name from patients
UNION
SELECT staff_name AS full_name from staff;

-- 2. Create a union of high satisfaction patients (>90) and low satisfaction patients (<50).
SELECT patient_id, name, satisfaction, 'High' AS category from patients where satisfaction > 90
UNION ALL
SELECT patient_id, name, satisfaction, 'Low' AS category from patients where satisfaction < 50;

-- 3. List all unique names from both patients and staff tables.
SELECT DISTINCT name from patients union all SELECT staff_name from staff;

/* Day 18 Challenge: Create a comprehensive personnel and patient list showing: identifier 
(patient_id or staff_id), full name, type ('Patient' or 'Staff'), and associated service. 
Include only those in 'surgery' or 'emergency' services. Order by type, then service, then name. */

-- Patients in surgery or emergency
SELECT patient_id AS identifier,name AS full_name,'Patient' 
AS type,service from patients where service IN ('surgery', 'emergency')
UNION ALL
SELECT staff_id AS identifier,staff_name AS full_name,'Staff' 
AS type,service from staff where service IN ('surgery', 'emergency')
ORDER BY type, service, full_name;
-- Staff in surgery or emergency


