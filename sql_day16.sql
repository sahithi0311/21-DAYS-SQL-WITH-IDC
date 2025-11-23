use hospital;
### Day 16 (21/11): Subqueries (WHERE clause)
-- Topics: Subqueries in WHERE, nested queries, filtering with subqueries

### Practice Questions:
-- Q1. Find patients who are in services with above-average staff count.
SELECT * FROM patients WHERE service IN (SELECT service FROM staff GROUP BY service HAVING COUNT(*) > (
        SELECT AVG(staff_count) FROM ( SELECT service, COUNT(*) AS staff_count FROM staff GROUP BY service) AS t ));

-- Q2. List staff who work in services that had any week with patient satisfaction below 70.
SELECT * FROM staff WHERE service IN (SELECT service FROM services_weekly WHERE patient_satisfaction < 70);

-- Q3. Show patients from services where total admitted patients exceed 1000.
SELECT * FROM patients WHERE service IN ( SELECT service FROM services_weekly GROUP BY service HAVING SUM(patients_admitted) > 1000);

/* Day 16 Challenge: Find all patients who were admitted to services that had:
at least one week where patients were refused 
AND the average patient satisfaction for that service was below the overall hospital average satisfaction. 
Show patient_id, name, service, and their personal satisfaction score.*/

SELECT p.patient_id,p.name,p.service,p.satisfaction AS patient_satisfaction
FROM patients p
WHERE p.service IN (
    -- Services with at least one week where patients were refused
    SELECT DISTINCT service FROM services_weekly WHERE patients_refused > 0)
AND p.service IN (
    -- Services with average satisfaction below overall hospital satisfaction
    SELECT service FROM services_weekly GROUP BY service
    HAVING AVG(patient_satisfaction) < (SELECT AVG(patient_satisfaction) FROM services_weekly)
				) ORDER BY p.service, p.patient_id;


