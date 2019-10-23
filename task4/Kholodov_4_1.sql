SELECT 
    expiration_dt AS `DATE`
FROM
    srcdt.account_periods
UNION 
SELECT 
    renewed_dt AS `DATE`
FROM
    srcdt.account_periods 
ORDER BY `DATE` ASC