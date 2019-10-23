SELECT
	renewed_dt AS possibly_renewed_dt
FROM
    srcdt.account_periods
UNION
SELECT
	expiration_dt AS possibly_renewed_dt
FROM
	srcdt.account_periods
WHERE
	valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY possibly_renewed_dt ASC
LIMIT 5