select
	dates.calendar_dt,
	sum(coalesce(measure, 0)) as open_deposites_count
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
		count(*) as measure,
		renewed_dt,
		expiration_dt
	from
		srcdt.account_periods
	group by
		renewed_dt,
		expiration_dt) as periods on
	dates.calendar_dt >= renewed_dt and dates.calendar_dt < expiration_dt
group by
	dates.calendar_dt