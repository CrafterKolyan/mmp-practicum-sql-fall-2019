SELECT 
	renewed_dt AS dt
FROM account_periods
UNION 
SELECT 
	expiration_dt 
FROM account_periods
WHERE YEAR(valid_to_dttm) = 5999
ORDER BY dt
