### Day 20 (26/11) : Window Functions - Aggregate Window Functions
-- Topics: SUM() OVER, AVG() OVER, running totals, moving averages.### Practice Questions:

-- 1. Calculate running total of patients admitted by week for each service.
SELECT service,week,patients_admitted, 
SUM(patients_admitted) OVER (PARTITION BY service ORDER BY week) AS running_total_admitted
FROM services_weekly ORDER BY service, week;

-- 2. Find the moving average of patient satisfaction over 4-week periods.
SELECT service,week,patient_satisfaction,AVG(patient_satisfaction) OVER (PARTITION BY service ORDER BY week ROWS 3 PRECEDING) AS moving_avg_4_week
FROM services_weekly ORDER BY service, week;

-- 3. Show cumulative patient refusals by week across all services.
SELECT week,
    SUM(patients_refused) AS weekly_refused,
    SUM(SUM(patients_refused)) OVER (ORDER BY week) AS cumulative_refusals
FROM services_weekly GROUP BY week ORDER BY week;

/* Day 20 Challenge: Create a trend analysis showing for each service and week: 
week number, patients_admitted, running total of patients admitted (cumulative), 
3-week moving average of patient satisfaction (current week and 2 prior weeks), 
and the difference between current week admissions and the service average. Filter for weeks 10-20 only.
*/
SELECT service,week,patients_admitted,SUM(patients_admitted) OVER (PARTITION BY service ORDER BY week) AS cumulative_admitted,
AVG(patient_satisfaction) OVER (PARTITION BY service ORDER BY week ROWS 2 PRECEDING) AS moving_avg_3week_sat,
patients_admitted - AVG(patients_admitted) OVER (PARTITION BY service) AS diff_from_avg
FROM services_weekly WHERE week BETWEEN 10 AND 20 ORDER BY service, week;
