SELECT 
    DATE_FORMAT(renewed_dt, "%Y-%m") AS MONTH,
    0 AS FROM_CNT, 
    1 AS TO_CNT,
    COUNT(*) AS CNT
FROM 
    srcdt.account_periods
WHERE 
    account_renewal_cnt = 1 AND
        renewed_dt <= CURDATE()
GROUP BY 
    MONTH, FROM_CNT, TO_CNT
UNION ALL 
SELECT 
    DATE_FORMAT(acc1.expiration_dt, "%Y-%m") AS MONTH,
    acc1.account_renewal_cnt AS FROM_CNT, 
    IFNULL(acc2.account_renewal_cnt, 2147483647) AS TO_CNT,
    COUNT(*) AS CNT
FROM 
    srcdt.account_periods AS acc1
    LEFT JOIN
    srcdt.account_periods AS acc2
    ON acc1.account_rk = acc2.account_rk AND
	   acc1.expiration_dt = acc2.renewed_dt 
	WHERE 
	   acc1.expiration_dt <= CURDATE()
    GROUP BY MONTH, FROM_CNT, TO_CNT

