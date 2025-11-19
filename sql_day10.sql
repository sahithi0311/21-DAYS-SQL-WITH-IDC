### Day 10 (13/11): CASE Statements
-- Topics: CASE WHEN, conditional logic, derived columns

### Practice Questions:
-- 1. Categorise patients as 'High', 'Medium', or 'Low' satisfaction based on their scores.
SELECT patient_id, name, satisfaction,
    CASE
        WHEN satisfaction >= 85 THEN 'High'
        WHEN satisfaction BETWEEN 70 AND 84 THEN 'Medium'
        ELSE 'Low'
    END AS satisfaction_category FROM patients;

-- 2. Label staff roles as 'Medical' or 'Support' based on role type.
SELECT staff_id, staff_name, role,
CASE
	WHEN role in ('Doctor', 'Nurse','Surgeon' 'Theropist') THEN 'Medical'
	ELSE 'Support'
END AS role_category
FROM staff;

-- 3. Create age groups for patients (0-18, 19-40, 41-65, 65+).
SELECT patient_id,name,age,
    CASE
        WHEN age <= 18 THEN 'Child'
        WHEN age BETWEEN 19 AND 40 THEN 'Adult'
        WHEN age BETWEEN 41 AND 65 THEN 'Middle-Age'
        ELSE 'Senior'
    END AS age_group
FROM patients;

/* Day 10: Challenge:Create a service performance report showing service name, total patients admitted, and a performance category based on the following: 
'Excellent' if avg satisfaction >= 85, 
'Good' if >= 75, 'Fair' if >= 65, otherwise 'Needs Improvement'.
 Order by average satisfaction descending. */

SELECT service,
    COUNT(patient_id) AS total_patients,
    ROUND(AVG(satisfaction), 2) AS avg_satisfaction,
    CASE
        WHEN AVG(satisfaction) >= 85 THEN 'Excellent'
        WHEN AVG(satisfaction) >= 75 THEN 'Good'
        WHEN AVG(satisfaction) >= 65 THEN 'Fair'
        ELSE 'Needs Improvement'
    END AS performance_category
FROM patients GROUP BY service ORDER BY avg_satisfaction DESC;

