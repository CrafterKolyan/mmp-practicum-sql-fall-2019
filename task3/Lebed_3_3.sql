select
	years.year,
	sum(coalesce(curr.measure, 0) = 1) as open_deposites_count,
	sum(coalesce(curr.measure, 0) = 1 and coalesce(prev.measure, 0) = 1) as prolongated_count,
	sum(case
			when curr.measure is not null and prev.measure is not null and curr.monthly_income_amt > 2 * prev.monthly_income_amt then 1
			else 0 
		end) as up50_prolongated_count
from
	(
	select
		distinct year(calendar_dt) as year
	from
		srcdt.calendar
	where
		year(calendar_dt) >= (
		select
			year(min(valid_from_dttm))
		from
			srcdt.cd_customers)) as years
left join (
	select
		1 as measure,
		srcdt.cd_customers.*
	from
		srcdt.cd_customers ) as curr on
	year(curr.valid_from_dttm) = years.year
left join (
	select
		1 as measure,
		srcdt.cd_customers.*
	from
		srcdt.cd_customers ) as prev on
	prev.customer_rk = curr.customer_rk
	and timestampdiff(second,
	prev.valid_to_dttm,
	curr.valid_from_dttm) = 1
group by
	years.year