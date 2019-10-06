SELECT COUNT(customer_rk) - COUNT(DISTINCT customer_rk) AS cnt
FROM(
	SELECT DISTINCT customer_rk, monthly_income_amt
	FROM cd_customers
	WHERE monthly_income_amt IN (50000, 60000) 
) AS a