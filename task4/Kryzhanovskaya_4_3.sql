(SELECT 
	DATE_FORMAT(renewed_dt, "%Y-%m") AS MONTH, 0 AS FROM_CNT, 1 AS TO_CNT, COUNT(*) AS CNT
FROM account_periods
WHERE (account_renewal_cnt = 1) AND (renewed_dt <= CURDATE())
GROUP BY MONTH, FROM_CNT, TO_CNT
) UNION ALL (
SELECT
	DATE_FORMAT(a.expiration_dt, "%Y-%m") AS MONTH, a.account_renewal_cnt AS FROM_CNT, 
    IFNULL(b.account_renewal_cnt, 2147483647) AS TO_CNT, COUNT(*) AS CNT
FROM account_periods AS a
LEFT JOIN account_periods AS b
ON (a.account_rk = b.account_rk) AND (a.expiration_dt = b.renewed_dt)
WHERE a.expiration_dt <= CURDATE()
GROUP BY MONTH, FROM_CNT, TO_CNT
)