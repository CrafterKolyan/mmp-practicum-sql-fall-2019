select
	monthly_income_amt
from
	srcdt.cd_customers
where
	year(valid_from_dttm) <= 2014
	and year(valid_to_dttm) >= 2014
	and monthly_income_amt is not null
order by
	monthly_income_amt desc
limit 10
