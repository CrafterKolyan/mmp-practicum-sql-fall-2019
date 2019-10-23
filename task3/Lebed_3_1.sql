select
	customers.customer_rk,
	customers.full_name,
	name_popularity.popularity
from
	(
	select
		customer_rk,
		concat(last_nm, ':', first_nm, ':', middle_nm) as full_name
	from
		srcdt.cd_customers
	where
		valid_to_dttm = '5999-01-01 00:00:00') as customers
left join (
	select
		concat(last_nm, ':', first_nm, ':', middle_nm) as full_name,
		count(*) as popularity
	from
		srcdt.cd_customers
	where
		valid_to_dttm = '5999-01-01 00:00:00'
	group by
		full_name) as name_popularity on
	customers.full_name = name_popularity.full_name