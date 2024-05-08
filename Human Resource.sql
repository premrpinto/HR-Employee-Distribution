-- Creating Database
CREATE DATABASE projects;

-- Creating Table
CREATE TABLE HR
(id int,	
 first_name varchar(50),
 last_name varchar (50),
 birthdate date,
 gender	varchar(50),
 race varchar(50),
 department varchar(50),	
 jobtitle varchar(50),	
 location varchar(50),
 hire_date date,
 termdate date,
 location_city varchar(50),
 location_state varchar(50));
 
SELECT * FROM HR
 
--1. What is the gender breakdown of employees in the comapny?		
SELECT gender, Count(gender) as Emp_by_gender
FROM HR
GROUP BY gender;

--2. What is the race/ethnicity breakdown of employees in the company?
 SELECT race, COUNT(race)
 FROM HR
 GROUP BY race
 ORDER BY count DESC;
 
 --3. What is the age distribution of employees in the company?
 SELECT MIN(age), MAX(age)
 FROM HR
 
SELECT
    CASE
    WHEN age>=21 AND age<=30 THEN '21-30'
    WHEN age>=31 AND age<=40 THEN '31-40'
    WHEN age>=41 AND age<=50 THEN '41-50'
    WHEN age>=51 AND age<=60 THEN '51-60'
	ELSE NULL
	END AS AGE_RANGE, COUNT(age) as Count_of_employees
FROM HR
GROUP BY AGE_RANGE
ORDER BY Count_of_employees DESC;	

--4. How many employees work at Headquarters vs Remote?
SELECT location, COUNT(location) AS Workplace
FROM HR
GROUP BY location
ORDER BY Workplace DESC;

--5.What is the average length of employment for employees who have been terminated?
SELECT ROUND(avg(len_emp)) as avg_length_of_empl
FROM (SELECT first_name, last_name, (termdate - hire_date)/365 as len_emp
FROM HR
WHERE termdate NOTNULL);

--6. How does the gender distribution vary across departments?
SELECT department, gender, count(gender)
FROM HR
GROUP BY gender, department
order by department;

--7.What is the distribution of job titles across the comapany?
SELECT jobtitle, count(jobtitle) as No_of_empl
FROM HR
GROUP BY jobtitle
ORDER BY No_of_empl DESC;

--8.Which department has the highest termination?
SELECT department, COUNT(hire_date) as Total_Count, count(termdate) as Total_terminated
FROM HR
GROUP BY department
ORDER BY total_terminated desc;

--9. What is the distribution of employees accross locations by city and state?
SELECT location_city, location_state, count(location) as No_of_employees
FROM HR
GROUP BY location, location_city, location_state
ORDER BY location_state;

-- Found total employees by state using Subqueries
SELECT location_state, SUM (no_of_employees) as Total_employees
FROM (SELECT location_city, location_state, count(location) as No_of_employees
FROM HR
GROUP BY location, location_city, location_state
ORDER BY location_state)
GROUP BY location_state;

--10. How has the company's employee count changed over time based on hire and termdates?

SELECT MIN(hire_date), MAX(hire_date)
FROM HR;

 
SELECT hire_date_range, Total_hire_date, Total_termination, Total_hire_date - Total_termination AS Count_Change
FROM (SELECT
CASE 
    WHEN hire_date >= '2000-10-17' AND hire_date <= '2005-12-31' THEN '2000 -2005'
    WHEN hire_date >= '2006-01-01' AND hire_date <= '2010-12-31' THEN '2006 -2010'
	WHEN hire_date >= '2011-01-01' AND hire_date <= '2015-12-31' THEN '2011 -2015'
    WHEN hire_date >= '2016-01-01' AND hire_date <= '2020-12-31' THEN '2016 -2020'
	END AS hire_date_range, COUNT(hire_date) as Total_hire_date, COUNT(termdate) as Total_termination
FROM HR
GROUP BY hire_date_range
ORDER BY hire_date_range);


--11. What is the tenure distribution of each department?

SELECT department, ROUND(avg(tenure_years)) AS Average_tenure
FROM
(SELECT department, tenure, EXTRACT(YEAR FROM tenure) as Tenure_years 
FROM 
(SELECT department, MIN(hire_date) as Min_date, MAX(hire_date)as Max_date, age((Max(hire_date)), (Min(hire_date))) as Tenure 
FROM HR
GROUP BY department
ORDER BY tenure))
Group by department;







