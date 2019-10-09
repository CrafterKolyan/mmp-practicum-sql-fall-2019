select
	count(*)
from
	(
	select
		customer_rk
	from
		srcdt.cd_customers
	group by
		customer_rk
	having
		count(customer_rk) = 1) as const_customers