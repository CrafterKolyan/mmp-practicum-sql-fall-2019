(SELECT 
    DATE_FORMAT(renewed_dt, '%Y-%m') AS MONTH,
    0 AS FROM_CNT,
    account_renewal_cnt AS TO_CNT,
    COUNT(*) AS CNT
FROM
    srcdt.account_periods
WHERE
    account_renewal_cnt = 1
        AND renewed_dt <= CURDATE()
GROUP BY TO_CNT , MONTH) UNION (SELECT 
    DATE_FORMAT(a.expiration_dt, '%Y-%m') AS MONTH,
    a.account_renewal_cnt AS FROM_CNT,
    IFNULL(b.account_renewal_cnt, 2147483647) AS TO_CNT,
    COUNT(*) AS CNT
FROM
    srcdt.account_periods a
        LEFT JOIN
    srcdt.account_periods b ON a.account_rk = b.account_rk
        AND a.account_renewal_cnt + 1 = b.account_renewal_cnt
WHERE
    a.expiration_dt <= CURDATE()
GROUP BY MONTH , FROM_CNT , TO_CNT)
