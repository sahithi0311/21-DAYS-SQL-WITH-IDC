### Day 21 (27/11): Common Table Expressions (CTEs)
-- Topics: WITH clause, CTEs, recursive CTEs (if applicable), query organization.### Practice Questions:

-- 1. Create a CTE to calculate service statistics, then query from it.
WITH service_stats AS (
    select service,
        sum(patients_admitted) as total_admissions,
        sum(patients_refused) as total_refusals,
        avg(patient_satisfaction) as avg_satisfaction
    from services_weekly group by service)
select * from service_stats;

-- 2. Use multiple CTEs to break down a complex query into logical steps.
WITH admissions AS (
    select service, SUM(patients_admitted) AS total_admissions from services_weekly group by service),
satisfaction as (select service, avg(patient_satisfaction) as avg_satisfaction from services_weekly group by service)
select a.service,a.total_admissions,s.avg_satisfaction from admissions as a join satisfaction as s using (service);

-- 3. Build a CTE for staff utilization and join it with patient data.
WITH staff_util AS (
    SELECT service,COUNT(staff_id) AS total_staff,AVG(weeks_present) AS avg_weeks_present
    FROM (SELECT s.staff_id,s.service,COUNT(ss.week) AS weeks_present
        FROM staff as s
        LEFT JOIN staff_schedule as ss
            ON s.staff_id = ss.staff_id GROUP BY s.staff_id, s.service
    ) AS x GROUP BY service)
select su.service,su.total_staff,su.avg_weeks_present from staff_util su;

/* Day 21 Challenge: Create a comprehensive hospital performance dashboard using CTEs. Calculate: 
1) Service-level metrics (total admissions, refusals, avg satisfaction), 
2) Staff metrics per service (total staff, avg weeks present), 3) Patient demographics per service (avg age, count). 
Then combine all three CTEs to create a final report showing service name, all calculated metrics, and an overall performance score 
(weighted average of admission rate and satisfaction).Order by performance score descending.
*/
WITH service_metrics AS (SELECT service,
        SUM(patients_admitted) AS total_admissions,
        SUM(patients_refused) AS total_refusals,
        AVG(patient_satisfaction) AS avg_satisfaction,
        (SUM(patients_admitted) / SUM(patients_request)) * 100 AS admission_rate
    FROM services_weekly GROUP BY service), staff_metrics AS (SELECT s.service,COUNT(s.staff_id) AS total_staff,AVG(ss.present) AS avg_weeks_present
    FROM staff as s LEFT JOIN staff_schedule as ss ON s.staff_id = ss.staff_id GROUP BY s.service),
patient_demographics AS (SELECT service,AVG(age) AS avg_age,COUNT(patient_id) AS total_patients FROM patients GROUP BY service)
SELECT sm.service,sm.total_admissions,sm.total_refusals,sm.avg_satisfaction,sm.admission_rate,stm.total_staff,stm.avg_weeks_present,
    pd.avg_age,pd.total_patients,
    -- Overall Performance Score = 60% Satisfaction + 40% Admission Rate
    ( (sm.avg_satisfaction * 0.6) + (sm.admission_rate * 0.4) ) AS performance_score
FROM service_metrics as sm LEFT JOIN staff_metrics as stm ON sm.service = stm.service
LEFT JOIN patient_demographics pd ON sm.service = pd.service ORDER BY performance_score DESC;
