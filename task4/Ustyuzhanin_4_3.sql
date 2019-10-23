	SELECT
		DATE_FORMAT(tb1.expiration_dt, "%Y-%m") as `MONTH`, tb1.account_renewal_cnt as FROM_CNT, IFNULL(tb2.account_renewal_cnt, 2147483647) as TO_CNT, COUNT(*) as CNT
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
		`MONTH`, FROM_CNT, TO_CNT

UNION ALL

	SELECT
		DATE_FORMAT(renewed_dt, "%Y-%m") as `MONTH`, 0 as FROM_CNT, 1 as TO_CNT, COUNT(*) as CNT
	FROM
		account_periods
	WHERE
		account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
	GROUP BY
		`MONTH`, FROM_CNT, TO_CNT

ORDER BY
	`MONTH`
