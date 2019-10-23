SELECT
    DATE_FORMAT(renewed_dt, "%Y-%m") AS MONTH,
    0 AS FROM_CNT,
    1 AS TO_CNT,
    COUNT(*) AS CNT
FROM srcdt.account_periods
WHERE account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
GROUP BY MONTH, FROM_CNT, TO_CNT
UNION ALL
SELECT
    DATE_FORMAT(t2.expiration_dt, "%Y-%m") AS MONTH,
    t2.account_renewal_cnt AS FROM_CNT,
    IFNULL(t3.account_renewal_cnt, 2147483647) AS TO_CNT,
    COUNT(*) AS CNT
FROM srcdt.account_periods AS t2
LEFT JOIN srcdt.account_periods AS t3
ON t2.account_rk = t3.account_rk AND t2.expiration_dt = t3.renewed_dt
WHERE t2.expiration_dt <= CURDATE()
GROUP BY MONTH, FROM_CNT, TO_CNT
