SELECT renewed_dt AS date
FROM srcdt.account_periods
UNION
SELECT expiration_dt AS date
FROM srcdt.account_periods
WHERE valid_to_dttm = '5999-01-01'
ORDER BY date
