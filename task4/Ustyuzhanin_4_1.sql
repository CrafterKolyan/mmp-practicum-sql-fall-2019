SELECT 
	renewed_dt as dts
FROM
	account_periods
UNION
SELECT
	MAX(expiration_dt) as dts
FROM
	account_periods
GROUP BY
	account_rk
ORDER BY dts