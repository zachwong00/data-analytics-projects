/* Cleaning up data */
UPDATE
	zoomsubs.exchange_rates 
SET 
	CURRENCY = UPPER(CURRENCY)
	
UPDATE 
	zoomsubs.exchange_rates 
SET 
	`DATE` = DATE_FORMAT(`DATE`,'%d/%m/%Y') 
	
UPDATE 
	zoomsubs.exchange_rates  
SET 
	`DATE` = DATE_FORMAT(STR_TO_DATE(`DATE`, '%d/%m/%Y'), '%Y/%m/%d') 
	
UPDATE 
	zoomsubs.daily_subs 
SET 
	SUB_START_TS = DATE_FORMAT(STR_TO_DATE(SUB_START_TS, '%d/%m/%Y'), '%Y/%m/%d'),
	SUB_END_TS = DATE_FORMAT(STR_TO_DATE(SUB_END_TS, '%d/%m/%Y'), '%Y/%m/%d')
	
ALTER TABLE
	zoomsubs.daily_subs 
DROP Column10, 
DROP Column11, 
DROP Column12,
DROP Column13
	
/* Step 1: Validate input data */
SELECT 
	*
FROM 
	zoomsubs.daily_subs 

SELECT 
	*
FROM 
	zoomsubs.geo_lookup 

SELECT 
	*
FROM 
	zoomsubs.exchange_rates  

/* Step 2: Add additional date columns + subscription details*/
CREATE TEMPORARY TABLE zoomsubs.daily_subs_clean AS (
	SELECT
		USER_ID,
		SUB_START_TS AS SUB_START_DATE,
		DAY(SUB_START_TS)AS DAY,
		MONTH(SUB_START_TS)AS MONTH,
		YEAR(SUB_START_TS)AS YEAR,
		QUARTER(SUB_START_TS)AS QUARTER,
		PLAN,
		PERIOD,
		CONCAT(PLAN,' ', PERIOD) AS SUB_DETAILS,
		LOCAL_PRICE,
		PRICE_USD,
		CURRENCY,
		COUNTRY_CODE
	FROM
		zoomsubs.daily_subs)
		
SELECT *
FROM zoomsubs.daily_subs_clean

/* Step 3: Join geographic data */
CREATE TEMPORARY TABLE zoomsubs.daily_subs_clean_country AS (
	SELECT
		dsc.*,
		gl.*
	FROM
		zoomsubs.daily_subs_clean AS dsc
	LEFT JOIN
		zoomsubs.geo_lookup AS gl
	ON dsc.COUNTRY_CODE = gl.COUNTRY_ISO)

SELECT *
FROM zoomsubs.daily_subs_clean_country

/* Step 4: Convert all local pricing that is not USD into USD based on country rates */
DROP TEMPORARY TABLE IF EXISTS zoomsubs.daily_subs_country_rates;

CREATE TEMPORARY TABLE zoomsubs.daily_subs_country_rates AS
	SELECT
		dscc.*,
		er.RATE,
		er.DATE AS RATES_DATE,
		-- new price
		CASE
			WHEN dscc.CURRENCY = "USD" THEN dscc.LOCAL_PRICE
			ELSE ROUND(dscc.LOCAL_PRICE*er.RATE,2)
		END AS PRICE_REVISED
	FROM
		zoomsubs.daily_subs_clean_country AS dscc
	LEFT JOIN
		zoomsubs.exchange_rates AS er
	ON dscc.CURRENCY = er.CURRENCY
	AND dscc.MONTH = MONTH(er.DATE)
	AND dscc.YEAR = YEAR(er.DATE)
	
SELECT *
FROM zoomsubs.daily_subs_country_rates

-- Export data
CREATE TABLE zoomsubs_clean AS
	SELECT *
	FROM zoomsubs.daily_subs_country_rates
	
SELECT *
FROM zoomsubs_clean