SELECT monthly_income_amt as the_most_income
FROM cd_customers 
WHERE valid_from_dttm >= '2014-01-01 00:00:00' AND valid_from_dttm < '2015-01-01 00:00:00'
ORDER BY monthly_income_amt DESC
LIMIT 10