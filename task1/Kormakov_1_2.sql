SELECT 
    monthly_income_amt AS max10_income_in_2014
FROM
    srcdt.cd_customers
WHERE
    YEAR(valid_from_dttm) < 2015
        AND YEAR(valid_to_dttm) >= 2014
ORDER BY max10_income_in_2014 DESC
LIMIT 10;
