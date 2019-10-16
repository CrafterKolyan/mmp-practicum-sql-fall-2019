SELECT all_dates.calendar_dt, 
	CASE  
		WHEN SUM(dates_interval) IS NULL THEN 0
        ELSE SUM(dates_interval)
	END AS cnt_open
FROM 
(
	SELECT calendar_dt
    FROM calendar
    WHERE calendar_dt <= CURDATE() AND calendar_dt >= (
		SELECT MIN(DATE(valid_from_dttm))
		FROM account_periods)
) AS all_dates
LEFT JOIN
(
	SELECT renewed_dt, expiration_dt, count(*) AS dates_interval
    FROM account_periods
    GROUP BY renewed_dt , expiration_dt
) AS dates_change
ON all_dates.calendar_dt >= dates_change.renewed_dt AND all_dates.calendar_dt < dates_change.expiration_dt
GROUP BY all_dates.calendar_dt