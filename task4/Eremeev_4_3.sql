SELECT
    DATE_FORMAT(renewed_dt, "%Y-%m") AS `MONTH`,
    0 AS FROM_CNT,
    1 AS TO_CNT,
    COUNT(*) AS CNT
FROM account_periods
WHERE account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
GROUP BY FROM_CNT, TO_CNT, `MONTH`
UNION ALL (
    SELECT
        DATE_FORMAT(faccounts.expiration_dt, "%Y-%m") AS `MONTH`,
        faccounts.account_renewal_cnt AS FROM_CNT,
        IFNULL(saccounts.account_renewal_cnt, 2147483647) AS TO_CNT,
        COUNT(faccounts.account_rk) AS CNT
    FROM account_periods AS faccounts
        LEFT JOIN account_periods AS saccounts
        ON saccounts.account_rk = faccounts.account_rk 
    	   AND faccounts.expiration_dt = saccounts.renewed_dt
    WHERE faccounts.expiration_dt <= CURDATE()
    GROUP BY FROM_CNT, TO_CNT, `MONTH`)
