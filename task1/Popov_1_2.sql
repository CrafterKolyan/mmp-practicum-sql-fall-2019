USE srcdt;

SELECT 
	monthly_income_amt AS monthly_income2014
FROM
	cd_customers
WHERE 
	year(valid_from_dttm) < 2015 
	AND year(valid_to_dttm) > 2013 
    AND monthly_income_amt IS NOT NULL
ORDER BY monthly_income_amt DESC
LIMIT 10;