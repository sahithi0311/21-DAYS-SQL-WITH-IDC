use hospital;

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
