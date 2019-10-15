SELECT 
    calendar_dt, IFNULL(SUM(acc_amnt), 0) AS accounts_amnt
FROM
    srcdt.calendar AS calendar
        LEFT JOIN
    (SELECT 
        renewed_dt, expiration_dt, COUNT(*) AS acc_amnt
    FROM
        srcdt.account_periods
    GROUP BY renewed_dt , expiration_dt) AS acc_per_nums 
    ON calendar.calendar_dt >= acc_per_nums.renewed_dt
        AND calendar.calendar_dt < acc_per_nums.expiration_dt
	WHERE calendar.calendar_dt BETWEEN (SELECT 
            MIN(renewed_dt)
        FROM
            srcdt.account_periods) AND CURDATE()
GROUP BY calendar_dt;
