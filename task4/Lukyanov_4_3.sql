SELECT DATE_FORMAT(renewed_dt, "%Y-%m") AS MONTH,
0 AS FROM_CNT, 1 AS TO_CNT, COUNT(*) AS CNT
FROM srcdt.account_periods
WHERE account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
GROUP BY MONTH, FROM_CNT, TO_CNT
UNION ALL SELECT 
DATE_FORMAT(a1.expiration_dt, "%Y-%m") AS MONTH,
a1.account_renewal_cnt AS FROM_CNT, 
IFNULL(b1.account_renewal_cnt, 2147483647) AS TO_CNT,
COUNT(*) AS CNT
FROM srcdt.account_periods AS a1
LEFT JOIN srcdt.account_periods AS b1 ON b1.account_rk = a1.account_rk AND
b1.renewed_dt = a1.expiration_dt
WHERE a1.expiration_dt <= CURDATE()
GROUP BY MONTH, FROM_CNT, TO_CNT