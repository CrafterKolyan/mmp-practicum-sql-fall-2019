SELECT birth_year, count(*)
FROM (
	SELECT customer_rk, YEAR(max(birth_dt)) AS birth_year
	FROM srcdt.cd_customers
	WHERE monthly_income_amt IN (50000, 60000)
    GROUP BY customer_rk
    HAVING count(DISTINCT monthly_income_amt) = 2
) as income_right
GROUP BY birth_year
ORDER BY birth_year





