SELECT customer_rk,
	last_nm, first_nm, middle_nm
FROM srcdt.cd_customers WHERE valid_to_dttm = '5999-01-01 00:00:00'
AND customer_rk 
      IN (
		SELECT d.customer_rk FROM (
		SELECT
                account_rk, ANY_VALUE(customer_rk) AS customer_rk,
                MAX(expiration_dt) AS closemax_dt
            FROM srcdt.account_periods
		GROUP BY account_rk
		HAVING YEAR(closemax_dt) = 2011
        ) AS d
        LEFT JOIN (
            SELECT
                ANY_VALUE(customer_rk) AS customer_rk,
                MIN(renewed_dt) AS openmin_dt,
                MAX(expiration_dt) AS closemax_dt
            FROM srcdt.account_periods
            GROUP BY account_rk
        ) AS c
        ON c.customer_rk = d.customer_rk
           AND c.openmin_dt < d.closemax_dt
           AND c.closemax_dt > d.closemax_dt
        WHERE c.customer_rk IS NULL
      )