SELECT
    DATE_FORMAT(renewed_dt, "%Y-%m") AS MONTH,
    0 AS FROM_CNT,
    1 AS TO_CNT,
    COUNT(*) AS CNT
FROM
    account_periods
WHERE
    account_renewal_cnt = 1
    AND renewed_dt <= CURDATE()
GROUP BY
    MONTH, FROM_CNT, TO_CNT
UNION ALL
SELECT
    DATE_FORMAT(closed.expiration_dt, "%Y-%m") AS MONTH,
    closed.account_renewal_cnt AS FROM_CNT,
    IFNULL(opened.account_renewal_cnt, 2147483647) AS TO_CNT,
    COUNT(*) AS CNT
FROM
    account_periods AS closed
LEFT JOIN
    account_periods AS opened
ON closed.account_rk = opened.account_rk
    AND closed.expiration_dt = opened.renewed_dt
WHERE
    closed.expiration_dt <= CURDATE()
GROUP BY
    MONTH, FROM_CNT, TO_CNT
