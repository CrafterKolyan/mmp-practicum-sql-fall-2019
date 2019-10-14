select
	dates.calendar_dt,
	sum(coalesce(customers.measure, 0)) as open_deposites_count
from
	(
	select
		calendar_dt
	from
		srcdt.calendar
	where
		calendar_dt between (
		select
			min(valid_from_dttm)
		from
			srcdt.cd_customers) and curdate()) as dates
left join (
	select
		1 as measure,
		valid_from_dttm,
		valid_to_dttm
	from
		srcdt.cd_customers) as customers on
	dates.calendar_dt between customers.valid_from_dttm and customers.valid_to_dttm
group by
	dates.calendar_dt