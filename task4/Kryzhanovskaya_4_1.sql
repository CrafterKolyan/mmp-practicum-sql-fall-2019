SELECT renewed_dt as dt
FROM account_periods
UNION
SELECT expiration_dt
FROM account_periods
ORDER BY dt ASC