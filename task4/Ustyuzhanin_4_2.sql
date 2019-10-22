SELECT
	DISTINCT customer_rk, CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) as nm
FROM
	cd_customers
WHERE
	customer_rk IN
(
	SELECT
		tb1.customer_rk
	FROM
	(
		SELECT
			customer_rk, account_rk, MAX(expiration_dt) as dt
		FROM
			account_periods
		WHERE
			YEAR(expiration_dt) = 2011
		GROUP BY
			customer_rk, account_rk
	) as tb1

	LEFT JOIN

	(
		SELECT
			account_rk, MIN(renewed_dt) as left_bound, MAX(expiration_dt) as right_bound
		FROM
			account_periods
		GROUP BY
			account_rk
	) as tb2
	ON tb1.account_rk = tb2.account_rk AND tb2.left_bound < tb1.dt AND tb1.dt < tb2.right_bound AND tb1.customer_rk = NULL
) AND valid_to_dttm = '5999-01-01 00:00:00'
