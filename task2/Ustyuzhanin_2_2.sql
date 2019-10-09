SELECT
	SUM(rk), dt
FROM
(
	SELECT
		count(DISTINCT customer_rk)as rk, YEAR(birth_dt) as dt
	FROM
		srcdt.cd_customers
	WHERE
		monthly_income_amt in (50000, 60000)
	GROUP BY
		customer_rk, birth_dt
	HAVING 
		count(DISTINCT monthly_income_amt) = 2
	ORDER BY
		dt
) as sql_kostil
GROUP BY
	dt
