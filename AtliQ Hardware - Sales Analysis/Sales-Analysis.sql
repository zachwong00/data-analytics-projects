-- total sales transactions
SELECT 
	COUNT(*) AS total_transactions
FROM 
	sales.transactions 
	
-- All of Chennai sales data
SELECT
	*
FROM 
	sales.transactions 
WHERE 
	market_code = 'Mark001' 

SELECT
	COUNT(*) AS Chennai_sales -- total number of sales
FROM 
	sales.transactions 
WHERE 
	market_code = 'Mark001' 

SELECT
	COUNT(*) AS Chennai_USD_sales -- USD sales in Chennai
FROM 
	sales.transactions 
WHERE 
	currency = 'USD' 
	
-- 2020 sales data
SELECT 
	st.*,
	d.* 
FROM
	sales.transactions AS st
INNER JOIN
	sales.`date` AS d 
ON st.order_date = d.`date` 
WHERE 
	d.`year` = 2020
	
-- total revenue in 2020
SELECT 
	SUM(st.sales_amount) AS 2020_revenue
FROM
	sales.transactions AS st
INNER JOIN
	sales.`date` AS d 
ON st.order_date = d.`date` 
WHERE 
	d.`year` = 2020
	
-- Chennai total revenue in 2020
SELECT 
	SUM(st.sales_amount) AS 2020_Chennai_revenue
FROM
	sales.transactions AS st
INNER JOIN
	sales.`date` AS d 
ON st.order_date = d.`date` 
WHERE 
	d.`year` = 2020
AND 
	st.market_code = "Mark001"
	
-- Product types sold in Chennai
SELECT 
	DISTINCT product_code 
FROM 
	sales.transactions 
WHERE
	market_code = "Mark001"

-- Visualization: Removing negative & 0 sales amount + standardize currency into IDR
SELECT
	*,
	CASE 
		WHEN currency = "USD" THEN sales_amount*83.13 ELSE sales_amount
	END AS Normalized_Amount
FROM 
	sales.transactions 
WHERE 
	sales_amount >= 1