select cd_customers.monthly_income_amt
from srcdt.cd_customers as cd_customers
where 2014 >= year(cd_customers.valid_from_dttm) and year(cd_customers.valid_to_dttm) >= 2014
order by cd_customers.monthly_income_amt desc
limit 10