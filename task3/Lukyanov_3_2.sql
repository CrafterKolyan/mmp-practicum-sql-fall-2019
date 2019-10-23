SELECT calendar_dt, IFNULL(SUM(count_), 0) AS count_accs
FROM srcdt.calendar
LEFT JOIN
(
SELECT renewed_dt, expiration_dt, COUNT(*) as count_
FROM srcdt.account_periods
GROUP BY expiration_dt, renewed_dt
) AS datess
ON calendar_dt >= renewed_dt  AND calendar_dt < expiration_dt
WHERE calendar_dt >=
(
SELECT MIN(renewed_dt)
FROM srcdt.account_periods
) AND calendar_dt <= CURDATE()
GROUP BY calendar_dt