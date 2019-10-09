SELECT 
        YEAR(birth_dt) AS Year_of_birth, 
        COUNT(DISTINCT customer_rk) AS Number_of_customers 
FROM cd_customers
WHERE customer_rk IN 
	(SELECT 
		customer_rk
	 FROM cd_customers
	 WHERE monthly_income_amt = 50000 OR monthly_income_amt = 60000 
	 GROUP BY customer_rk
	 HAVING COUNT(DISTINCT monthly_income_amt) = 2)
GROUP BY Year_of_birth
