### Day 19 (25/11): Window Functions - ROW_NUMBER, RANK, DENSE_RANK
-- Topics: ROW_NUMBER(), RANK(), DENSE_RANK(), OVER clause

### Practice Questions: 
-- 1. Rank patients by satisfaction score within each service. 
SELECT patient_id,name,service,satisfaction,RANK() OVER (PARTITION BY service ORDER BY satisfaction desc) AS satisfaction_rank
from patients ORDER BY service, satisfaction_rank;

-- 2. Assign row numbers to staff ordered by their name. 
SELECT staff_id,staff_name,role,service,ROW_NUMBER() OVER (ORDER BY staff_name) AS row_num from staff;

-- 3. Rank services by total patients admitted. 
SELECT service,SUM(patients_admitted) AS total_admitted,RANK() OVER (ORDER BY SUM(patients_admitted) DESC) AS service_rank
from services_weekly GROUP BY service ORDER BY service_rank;

/* Day 19 Challenge: For each service, rank the weeks by patient satisfaction score (highest first). 
Show service, week, patient_satisfaction, patients_admitted, and the rank.
 Include only the top 3 weeks per service.*/
 
 SELECT service,week,patient_satisfaction,patients_admitted,satisfaction_rank
from (SELECT service,week,patient_satisfaction,patients_admitted,
        RANK() OVER (PARTITION BY service ORDER BY patient_satisfaction DESC) AS satisfaction_rank
    from services_weekly
) AS ranked WHERE satisfaction_rank <= 3 ORDER BY service, satisfaction_rank, week;



