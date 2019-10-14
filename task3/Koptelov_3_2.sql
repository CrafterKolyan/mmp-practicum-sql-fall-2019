SELECT 
<<<<<<< HEAD
    calendar_dt, IFNULL(SUM(num_dates), 0) AS num_deposits
=======
    calendar_dt, COALESCE(SUM(num_dates), 0) AS num_deposits
>>>>>>> solved task_3
FROM
    (SELECT 
        calendar_dt
    FROM
        calendar
    WHERE
        calendar_dt <= CURDATE()
            AND calendar_dt >= (SELECT 
                MIN(DATE(valid_from_dttm))
            FROM
                account_periods)) cal
        LEFT JOIN
    (SELECT 
        renewed_dt, expiration_dt, COUNT(*) AS num_dates
    FROM
        account_periods
    GROUP BY renewed_dt , expiration_dt) acc ON cal.calendar_dt >= acc.renewed_dt
        AND cal.calendar_dt < acc.expiration_dt
GROUP BY cal.calendar_dt