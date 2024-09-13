/* Q1: Which month has the highest subscription count in 2020 and 2021? */
SELECT 
	COUNT(DISTINCT USER_ID)AS sub_count,
	MONTH,
	YEAR
FROM 
	zoomsubs.zoomsubs_clean
GROUP BY
	2,3
ORDER BY 
	sub_count DESC; 

/* Q2: Top 5 Countries by Subscription Sale (in USD) */
SELECT
	FULL_COUNTRY_NAME,
	ROUND(SUM(PRICE_REVISED),2) AS sub_sale
FROM 
	zoomsubs.zoomsubs_clean 
GROUP BY
	1
ORDER BY 
	sub_sale DESC 
LIMIT 5;

/* Q3: Monthly Sales by Plan Type (in USD) */
SELECT 
	MONTHNAME(SUB_START_DATE) AS MONTH,
	YEAR,
	PLAN,
	ROUND(SUM(PRICE_REVISED),2) AS monthly_sales
FROM 
	zoomsubs.zoomsubs_clean 
GROUP BY 
	1,2,3
ORDER BY 
	3 DESC,
	4 DESC

/* Q4: Number of Subscribers by Plan and Region */
SELECT 
	REGION,
	REGION_DETAIL,
	PLAN,
	COUNT(DISTINCT USER_ID) AS num_of_subs
FROM 
	zoomsubs.zoomsubs_clean
GROUP BY
	1,2,3
ORDER BY 
	4 DESC

/* Q5: Subscription Growth by Quarter */
-- CTE1: Find Subs based on year and quarter
WITH QuarterlySubs AS (
SELECT
	YEAR,
	QUARTER,
	COUNT(USER_ID) AS num_of_subs
FROM 
	zoomsubs_clean
GROUP BY
	1,2
ORDER BY 
	1,2),
-- CTE2: Include Previous Subs into each following quarters
QuarterSubs_with_Previous_Subs AS (
SELECT
	*,
	LAG(num_of_subs) OVER (ORDER BY YEAR, QUARTER) AS prev_Q_subs
FROM
	QuarterlySubs)
-- Main Query: Calculate Sub Growth
SELECT
	*,
	ROUND(((num_of_subs - prev_Q_subs)/prev_Q_subs)*100,2) AS Sub_growth
FROM
	QuarterSubs_with_Previous_Subs

/* Q6: Average Subscription Sales by Region and Quarter */
SELECT 
	YEAR,
	QUARTER,
	REGION,
	REGION_DETAIL,
	ROUND(AVG(PRICE_REVISED),2) AS avg_sub_sales
FROM 
	zoomsubs.zoomsubs_clean 
GROUP BY
	1,2,3,4
ORDER BY 
	1,2
	
/* Q7: Monthly New Subscribers and Revenue Growth */
-- CTE1: Sub Counts and Revenue sorted by year and month
WITH MonthlyData AS (
SELECT 
	YEAR,
	MONTH,
	COUNT(DISTINCT USER_ID) AS new_sub_count,
	ROUND(SUM(PRICE_REVISED),2) AS revenue
FROM 
	zoomsubs.zoomsubs_clean 
GROUP BY
	1,2
ORDER BY 
	1,2),
-- CTE2: Use LAG window function to include previous month's revenue
MonthlyData_prev AS (
SELECT 
	*,
	LAG(revenue) OVER (ORDER BY YEAR,MONTH) AS prev_month_revenue
FROM
	MonthlyData)
-- Main Query: Calculate Revenue Growth
SELECT
	*,
	ROUND(((revenue-prev_month_revenue)/prev_month_revenue)*100,2) AS revenue_growth
FROM
	MonthlyData_prev

/* Q8: Total Sales and Number of Subscribers by Year and Plan */
SELECT 
	YEAR,
	PLAN,
	ROUND(SUM(PRICE_REVISED),2) AS total_sales,
	COUNT(DISTINCT USER_ID) AS num_of_subs
FROM 
	zoomsubs.zoomsubs_clean 
GROUP BY 
	1,2
ORDER BY 
	3 DESC, 
	4 DESC

/* Q9: Who are the Subscribed users with the highest price for each plan type and period? */
-- CTE: Max prices within each plan type and period 
WITH maxprice AS (
SELECT 
	PLAN,
	PERIOD,
	MAX(PRICE_REVISED) AS price
FROM 
	zoomsubs.zoomsubs_clean
GROUP BY
	1,2)
-- Main Query: Finding user_id that matched with the max price plan and period
SELECT 
	zc.USER_ID,
	zc.PLAN,
	zc.PERIOD,
	zc.PRICE_REVISED AS sub_price
FROM 
	zoomsubs.zoomsubs_clean AS zc
JOIN -- inner join only users that fit maxprice's table values
	maxprice AS mp
	ON zc.PLAN = mp.PLAN
	AND zc.PERIOD = mp.PERIOD
	AND zc.PRICE_REVISED = mp.price;
