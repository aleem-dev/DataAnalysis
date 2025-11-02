CREATE SCHEMA test;
USE TEST;

CREATE TABLE customers (
	ID INT NOT NULL,
    NAME VARCHAR(20) NOT NULL,
    AGE INT,
    LOCATION CHAR(10),
    DISCOUNT DECIMAL(4,1),
    PRIMARY KEY (ID)
);

DESC customers;

INSERT INTO customers
VALUES
(1, "Angie", 29, "V4C 0C1", 2.0),
(3	, "Adam", 90, "V4B 0C4", 3.0);

SELECT * FROM customers;

CREATE TEMPORARY TABLE
test_temp_tbl AS
SELECT NAME, AGE
FROM customers
WHERE DISCOUNT >2;

SELECT * FROM test_temp_tbl;

# HR Data Sets import from CSV
# Create schema
# Create table
# Import CSV file from option

CREATE SCHEMA hr_database;
USE hr_database;

create table hrdata (
	id int not null,
    satisfaction_level double default null,
    last_evaluation double default null,
    number_project int default null,
    average_monthly_hours int default null,
    time_spend_company int default null,
    Work_accident int default null,
    `left` int default null,
    promotion_last_5years int default null,
    salea text default null,
    salary text default null,
    primary key (`id`)
);

-- What is overall average of working hours for high salary employees? Ans: 199.8674
SELECT avg(average_monthly_hours) as high_salary_working_avg_hours FROM HRDATA where salary = 'high';

-- How many people received a promotion in the last 5 years? Ans: 319
select distinct promotion_last_5years from hrdata;
select count(*) from hrdata where promotion_last_5years != 0;
select sum(promotion_last_5years) from hrdata;

-- Who are the ten employees with the most projects? Ans: id 54,75,2,135, 103, 61,43,56,73,105
select id, number_project from hrdata order by number_project desc limit 10;

-- What is the employee count by department?
select salea as department,count(*) as number_of_employees from hrdata group by salea order by number_of_employees desc;

-- High performing employees
	-- Above average evaluation score
    -- Have been with company for 4 years or more
    -- Are engaged in 5 projects or more
-- Declare @avg_score float;
-- set @avg_score = Select avg(last_evaluation) as avg_rating from hrdata;

Select avg(last_evaluation) as avg_rating from hrdata;

-- 10149
create Temporary table
	tmp_left_highperf
Select
	`left`, count(*) as count_employee
From
	hrdata
Where
	(last_evaluation > 0.7161017401159978
    or
    time_spend_company >= 4
    or
    number_project >= 5)
	AND
	`left` = 1
group by
	`left`
;
-- employees left
select `left`,count(*) from hrdata group by `left`;

;
-- Not able to solve this
-- select left, count(left) from hrdata group by left;
-- SELECT 
--   left AS employee_status,
--   COUNT(*) AS total_employees
-- FROM hrdata
-- GROUP BY left;

-- avg or mean, median of last_evaluation
Select avg(last_evaluation) from hrdata;
-- Select median(last_evaluation) from hrdata;

-- ****** Solution by Sam ********
-- overal company
SELECT 
    'overal' AS bucket,
    salary,
	avg(satisfaction_level) AS satisfaction_level_avg,
    variance(satisfaction_level) AS satisfaction_level_var,
    avg(last_evaluation) AS last_evaluation_avg,
    variance(last_evaluation) AS last_evaluation_var,
    avg(number_project) AS number_project_avg,
    variance(number_project) AS number_project_var,
    avg(average_montly_hours) AS average_montly_hours_avg,
    variance(average_montly_hours) AS average_montly_hours_var,
    avg(time_spend_company) AS time_spend_company_avg,
    variance(time_spend_company) AS time_spend_company_var,
    avg(Work_accident) AS Work_accident_avg,
    variance(Work_accident) AS Work_accident_var,
    avg(promotion_last_5years) AS promotion_last_5years_avg,
    variance(promotion_last_5years) AS promotion_last_5years_var
FROM hrdata
GROUP BY salary

