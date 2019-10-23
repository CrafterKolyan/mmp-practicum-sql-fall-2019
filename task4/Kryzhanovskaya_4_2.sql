SELECT
    customer_rk, last_nm, first_nm, middle_nm
FROM cd_customers
WHERE customer_rk IN (
	SELECT a.customer_rk
	FROM (
		SELECT
			ANY_VALUE(customer_rk) AS customer_rk,
			MAX(expiration_dt) AS close_dt
		FROM
			account_periods
		GROUP BY account_rk
		HAVING YEAR(close_dt) = 2011
	) AS a
	LEFT JOIN (
		SELECT
			ANY_VALUE(customer_rk) AS customer_rk,
			MIN(renewed_dt) AS open_dt,
			MAX(expiration_dt) AS close_dt
		FROM
			account_periods
		GROUP BY account_rk
	) AS b
	ON (a.customer_rk = b.customer_rk)  AND (a.close_dt > b.open_dt) AND (a.close_dt < b.close_dt)
	WHERE b.customer_rk IS NULL
) AND valid_to_dttm = '5999-01-01 00:00:00'