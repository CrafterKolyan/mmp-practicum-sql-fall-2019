SELECT
    DATE_FORMAT(ap1.expiration_dt, "%Y-%m") AS month,
    ap1.account_renewal_cnt AS from_cnt,
    IFNULL(ap2.account_renewal_cnt, 2147483647) AS to_cnt,
    COUNT(*) AS cnt
FROM
    account_periods AS ap1
LEFT JOIN
    account_periods AS ap2
ON
    ap2.account_rk = ap1.account_rk AND
    ap2.renewed_dt = ap1.expiration_dt
WHERE
    ap1.expiration_dt <= CURDATE()
GROUP BY
    month, from_cnt, to_cnt
UNION ALL
SELECT
    DATE_FORMAT(renewed_dt, "%Y-%m") AS month,
    0 AS from_cnt,
    1 AS to_cnt,
    COUNT(*) AS cnt
FROM
    account_periods
WHERE
    renewed_dt <= CURDATE() AND
    account_renewal_cnt = 1
GROUP BY
    month, from_cnt, to_cnt;
