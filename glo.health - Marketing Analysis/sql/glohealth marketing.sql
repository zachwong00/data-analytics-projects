/* glohealth marketing metrics of interest
 * Signup rates (signup/impressions)
 * Cost per signup (cost/signup)
 * Click through rates (clicks/impressions)
 * Cost per click (cost/click)
 */

/* Campaigns with signups (33 campaigns out of 57) */
WITH signups AS (
SELECT 
	ca.campaign_category,
	cu.campaign_id,
	COUNT(DISTINCT customer_id) AS signup_counts
FROM 
	glohealth.customers AS cu
JOIN
	glohealth.campaigns AS ca 
	ON cu.campaign_id = ca.campaign_id 
WHERE 
	cu.campaign_id IS NOT NULL
GROUP BY 
	1,2)
-- New table: campaign infos with marketing metrics 
SELECT
	ca.campaign_id,
	CONCAT(
		ca.campaign_category, '-',
		ca.campaign_type, '-',
		ca.platform) AS campaign_details,
	ca.cost,
	ca.impressions,
	ca.clicks,
	ca.days_run,
	sgn.signup_counts,
	CASE 
		WHEN sgn.signup_counts = 0 THEN NULL
		ELSE (sgn.signup_counts/ca.impressions)
	END AS signup_rates,
	CASE 
		WHEN sgn.signup_counts = 0 THEN NULL
		ELSE (ca.cost/sgn.signup_counts)
	END AS cost_per_signup,
	CASE 
		WHEN ca.clicks = 0 THEN NULL
		ELSE (ca.clicks/ca.impressions)
	END AS click_through_rates,
	CASE 
		WHEN ca.clicks = 0 THEN NULL
		ELSE (ca.cost/ca.clicks)
	END AS cost_per_click	
FROM 
	glohealth.campaigns AS ca
LEFT JOIN
	signups AS sgn
	ON ca.campaign_id = sgn.campaign_id
ORDER BY 
	campaign_id 

