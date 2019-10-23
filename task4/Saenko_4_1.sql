SELECT renewed_dt AS dep_date FROM srcdt.account_periods
UNION SELECT expiration_dt AS dep_date FROM srcdt.account_periods
WHERE valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY dep_date