SELECT
    calendar_dt,
    IFNULL(SUM(open_accounts), 0) AS num_open_accounts
FROM
    calendar
LEFT JOIN (
    SELECT
        renewed_dt,
        expiration_dt,
        COUNT(*) AS open_accounts
    FROM
        account_periods
    GROUP BY
        renewed_dt, expiration_dt
    ) AS open_close_dts
ON renewed_dt <= calendar_dt AND calendar_dt < expiration_dt
WHERE
    calendar_dt BETWEEN (
        SELECT 
            MIN(renewed_dt)
        FROM
            account_periods
    ) AND CURDATE()
GROUP BY
    calendar_dt
