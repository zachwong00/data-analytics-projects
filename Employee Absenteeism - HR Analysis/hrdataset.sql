-- Create a JOIN table
SELECT 
	*
FROM 
	da2024.Absenteeism_at_work AS aaw
LEFT JOIN
	da2024.compensation AS comp
ON 
	aaw.ID = comp.ID 
LEFT JOIN
	da2024.Reasons AS r
ON
	aaw.`Reason for absence` = r.`Number` 

/* Find the healthiest employees (no drink, no smoke, healthy BMI) with low absenteeism
	for the employee wellness program */
SELECT 
	*
FROM 
	da2024.Absenteeism_at_work 
WHERE
	`Social drinker` = 0
	AND `Social smoker` = 0
	AND `Body mass index` < 25
	AND `Absenteeism time in hours` < (SELECT 
			AVG(`Absenteeism time in hours`)
		 FROM 
			da2024.Absenteeism_at_work )

-- Finding no. of non-smoker employees for wage/compensation increase
SELECT 
  COUNT(*) AS non_smoker
FROM 
  da2024.Absenteeism_at_work 
WHERE 
  `Social smoker` = 0

/* Wage/compensation increase (Budget: 983,221) 
 * 8 hrs (9 am - 5 pm), 5 work days: 5 days * 8 hrs = 40 hours per week
 * Total hours in a year: 40 hrs * 52 weeks = 2080 hrs per employee
 * Total hours for non-smoker employees: 2080*686 employees = 1,426,880 hrs
 * Budget/Total non-smoker employees hour: 983221/1426880 = 0.689 cents per hr
 * Annual compensation increase: 0.689cents * 2080hrs = 1,414.40 per year
 */
  
-- Optimizing query for visualization
SELECT 
	aaw.ID,
	r.Reason,
	`Month of absence`,
	`Body mass index`,
	CASE
		WHEN `Body mass index` < 18.5 THEN 'Underweight'
		WHEN `Body mass index` BETWEEN 18.5 AND 25 THEN 'Normal Weight'
		WHEN `Body mass index` BETWEEN 25 AND 29.9 THEN 'OverWeight'
		WHEN `Body mass index` >= 30 THEN 'Obesity'
		ELSE 'Unknown'
	END AS BMI_Category,
	CASE
		WHEN `Month of absence` IN (1,2,3) THEN 'Q1'
		WHEN `Month of absence` IN (4,5,6) THEN 'Q2'
		WHEN `Month of absence` IN (7,8,9) THEN 'Q3'
		WHEN `Month of absence` IN (10,11,12) THEN 'Q4'
		ELSE 'Unknown'
	END AS Fiscal_Quarter,
	`Day of the week`,
	Seasons,
	`Transportation expense`,
	Education,
	Son,
	CASE
		WHEN `Social drinker`= 1 THEN 'Yes'
		WHEN `Social drinker`= 0 THEN 'No'
		ELSE 'Unknown'
	END AS Social_drinker,
	CASE
		WHEN `Social smoker`= 1 THEN 'Yes'
		WHEN `Social smoker`= 0 THEN 'No'
		ELSE 'Unknown'
	END AS Social_smoker,
	Pet,
	`Disciplinary failure`,
	Age,
	`Work load Average/day`,
	`Absenteeism time in hours` 
FROM 
	da2024.Absenteeism_at_work AS aaw
LEFT JOIN
	da2024.compensation AS comp
ON 
	aaw.ID = comp.ID 
LEFT JOIN
	da2024.Reasons AS r
ON
	aaw.`Reason for absence` = r.`Number` 
	
-- Education Count
SELECT 
	Education,
	COUNT(*) AS Total_Education_Count
FROM 
  da2024.Absenteeism_at_work
GROUP BY
	Education 
	
-- pet Count
SELECT 
	Pet,
	COUNT(*) AS Total_Pet_Count
FROM 
  da2024.Absenteeism_at_work
GROUP BY
	Pet 

-- pet Count
SELECT 
	Pet,
	COUNT(*) AS Total_Pet_Count
FROM 
  da2024.Absenteeism_at_work
GROUP BY
	Pet 

-- Children Count
SELECT 
	Son,
	COUNT(*) AS Total_Child_Count
FROM 
  da2024.Absenteeism_at_work
GROUP BY
	Son
	
-- BMI Count
SELECT 
	CASE
		WHEN `Body mass index` < 18.5 THEN 'Underweight'
		WHEN `Body mass index` BETWEEN 18.5 AND 25 THEN 'Normal Weight'
		WHEN `Body mass index` BETWEEN 25 AND 29.9 THEN 'Overweight'
		WHEN `Body mass index` >= 30 THEN 'Obesity'
		ELSE 'Unknown'
	END AS BMI_Category,
	COUNT(*) AS Total_BMI_Count
FROM 
  da2024.Absenteeism_at_work
GROUP BY
	BMI_Category 
	
-- Line graph: Monthly absenteeism hours
SELECT 
	`Month of absence`,
	COUNT(`Absenteeism time in hours`) AS absenteeism_hours
FROM 
  da2024.Absenteeism_at_work
GROUP BY
	`Month of absence`
ORDER BY
	`Month of absence`

-- Line graph: Daily absenteeism hours
SELECT 
	`Day of the week` ,
	COUNT(`Absenteeism time in hours`) AS absenteeism_hours
FROM 
  da2024.Absenteeism_at_work
GROUP BY
	`Day of the week` 
ORDER BY
	absenteeism_hours DESC