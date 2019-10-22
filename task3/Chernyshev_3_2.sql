SELECT
    c.calendar_dt,
    COUNT(ap.account_rk) AS amount
FROM
    calendar AS c
LEFT JOIN
    account_periods AS ap
ON
    c.calendar_dt BETWEEN ap.renewed_dt AND SUBDATE(ap.expiration_dt, 1)
GROUP BY
    c.calendar_dt
HAVING
    c.calendar_dt BETWEEN MIN(ap.renewed_dt) AND CURDATE();
