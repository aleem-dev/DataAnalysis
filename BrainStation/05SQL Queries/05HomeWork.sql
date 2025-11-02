use hr_database;

select * from hrdata limit 10;

select `left`,avg(satisfaction_level) from hrdata group by `left`
union
select `left`,avg(last_evaluation) from hrdata group by `left`
union
select `left`,avg(number_project) from hrdata group by `left`;

select
	`left`,
    salary,
    promotion_last_5years,
    avg(satisfaction_level),
    avg(last_evaluation),
    avg(number_project),
    avg(average_monthly_hours),
    avg(time_spend_company)
from
	hrdata
group by
	`left`,
    salary,
    promotion_last_5years
order by
	`left`,
    salary;

-- group by along with agregrate function
SELECT promotion_last_5years, salary,AVG(satisfaction_level) as sat
FROM hrdata
GROUP BY salary, promotion_last_5years
order by promotion_last_5years, salary;
-- Thumb Rule: Every column in your SELECT clause that is not inside an aggregate function must appear in the GROUP BY.

-- create three buckets high performers, regular, churned vs stayed

-- * HR needs help on identifing key drivers for employee churn and how to resolve it **

/* Step 1: Understand the Business Problem
What decision needs to be made?

Who is the stakeholder?

What does “success” look like?

“HR wants to reduce churn among high performers. Success = actionable insights that reduce voluntary exits.”*/

/*🔹 Step 2: Define Metrics and Segments
What variables matter?

How do we define key groups (e.g., high performers)? High performers and regular

What are we measuring (e.g., churn rate, satisfaction)?

🧠 Example: Define high performers using evaluation, tenure, and project count.
-above average evaluation score
-have been with company for 4 years or more
-are engaged in 5 projects or more

as here there is condition based grouping required we need to use union instead of group by

/*🔹 Step 3: Explore the Data
Use descriptive stats: AVG(), COUNT(), MIN(), MAX()

Segment using GROUP BY

Create buckets using CASE WHEN or UNION

🧠 Example: Compare churned vs. retained employees across salary, department, and performance.*/

SELECT 'resigned' as status,
	'High Performer' AS bucket,
	salary,
    CASE 
		WHEN promotion_last_5years = 1 THEN 'Yes'
		ELSE 'No'
	END AS promoted,
    promotion_last_5years,
	AVG(satisfaction_level) AS avg_satisfaction,
	AVG(last_evaluation) AS avg_evaluation,
	AVG(number_project) AS avg_projects,
	AVG(average_monthly_hours) AS avg_hours,
	AVG(time_spend_company) AS avg_tenure
FROM hrdata
WHERE `left` = 1 AND (
  last_evaluation > (SELECT AVG(last_evaluation) FROM hrdata)
  OR time_spend_company >= 4
  OR number_project >= 5
)
group by salary, promotion_last_5years

UNION ALL

SELECT 
	'resigned' as status,
'Regular Employee' AS bucket,
	salary,
    CASE
		WHEN promotion_last_5years = 1 THEN 'Yes'
        ELSE 'No'
    End AS promoted,
    promotion_last_5years,
	AVG(satisfaction_level),
	AVG(last_evaluation),
	AVG(number_project),
	AVG(average_monthly_hours),
	AVG(time_spend_company)
FROM hrdata
WHERE `left` = 1 AND NOT (
  last_evaluation > (SELECT AVG(last_evaluation) FROM hrdata)
  OR time_spend_company >= 4
  OR number_project >= 5
)
group by salary,promotion_last_5years

union all

SELECT 'current_emp' as status,
	'High Performer' AS bucket,
	salary,
    CASE
		WHEN promotion_last_5years = 1 THEN 'Yes'
        ELSE 'No'
	END AS promoted,
    promotion_last_5years,
	AVG(satisfaction_level) AS avg_satisfaction,
	AVG(last_evaluation) AS avg_evaluation,
	AVG(number_project) AS avg_projects,
	AVG(average_monthly_hours) AS avg_hours,
	AVG(time_spend_company) AS avg_tenure
FROM hrdata
WHERE `left` = 0 AND (
  last_evaluation > (SELECT AVG(last_evaluation) FROM hrdata)
  OR time_spend_company >= 4
  OR number_project >= 5
)
group by salary, promotion_last_5years

UNION ALL

SELECT 
	'current_emp' as status,
	'Regular Employee' AS bucket,
	salary,
    CASE
		WHEN promotion_last_5years = 1 THEN 'Yes'
		Else 'No'
    END AS promoted,
    promotion_last_5years,
	AVG(satisfaction_level),
	AVG(last_evaluation),
	AVG(number_project),
	AVG(average_monthly_hours),
	AVG(time_spend_company)
FROM hrdata
WHERE `left` = 0 AND NOT (
  last_evaluation > (SELECT AVG(last_evaluation) FROM hrdata)
  OR time_spend_company >= 4
  OR number_project >= 5
)
group by salary,promotion_last_5years;


