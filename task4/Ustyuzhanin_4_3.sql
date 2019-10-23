	SELECT
		DATE_FORMAT(tb1.expiration_dt, "%Y-%m") as dt, tb1.account_renewal_cnt as bf, IFNULL(tb2.account_renewal_cnt, 2147483647) as aft, COUNT(*) as counter
	FROM
	(
		account_periods tb1
	LEFT JOIN
		account_periods tb2
		
		ON tb1.account_rk = tb2.account_rk AND tb1.expiration_dt = tb2.renewed_dt
	)
    
    WHERE
		tb1.expiration_dt <= CURDATE()
        
	GROUP BY
		dt, bf, aft

UNION ALL

	SELECT
		DATE_FORMAT(renewed_dt, "%Y-%m") as dt, 0 as bf, 1 as aft, COUNT(*) as counter
	FROM
		account_periods
	WHERE
		account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
	GROUP BY
		dt, bf, aft
ORDER BY
	dt
