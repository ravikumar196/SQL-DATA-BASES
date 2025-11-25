Create database Hospital;
use Hospital;

select * from Hospital_data;

Describe hospital_data;

-- UPDATE the columns constraints or data types
SET SQL_SAFE_UPDATES = 0;

-- Correct format of Date "%d-%m-%y"
UPDATE Hospital_data
SET Admission_date = str_to_date(Admission_date, "%d-%m-%y"),
Discharge_date = str_to_date(Discharge_date, "%d-%m-%y");

-- CHANGE TEXT TO DATE types 
ALTER TABLE Hospital_data
Modify column Admission_date DATE;

ALTER TABLE Hospital_data
Modify column Discharge_date DATE;

-- Describe the column names and data types in each column
DESCRIBE HOSPITAL_DATA;

-- RENAME the Column name for support in MYSQL

ALTER TABLE Hospital_data
RENAME COLUMN `﻿Hospital Name` to Hospital_name,
Rename COLUMN `Doctors Count` to Doctores_Count,
Rename COLUMN `Patients Count` to Patients_count,
Rename COLUMN `Admission Date` to Admission_date,
Rename COLUMN `Discharge Date` to Discharge_date,
Rename COLUMN `Medical Expenses` to Medical_Expenses;


/*1. Total Number of Patients*/
-- Q. Write a SQL Query to find the total number of patients acrosss all hospitals.
SELECT sum(Patients_count) AS Total_Patients
FROM hospital_data;


/* Average numbers of Doctores per Hospital*/
-- Q2: Retrive the Average count of doctors availabe in each Hospital;
select avg(Doctores_count) As Avg_doc_per_hospital 
from Hospital_data;

/* Top 3 Departments with the Highest Number of Patients 
Q3:  Find the top 3 hospital departments that have the highest number of patients.*/
SELECT Hospital_name, Patients_count FROM Hospital_data
ORDER BY Patients_count DESC 
Limit 3;

/* Hospital with the Maximum Medical Expenses 
Q4: Identify the hospital that recorded the highest medical expenses.*/

select Hospital_name, Location, Medical_expenses 
from Hospital_data
Order by Medical_expenses Desc limit 1;


/*Daily Average Medical Expenses 
Q5: Calculate the average medical expenses per day for each hospital.*/
SELECT 
    Hospital_name,  location,
    SUM(Medical_expenses) AS Total_expenses,
    SUM(DATEDIFF(discharge_date, admission_date)) AS Total_days,
    SUM(Medical_expenses) / SUM(DATEDIFF(discharge_date, admission_date)) 
        AS Avg_expense_per_day
FROM 
    Hospital_data
GROUP BY 
    Hospital_name, location;


select Medical_expenses, DateDiff( Discharge_date, Admission_date) AS Number_of_days
 from Hospital_data;

select * from Hospital_data;


/*
 Longest Hospital Stay 
Q6: Find the patient with the longest stay by calculating the difference between 
Discharge Date and Admission Date.*/

select DateDiff( Discharge_date, Admission_date) AS Number_of_days
 from Hospital_data
 order by DateDiff( Discharge_date, Admission_date) desc 
 limit 1;

 
/*
Total Patients Treated Per City 
Q7: Count the total number of patients treated in each city.
*/ 
select location, sum(patients_count) As Total_Patients from hospital_data
group by location;

/*
Average Length of Stay Per Department 
Q8: Calculate the average number of days patients spend in each department. 
*/
select Department, avg(datediff(Discharge_date, Admission_date)) AS Avg_days_stay_each_department 
from Hospital_data
group by Department;

/*
Identify the Department with the Lowest Number of Patients 
Q9: Find the department with the least number of patients.
*/

select department, sum(Patients_count) AS Patients 
from Hospital_data
group by Department 
order by Department ASC Limit 1;

/*
Q10: Monthly Medical Expenses Report 
• Group the data by month and calculate the total medical expenses for each month.
*/
SELECT 
    DATE_FORMAT(admission_date, '%Y-%m') AS Month,
    SUM(Medical_expenses) AS Total_Medical_Expenses
FROM Hospital_data
GROUP BY DATE_FORMAT(admission_date, '%Y-%m')
ORDER BY Month;




SELECT * FROM hospital_data;
