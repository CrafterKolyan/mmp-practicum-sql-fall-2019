SELECT 
    renewed_dt AS open_date
FROM
    account_periods 
UNION
SELECT 
    expiration_dt AS open_date
FROM
    account_periods
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY open_date