UNION ALL
-- high performers
SELECT 
    'high performer' AS bucket,
    salary,
	avg(satisfaction_level) AS satisfaction_level_avg,
    variance(satisfaction_level) AS satisfaction_level_var,
    avg(last_evaluation) AS last_evaluation_avg,
    variance(last_evaluation) AS last_evaluation_var,
    avg(number_project) AS number_project_avg,
    variance(number_project) AS number_project_var,
    avg(average_montly_hours) AS average_montly_hours_avg,
    variance(average_montly_hours) AS average_montly_hours_var,
    avg(time_spend_company) AS time_spend_company_avg,
    variance(time_spend_company) AS time_spend_company_var,
    avg(Work_accident) AS Work_accident_avg,
    variance(Work_accident) AS Work_accident_var,
    avg(promotion_last_5years) AS promotion_last_5years_avg,
    variance(promotion_last_5years) AS promotion_last_5years_var
FROM hrdata
WHERE
	last_evaluation> (SELECT avg(last_evaluation) FROM hrdata)
    OR time_spend_company >= 4
    OR number_project >= 5
GROUP BY salary

UNION ALL
-- not high performers
SELECT 
    'not high performer' AS bucket,
    salary,
	avg(satisfaction_level) AS satisfaction_level_avg,
    variance(satisfaction_level) AS satisfaction_level_var,
    avg(last_evaluation) AS last_evaluation_avg,
    variance(last_evaluation) AS last_evaluation_var,
    avg(number_project) AS number_project_avg,
    variance(number_project) AS number_project_var,
    avg(average_montly_hours) AS average_montly_hours_avg,
    variance(average_montly_hours) AS average_montly_hours_var,
    avg(time_spend_company) AS time_spend_company_avg,
    variance(time_spend_company) AS time_spend_company_var,
    avg(Work_accident) AS Work_accident_avg,
    variance(Work_accident) AS Work_accident_var,
    avg(promotion_last_5years) AS promotion_last_5years_avg,
    variance(promotion_last_5years) AS promotion_last_5years_var
FROM hrdata
WHERE
	last_evaluation <= (SELECT avg(last_evaluation) FROM hrdata)
    OR time_spend_company < 4
    OR number_project < 5
GROUP BY salary

UNION ALL
-- left
SELECT 
    'left' AS bucket,
    salary,
	avg(satisfaction_level) AS satisfaction_level_avg,
    variance(satisfaction_level) AS satisfaction_level_var,
    avg(last_evaluation) AS last_evaluation_avg,
    variance(last_evaluation) AS last_evaluation_var,
    avg(number_project) AS number_project_avg,
    variance(number_project) AS number_project_var,
    avg(average_montly_hours) AS average_montly_hours_avg,
    variance(average_montly_hours) AS average_montly_hours_var,
    avg(time_spend_company) AS time_spend_company_avg,
    variance(time_spend_company) AS time_spend_company_var,
    avg(Work_accident) AS Work_accident_avg,
    variance(Work_accident) AS Work_accident_var,
    avg(promotion_last_5years) AS promotion_last_5years_avg,
    variance(promotion_last_5years) AS promotion_last_5years_var
FROM hrdata
WHERE `left` = 1
GROUP BY salary

UNION ALL
-- stayed
SELECT 
    'stayed' AS bucket,
    salary,
	avg(satisfaction_level) AS satisfaction_level_avg,
    variance(satisfaction_level) AS satisfaction_level_var,
    avg(last_evaluation) AS last_evaluation_avg,
    variance(last_evaluation) AS last_evaluation_var,
    avg(number_project) AS number_project_avg,
    variance(number_project) AS number_project_var,
    avg(average_montly_hours) AS average_montly_hours_avg,
    variance(average_montly_hours) AS average_montly_hours_var,
    avg(time_spend_company) AS time_spend_company_avg,
    variance(time_spend_company) AS time_spend_company_var,
    avg(Work_accident) AS Work_accident_avg,
    variance(Work_accident) AS Work_accident_var,
    avg(promotion_last_5years) AS promotion_last_5years_avg,
    variance(promotion_last_5years) AS promotion_last_5years_var
FROM hrdata
WHERE `left` != 1
GROUP BY salary

