SELECT
	customer_rk,
--	concat(last_nm, ' ', first_nm, ' ', middle_nm) AS full_nm
	last_nm,
    first_nm,
    middle_nm
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00'
	AND customer_rk NOT IN (
	SELECT closed_in_2011.customer_rk
	FROM (
		SELECT
			ANY_VALUE(customer_rk) AS customer_rk,
			MAX(expiration_dt) AS close_dt
		FROM
			srcdt.account_periods
		GROUP BY account_rk
		HAVING YEAR(close_dt) = 2011
	) AS closed_in_2011
	LEFT JOIN (
		SELECT
			ANY_VALUE(customer_rk) AS customer_rk,
			MIN(renewed_dt) AS open_dt,
			MAX(expiration_dt) AS close_dt
		FROM
			srcdt.account_periods
		GROUP BY account_rk
	) as all_deposits
	ON closed_in_2011.customer_rk = all_deposits.customer_rk
		AND closed_in_2011.close_dt > all_deposits.open_dt 
		AND closed_in_2011.close_dt < all_deposits.close_dt
)