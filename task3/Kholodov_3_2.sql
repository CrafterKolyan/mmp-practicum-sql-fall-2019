SElECT
	calendar_dt, IFNULL(SUM(num), 0) AS dep_num
FROM(
	SELECT calendar_dt FROM srcdt.calendar
    WHERE calendar_dt<=CURDATE() AND calendar_dt>= 
    (SELECT MIN(DATE(valid_from_dttm)) FROM srcdt.account_periods)) all_dates 
LEFT JOIN
(SELECT renewed_dt, expiration_dt, COUNT(*) AS num
    FROM
        srcdt.account_periods
    GROUP BY renewed_dt , expiration_dt) periods 
ON all_dates.calendar_dt >= periods.renewed_dt AND all_dates.calendar_dt < periods.expiration_dt
GROUP BY all_dates.calendar_dt