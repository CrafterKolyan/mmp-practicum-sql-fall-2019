SELECT COUNT(DISTINCT customer_rk) AS cnt_customers, YEAR(birth_dt) AS birth_year
FROM cd_customers
WHERE customer_rk IN (
	SELECT customer_rk
	FROM cd_customers
	WHERE monthly_income_amt IN (50000, 60000) 
	GROUP BY customer_rk
	HAVING COUNT(DISTINCT monthly_income_amt) = 2
)
GROUP BY birth_year
