select
	customer_rk,
	concat(last_nm, ':', first_nm, ':', middle_nm) as full_name
from
	srcdt.cd_customers
where
	valid_to_dttm = '5999-01-01 00:00:00'
	and customer_rk not in (
	select
		customer_rk
	from
		(
		select
			*
		from
			srcdt.calendar
		where
			year_no = 2011) as dates
	inner join (
		select
			*
		from
			srcdt.account_periods
		where
			year(renewed_dt) <= 2011
			and year(expiration_dt) >= 2011) as accs on
		calendar_dt >= renewed_dt and calendar_dt < expiration_dt
	group by
		customer_rk
	having
		count(*) = (
		select
			count(*)
		from
			srcdt.calendar
		where
			year_no = 2011))