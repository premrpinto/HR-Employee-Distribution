# HR Employee Distribution

## Table of Contents
- [Project Overview](#project-overview)
- [Data Sources](#data-sources)
- [Tools](#tools)
- [Data Cleaning](#data-cleaning)
- [Exploratory Data Analysis](#exploratory-data-analysis)
- [Data Analysis using SQL](#data-analysis-using-sql)
- [Results And Findings](#results-and-findings)
- [Limitations](#limitations)

### Project Overview
Utilizing a dataset on HR employee distribution, the project aims to optimize resource allocation through predictive modeling, enhancing workforce efficiency and organizational productivity.

### Data Sources
HR Employee distribution dataset [Download here](https://github.com/Irene-arch/HR-Dashboard-MySQL-PowerBI/blob/main/Human%20Resources.csv)

### Tools
- Excel   - Data Cleaning
- SQL     - Data Analysis
- PowerBi - Data visualization and dashboard

### Data Cleaning
In the initial data preparation phase, I performed the following tasks:
1. Data loading and inspection.
2. Handling missing values.
3. Data cleaning and formatting.

### Exploratory Data Analysis
EDA involved exploring the HR Employee distribution dataset to answer the key questions, such as:
- What is the gender breakdown of employees in the comapny?
- What is the race/ethnicity breakdown of employees in the company?
- How many employees work at Headquarters vs Remote?
- What is the average length of employment for employees who have been terminated?
- How does the gender distribution vary across departments?
- What is the distribution of job titles across the comapany?
- Which department has the highest termination?
- What is the distribution of employees accross locations by city and state?
- How has the company's employee count changed over time based on hire and termdates?
- What is the tenure distribution of each department?

### Data Analysis using SQL
What is the gender breakdown of employees in the comapny?
```SQL
SELECT gender, Count(gender) as Emp_by_gender
FROM HR
GROUP BY gender;
```

What is the race/ethnicity breakdown of employees in the company?
```SQL
 SELECT race, COUNT(race)
 FROM HR
 GROUP BY race
 ORDER BY count DESC;
```

What is the age distribution of employees in the company?
```SQL
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
```

How many employees work at Headquarters vs Remote?
```SQL
SELECT location, COUNT(location) AS Workplace
FROM HR
GROUP BY location
ORDER BY Workplace DESC;
```

What is the average length of employment for employees who have been terminated?
```SQL
SELECT ROUND(avg(len_emp)) as avg_length_of_empl
FROM (SELECT first_name, last_name, (termdate - hire_date)/365 as len_emp
FROM HR
WHERE termdate NOTNULL);
```

How does the gender distribution vary across departments?
```SQL
SELECT department, gender, count(gender)
FROM HR
GROUP BY gender, department
order by department;
```

What is the distribution of job titles across the comapany?
```SQL
SELECT jobtitle, count(jobtitle) as No_of_empl
FROM HR
GROUP BY jobtitle
ORDER BY No_of_empl DESC;
```

Which department has the highest termination?
```SQL
SELECT department, COUNT(hire_date) as Total_Count, count(termdate) as Total_terminated
FROM HR
GROUP BY department
ORDER BY total_terminated desc;
```

What is the distribution of employees accross locations by city and state?
```SQL
SELECT location_city, location_state, count(location) as No_of_employees
FROM HR
GROUP BY location, location_city, location_state
ORDER BY location_state;
```

How has the company's employee count changed over time based on hire and termdates?
```SQL
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
```

What is the tenure distribution of each department?
```SQL
SELECT department, ROUND(avg(tenure_years)) AS Average_tenure
FROM
(SELECT department, tenure, EXTRACT(YEAR FROM tenure) as Tenure_years 
FROM 
(SELECT department, MIN(hire_date) as Min_date, MAX(hire_date)as Max_date, age((Max(hire_date)), (Min(hire_date))) as Tenure 
FROM HR
GROUP BY department
ORDER BY tenure))
Group by department;
```
  
### Results and Findings
1. Majority of employees are males (11288) when compared to females (10321) .
2. People who identify as white where the highest (6328) where as Native Hawaiian or Other Pacific Islander where the lowest (1229)
3. Majority of employees are young within the age group 31 to 40 years old which is 6156.
4. Employees who work at the headquarters (16715) outnumber the ones who work remote (5499).
5. The average length of employement in the company is 10 years.
6. As per anaysis, I see the males outnumber females in every department and especially in the Engineering department which has the highest number of employees compared to others the male employees are the highest (3373) compared to females (3120).
7. Company has employeed 754 Research Assistant II followed by Business Analyst which is 708 employees. 
8. Most people who where terminated are from Engineering department with a total count of 1185 employees.
9. Cleveland, Ohio has the highest number of employees (16715).
10. From 2000 to 2005, the company has seen a highest employee count change  due to highest terminations. 
11. The tenure distribution of each department is 20 years.

### Limitations
- The date format was in dd/mm/yyyy and dd-mm-yyyy in the same column. Fixed structural errors.
- Converted the dates to numeric coulumn to find the difference in years.
- The termdate column contains null values. 
- Filtered unwanted outliers.
