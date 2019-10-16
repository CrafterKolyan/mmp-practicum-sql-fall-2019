SELECT
	birth_year,
	COUNT(*)
FROM (
	SELECT
		YEAR(ANY_VALUE(birth_dt)) AS birth_year
	FROM
		srcdt.cd_customers
	WHERE
		monthly_income_amt IN (50000, 60000)
	GROUP BY
		customer_rk
	HAVING
		COUNT(DISTINCT monthly_income_amt) = 2
) AS birth_years_filtered
GROUP BY
	birth_year