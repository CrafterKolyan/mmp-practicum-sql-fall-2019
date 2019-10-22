SELECT
	customer_rk,
    last_nm,
    first_nm,
    middle_nm
FROM cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00' AND
	customer_rk IN (
		SELECT DISTINCT closed_2011.customer_rk FROM (
			SELECT
				customer_rk,
				account_rk
			FROM account_periods
			GROUP BY customer_rk, account_rk
			HAVING YEAR(MAX(expiration_dt)) = 2011
		) as closed_2011 LEFT JOIN (
			SELECT DISTINCT
				a.customer_rk,
				a.account_rk
			FROM (
				SELECT
					customer_rk,
					account_rk,
					MAX(expiration_dt) as closed_date
				FROM account_periods
				GROUP BY customer_rk, account_rk
				HAVING YEAR(closed_date) = 2011
			) AS a INNER JOIN account_periods as b
			ON
				a.customer_rk = b.customer_rk AND
				a.account_rk <> b.account_rk AND
				((b.renewed_dt < a.closed_date AND
				b.expiration_dt > a.closed_date) OR
				(b.renewed_dt = a.closed_date AND
				b.account_renewal_cnt > 1))
		) as not_total_closures
		ON closed_2011.customer_rk = not_total_closures.customer_rk AND
			closed_2011.account_rk = not_total_closures.account_rk
		WHERE
			not_total_closures.account_rk IS NULL
);
