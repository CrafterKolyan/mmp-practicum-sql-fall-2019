select
	year(customers.birth_dt) as birthyear,
	count(*) as count
from
	(
	select
		customer_rk,
		birth_dt
	from
		srcdt.cd_customers
	where
		valid_to_dttm = "5999-01-01 00:00:00" ) as customers
where
	customers.customer_rk in (
	select
		customer_rk
	from
		srcdt.cd_customers
	where
		monthly_income_amt in (50000,
		60000)
	group by
		customer_rk
	having
		count(distinct monthly_income_amt) = 2)
group by
	birthyear