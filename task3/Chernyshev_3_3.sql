SELECT
    c.year_no,
    COUNT(ap.account_renewal_cnt = 1) AS new,
    COUNT(ap.account_renewal_cnt > 1) AS prolong,
    COUNT(1.5 * prev_ap.opening_amt < ap.opening_amt) AS big_prolong
FROM
    calendar AS c
LEFT JOIN
    account_periods AS ap
ON
    YEAR(ap.renewed_dt) = c.year_no
INNER JOIN
    account_periods prev_ap
ON
    prev_ap.expiration_dt = ap.renewed_dt AND
    ap.account_rk = prev_ap.account_rk
GROUP BY
    c.year_no;
