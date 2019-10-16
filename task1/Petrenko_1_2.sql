SELECT 
    monthly_income_amt
FROM
    srcdt.cd_customers
WHERE
    YEAR(valid_from_dttm) <= 2014
        AND YEAR(valid_to_dttm) >= 2014
ORDER BY monthly_income_amt DESC
LIMIT 10