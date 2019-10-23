SELECT 
    calendar_dt, IFNULL(SUM(acc_num), 0) AS accounts_number
FROM
    srcdt.calendar dates
        LEFT JOIN
    (SELECT 
        renewed_dt, expiration_dt, COUNT(*) AS acc_num
    FROM
        srcdt.account_periods
    GROUP BY renewed_dt , expiration_dt) accounts ON calendar_dt >= renewed_dt
        AND calendar_dt < expiration_dt
WHERE
    calendar_dt BETWEEN (SELECT 
            MIN(renewed_dt)
        FROM
            srcdt.account_periods) AND CURDATE()
GROUP BY calendar_dt