SELECT calendar_dt, IFNULL(SUM(acc_cnt), 0) as acc_cnt
FROM calendar a
LEFT JOIN (
	SELECT renewed_dt, expiration_dt, COUNT(*) as acc_cnt
	FROM account_periods
	GROUP BY renewed_dt, expiration_dt
) b
ON calendar_dt >= renewed_dt and calendar_dt < expiration_dt
WHERE 
	calendar_dt <= CURDATE()  
	AND calendar_dt >= (
		SELECT MIN(renewed_dt) 
		FROM account_periods)
GROUP BY calendar_dt
