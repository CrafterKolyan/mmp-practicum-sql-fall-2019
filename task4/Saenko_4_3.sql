SELECT DATE_FORMAT(renewed_dt, "%Y-%m") AS `MONTH`,
0 AS FROM_CNT, 1 AS TO_CNT, COUNT(*) AS CNT
FROM srcdt.account_periods WHERE account_renewal_cnt = 1 
AND renewed_dt <= CURDATE()
GROUP BY `MONTH`
UNION ALL
SELECT DATE_FORMAT(dep1.expiration_dt, "%Y-%m") AS `MONTH`,
dep1.account_renewal_cnt AS FROM_CNT,
IFNULL(dep2.account_renewal_cnt, 2147483647) AS TO_CNT,
COUNT(*) AS CNT
FROM 
(
SELECT * FROM srcdt.account_periods 
WHERE expiration_dt <= CURDATE()
) AS dep1
LEFT JOIN srcdt.account_periods AS dep2
ON dep1.account_rk = dep2.account_rk AND dep1.expiration_dt = dep2.renewed_dt
GROUP BY `MONTH`, FROM_CNT, TO_CNT