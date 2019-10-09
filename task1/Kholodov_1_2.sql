SELECT monthly_income_amt 
FROM cd_customers
WHERE valid_to_dttm >= '2014.01.01' AND valid_from_dttm < '2015.01.01'
ORDER BY monthly_income_amt DESC
LIMIT 10;