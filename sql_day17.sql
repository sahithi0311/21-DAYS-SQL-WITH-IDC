### Day 17 (22/11): Subqueries (SELECT and FROM clause)
-- Topics: Subqueries in SELECT, derived tables, inline views.

### Practice Questions:
-- 1. Show each patient with their service's average satisfaction as an additional column.
SELECT p.patient_id,p.name,p.service,p.satisfaction,
    (SELECT AVG(p2.satisfaction) FROM patients p2 WHERE p2.service = p.service
    ) AS service_avg_satisfaction FROM patients p;

-- 2. Create a derived table of service statistics and query from it.
SELECT service,total_admitted,avg_satisfaction FROM (
    SELECT service,SUM(patients_admitted) AS total_admitted,
        AVG(patient_satisfaction) AS avg_satisfaction
    FROM services_weekly GROUP BY service
) AS service_stats ORDER BY total_admitted DESC;

-- 3. Display staff with their service's total patient count as a calculated field.
SELECT s.staff_id,s.staff_name,s.role,s.service,
    (SELECT COUNT(*) FROM patients p WHERE p.service = s.service
    ) AS total_patients_in_service
FROM staff s ORDER BY total_patients_in_service DESC;

/* Day 17 Challenge: Create a report showing each service with: service name, total patients admitted, 
the difference between their total admissions and the average admissions across all services, 
and a rank indicator ('Above Average', 'Average', 'Below Average').Order by total patients admitted descending.*/
-- Step 1: Derived table with total admissions and avg admissions
SELECT service,total_admitted,total_admitted - overall_avg AS diff_from_average,
    CASE 
        WHEN total_admitted > overall_avg THEN 'Above Average'
        WHEN total_admitted = overall_avg THEN 'Average'
        ELSE 'Below Average'
    END AS performance_rank
FROM (
    SELECT service,
        SUM(patients_admitted) AS total_admitted,(SELECT AVG(total_service_admissions) FROM (SELECT SUM(patients_admitted) AS total_service_admissions 
        FROM services_weekly GROUP BY service) AS avg_table) AS overall_avg FROM services_weekly 
        GROUP BY service) AS final_table ORDER BY total_admitted DESC;
