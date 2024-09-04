/* Standardizing date formatting into YYYY-MM-DD */
UPDATE
	glohealth.claims
SET 
	claim_date = STR_TO_DATE (claim_date,'%m/%d/%y')
WHERE 
	claim_date IS NOT NULL;

UPDATE
	glohealth.customers 
SET 
	signup_date = STR_TO_DATE (signup_date ,'%m/%d/%y')
WHERE 
	signup_date IS NOT NULL;

/* Q1: 2020 Product claims */
-- CTE1: total monthly claims
WITH monthly_claims AS (
SELECT 
	EXTRACT(MONTH FROM claim_date) AS month,
	product_name,
	COUNT(product_name) AS monthly_total
FROM 
	glohealth.claims
WHERE 
	EXTRACT(YEAR FROM claim_date) = 2020
GROUP BY 
	1, 2),
-- CTE2: total monthly average claim by products in 2020
monthly_average AS (
SELECT 
	product_name,
	AVG(monthly_total) AS monthly_avg
FROM 
	monthly_claims
GROUP BY
	1)
SELECT
	c.product_name,
	MONTHNAME(c.claim_date) AS Month, -- changes corresponding %m number into names
	COUNT(c.product_name) AS monthly_claim,
	ma.monthly_avg
FROM 
	glohealth.claims AS c
JOIN
	monthly_average AS ma
ON
	c.product_name = ma.product_name
WHERE
	EXTRACT(YEAR FROM c.claim_date) = 2020
GROUP BY
	1, 2
ORDER BY 
	FIELD(Month,'January','February','March','April','May','June','July','August','September','October','November','December') -- sort into calendar order
	
/* Q2: Top hair products for June 2023 */
-- Assumption: "Top" being products with highest claim amount
SELECT
	product_name, 
	ROUND(SUM(claim_amount),2) AS june_claims 
FROM 
	glohealth.claims
WHERE 
	product_name LIKE 'Hair%' -- '%' returns any characters within the 'XXX'
	AND EXTRACT(YEAR FROM claims.claim_date) = 2023
	AND EXTRACT(MONTH FROM claims.claim_date) = 06
GROUP BY
	1
ORDER BY 
	june_claims DESC
	
/* Q3: Total number of claims made and claim amounts by state in 2023 */
SELECT 
	cu.state,
	COUNT(claim_id) AS total_claims_made,
	ROUND(SUM(claim_amount),2) AS total_claim_amt
FROM 
	glohealth.claims AS cl
JOIN
	glohealth.customers AS cu 
	ON cl.customer_id = cu.customer_id 
WHERE 
	EXTRACT(YEAR FROM cl.claim_date) = 2023
GROUP BY
	1
ORDER BY 
	2 DESC, 
	3 DESC

/* Q4: Total unique customers with a platinum plan who signed up in 2023, or customers who signed up in 2022 */
SELECT 
	COUNT(DISTINCT customer_id) AS total_customers
FROM
	glohealth.customers 
WHERE 
	(plan = 'platinum' AND YEAR(signup_date) = 2023) -- YEAR() equivalent syntax to EXTRACT(YEAR)
	OR YEAR(signup_date) = 2022 -- remove this for 2022 customers

/* Q5: Top 10 Customers with the most number of claims across all time (and their overall claim amount) */
WITH t10_customer AS (
SELECT 
	cu.customer_id, 
	COUNT(cl.claim_id) AS total_claims
FROM 
	glohealth.claims AS cl
JOIN
	glohealth.customers AS cu 
	ON cl.customer_id = cu.customer_id 
GROUP BY 
	1
ORDER BY 
	total_claims DESC
LIMIT 10)
-- Top 10 Customer overall claim amounts
SELECT
	SUM(claim_amount) AS total_claim_amt
FROM 
	glohealth.claims AS cl
JOIN
	t10_customer AS t
	ON cl.customer_id = t.customer_id

/* Q6: Overall average number of days between claims for customers with more than one claim */
-- CTE1: Find customers with >1 claim
WITH filter_customer AS (
SELECT 
	customer_id
FROM
	glohealth.claims
GROUP BY
	1
HAVING
	COUNT(claims.claim_id) > 1
	),
-- CTE2: Calculating the date between each previous claims for the customer
past_claim AS (
SELECT 
	customer_id,
	claim_date,
	-- create new date column to compare current date to previous date
	LAG(claims.claim_date) OVER (PARTITION BY claims.customer_id ORDER BY claims.claim_date) AS previous_claim_date 
FROM 
	glohealth.claims 
WHERE 
    claims.customer_id IN (SELECT customer_id FROM filter_customer) -- use only customer_id from the claims table based on CTE's customer_id
    ),  
-- CTE3: Avg number of days between each claim date for each filtered customer
customer_avg_days AS (
SELECT 
	past_claim.customer_id,
	AVG(DATEDIFF(past_claim.claim_date, past_claim.previous_claim_date)) AS avg_days_btwn
FROM 
	past_claim
WHERE 
	past_claim.previous_claim_date IS NOT NULL
GROUP BY 
	1
	)
-- Main Query: Calculate overall avg of the listed avg date difference from CTE3
SELECT 
	ROUND(AVG(avg_days_btwn)) AS overall_avg_days
FROM 
	customer_avg_days;

/* Q7: Most commonly claimed second product for customers with more than one claims */
-- CTE1: Find the ranking list of product claims by customers
WITH ranked_claims AS (
SELECT 
	customer_id,
	product_name,
	claim_id,
	ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY claim_date) AS claim_ranks
FROM 
	glohealth.claims
),
-- CTE2: Extract total claims for only the second ranked product claim
second_claims AS (
SELECT
	customer_id,
	product_name,
	COUNT(claim_id) AS claims_made
FROM 
	ranked_claims
WHERE 
	claim_ranks = 2 -- filters customers with the 2nd claim
GROUP BY 
	1, 2
)
-- Main Query: The total number of second claims made listed based on products
SELECT 
	product_name,
	COUNT(claims_made) AS total
FROM
	second_claims
GROUP BY
	1
ORDER BY 
	2 DESC