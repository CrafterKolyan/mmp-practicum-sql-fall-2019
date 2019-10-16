SELECT
    YEAR(t1.renewed_dt) AS year
    SUM(ap.account_renewal_cnt = 1) AS new,
    SUM(ap.account_renewal_cnt > 1) AS prolong,
    SUM(1.5 * prev_ap.opening_amt < ap.opening_amt) AS big_prolong
FROM
    account_periods AS ap
LEFT JOIN
    account_periods prev_ap
ON
    prev_ap.valid_to_dttm = ap.valid_from_dttm AND
    prev_ap.account_rk = ap.account_rk
GROUP BY
    YEAR(t1.renewed_dt);
