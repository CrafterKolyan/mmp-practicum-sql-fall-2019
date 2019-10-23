SELECT 
    DATE_FORMAT(deposits.renewed_dt, '%Y-%m') AS MONTH,
    0 AS FROM_CNT,
    1 AS TO_CNT,
    COUNT(*) AS CNT
FROM
    account_periods deposits
WHERE
    deposits.account_renewal_cnt = 1
        AND deposits.renewed_dt <= CURDATE()
GROUP BY MONTH , FROM_CNT , TO_CNT 
UNION SELECT 
    DATE_FORMAT(deposits_from.expiration_dt, '%Y-%m') AS MONTH,
    deposits_from.account_renewal_cnt AS FROM_CNT,
    IFNULL(deposits_to.account_renewal_cnt,
            2147483647) AS TO_CNT,
    COUNT(*) AS CNT
FROM
    account_periods deposits_from
        LEFT JOIN
    account_periods deposits_to ON deposits_from.account_rk = deposits_to.account_rk
        AND deposits_from.expiration_dt = deposits_to.renewed_dt
WHERE
    deposits_from.expiration_dt <= CURDATE()
GROUP BY MONTH , FROM_CNT , TO_CNT