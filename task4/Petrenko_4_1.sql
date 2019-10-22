SELECT 
    renewed_dt AS dt
FROM
    srcdt.account_periods 
UNION SELECT 
    expiration_dt AS dt
FROM
    srcdt.account_periods
ORDER BY dt ASC