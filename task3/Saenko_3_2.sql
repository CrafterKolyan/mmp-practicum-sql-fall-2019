SELECT calendar_dt, IFNULL(SUM(both_counted), 0) AS now_opened FROM srcdt.calendar
LEFT JOIN 
(
SELECT renewed_dt, expiration_dt, COUNT(*) AS both_counted
FROM srcdt.account_periods
GROUP BY renewed_dt, expiration_dt
) AS c
ON srcdt.calendar.calendar_dt >= c.renewed_dt
AND srcdt.calendar.calendar_dt < c.expiration_dt
WHERE srcdt.calendar.calendar_dt >= (SELECT MIN(DATE(valid_from_dttm)) FROM srcdt.account_periods)
AND srcdt.calendar.calendar_dt <= CURDATE()
GROUP BY calendar_dt 