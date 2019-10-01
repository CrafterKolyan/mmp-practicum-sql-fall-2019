SELECT
	birth_year,
	COUNT(customer_rk) AS customer_count
FROM (
	SELECT customer_rk, YEAR(ANY_VALUE(birth_dt)) as birth_year
	FROM cd_customers
	WHERE monthly_income_amt IN (50000, 60000)
	GROUP BY customer_rk
	HAVING COUNT(DISTINCT monthly_income_amt) = 2
) as rk_year
GROUP BY birth_year
ORDER BY birth_year ASC;
