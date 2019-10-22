SELECT
    customer_rk,
    last_nm,
    first_nm,
    middle_nm
FROM 
	srcdt.cd_customers
WHERE 
	valid_to_dttm = '5999-01-01 00:00:00' 
    AND customer_rk IN (
		SELECT DISTINCT 
			closed.customer_rk 
		FROM (
			SELECT
				customer_rk,
				account_rk
			FROM srcdt.account_periods
			GROUP BY customer_rk, account_rk
			HAVING YEAR(MAX(expiration_dt)) = 2011
		) AS closed 
		LEFT JOIN (
			SELECT DISTINCT
				accounts.customer_rk,
				accounts.account_rk 
			FROM 
				(SELECT
					customer_rk,
					account_rk,
                    			MIN(renewed_dt) AS renewed_dt,
					MAX(expiration_dt) AS expiration_dt
				FROM 
					srcdt.account_periods
				GROUP BY 
					customer_rk, account_rk
			) AS acc
            		JOIN (
				SELECT
					customer_rk,
					account_rk,
					MAX(expiration_dt) AS date_of_closing
				FROM 
					srcdt.account_periods
				GROUP BY 
					customer_rk, account_rk
				HAVING YEAR(date_of_closing) = 2011
			) AS accounts
			ON
				accounts.customer_rk = acc.customer_rk AND
				accounts.account_rk != acc.account_rk AND
				accounts.date_of_closing > acc.renewed_dt AND
				accounts.date_of_closing < acc.expiration_dt
		) AS not_closed
		ON closed.customer_rk = not_closed.customer_rk AND
			closed.account_rk = not_closed.account_rk
		WHERE
			not_closed.account_rk IS NULL
);
