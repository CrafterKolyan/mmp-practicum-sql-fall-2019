select
  monthly_income_amt
from
  cd_customers
where 
  valid_from_dttm <= '2014-01-01 00:00:00'
  and valid_to_dttm >= '2014-01-01 00:00:00'
order by monthly_income_amt desc
limit 10