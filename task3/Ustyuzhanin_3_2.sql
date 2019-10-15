SELECT 
	calendar_dt, IFNULL(SUM(cnt), 0)
FROM
	srcdt.calendar
LEFT JOIN
(
	SELECT
		renewed_dt, expiration_dt, COUNT(*) as cnt
	FROM
		srcdt.account_periods
	GROUP BY
		expiration_dt, renewed_dt
) as rnw_exp_dts
ON renewed_dt <= calendar_dt AND calendar_dt < expiration_dt
WHERE
calendar_dt >=
(
	SELECT
		MIN(renewed_dt)
	FROM
		srcdt.account_periods
)
	AND calendar_dt <= CURDATE()
GROUP BY
	calendar_dt