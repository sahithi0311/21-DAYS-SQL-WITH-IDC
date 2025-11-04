create database hospital character set utf8mb4 collate utf8mb4_general_ci;
USE hospital;

-- 1. Patients Table
CREATE TABLE patients (
    patient_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100),
    age INT,
    arrival_date DATE,
    departure_date DATE,
    service VARCHAR(50),
    satisfaction INT
);

-- 2. Services Weekly Table
CREATE TABLE services_weekly (
    week INT,
    month INT,
    service VARCHAR(50),
    available_beds INT,
    patients_request INT,
    patients_admitted INT,
    patients_refused INT,
    patient_satisfaction INT,
    staff_morale INT,
    event VARCHAR(100)
);

-- 3. Staff Table
CREATE TABLE staff (
    staff_id VARCHAR(50) PRIMARY KEY,
    staff_name VARCHAR(100),
    role VARCHAR(50),
    service VARCHAR(50)
);

-- 4. Staff Schedule Table
CREATE TABLE staff_schedule (
    week INT,
    staff_id VARCHAR(50),
    staff_name VARCHAR(100),
    role VARCHAR(50),
    service VARCHAR(50),
    present TINYINT(1),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);


-- To see the tables whether they are present are not.
USE hospital;
SHOW TABLES;
-- Confirming the each table structure
DESC patients;
DESC services_weekly;
DESC staff;
DESC staff_schedule;

-- Verifiying is it successfull or not.
USE hospital;
SELECT COUNT(*) FROM patients;
SELECT * FROM patients LIMIT 5;

-- Verfiying Tables
SHOW TABLES;
SELECT COUNT(*) FROM services_weekly;
SELECT COUNT(*) FROM staff;
select count(*) from staff_schedule;

### Day 1 (03/11): Introduction to SQL & SELECT Statement
-- Topics: Basic SELECT, column selection, viewing data structure

-- Practice 1 : Retrieve all columns from the patients table.
select * from patients;
-- Practice 2: Select only the patient_id, name, and age.
select patient_id, name, age from patients;
-- Practice 3: Display the first 10 records from the services_weekly table.
select * from services_weekly limit 10;






-- DAY 1 (Daily Challenge):
-- Question: List all unique hospital services available in the hospital.
select distinct service from patients order by service;


### Day 2 (04/11): Filtering Data with WHERE Clause
-- Topics: WHERE clause, comparison operators, basic filtering

-- Practice 1. Find all patients who are older than 60 years.
select * from patients where age > 60;
-- or
-- we can count the patients who are older than 60 years.
select count(*) from patients  where age > 60;
-- Practice 2. Retrieve all staff members who work in the 'Emergency' service.
select * from staff where service = "Emergency";
-- or
-- we can also count the staff members belongs to that service by using  COUNT.
select count(*) from staff where service = "Emergency";
-- Practice 3. List all weeks where more than 100 patients requested admission in any service.
select * from services_weekly where patients_request > 100;

-- To show only the week number and service for a concise view.
select week, service, patients_request from services_weekly where patients_request > 100 order by patients_request desc;

### DAY 2 Daily Challenge:
--  Find all patients admitted to 'Surgery' service with a satisfaction score below 70, showing their patient_id, name, age, and satisfaction score.

select patient_id, name, age, satisfaction from patients where service = 'Surgery' and satisfaction < 70;
-- or 
select patient_id, name, age, satisfaction from patients where service in ('Surgery') and satisfaction < 70;
-- or 
select patient_id, name, age, satisfaction from patients where service = 'Surgery' and satisfaction between 0 and 69;
-- or
select patient_id, name, age, satisfaction from patients where service = 'Surgery' and not satisfaction >= 70;



