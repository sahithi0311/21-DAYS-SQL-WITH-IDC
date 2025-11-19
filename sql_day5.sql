### Day 5 (07/11): Aggregate Functions — COUNT, SUM, AVG, MIN, MAX
-- Topics: Aggregation and summarization concepts in SQL

### Practice Questions:
-- 1. Count the total number of patients in the hospital.
	select count(*) AS total_patients from patients;
-- 2. Calculate the average satisfaction score of all patients.
	select round(avg(satisfaction), 2) as avg_satisfaction from patients;
-- 3. Find the minimum and maximum age of patients.
	select min(age) as youngest_patient, max(age) as oldest_patient from patients;
### Day 5  Challenge:
-- Question: Calculate the total number of patients admitted,total patients refused, 
-- and the average patient satisfaction across all services and weeks (rounded to 2 decimals).	
		select sum(patients_admitted) as total_admitted,sum(patients_refused) as total_refused,
			   round(avg(patient_satisfaction), 2) as avg_satisfaction from services_weekly;
               