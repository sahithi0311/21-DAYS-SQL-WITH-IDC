use hospital;
### Day 1 (03/11): Introduction to SQL & SELECT Statement
-- Topics: Basic SELECT, column selection, viewing data structure

-- Practice 1 : Retrieve all columns from the patients table.
select * from patients;
-- Practice 2: Select only the patient_id, name, and age.
select patient_id, name, age from patients;
-- Practice 3: Display the first 10 records from the services_weekly table.
select * from services_weekly limit 10;

-- DAY 1  Challenge:
-- Question: List all unique hospital services available in the hospital.
select distinct service from patients order by service;

