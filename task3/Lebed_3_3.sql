select
	years.year,
	sum(coalesce(open_measure, 0)) as open_deposites_count,
	sum(coalesce(prolongated_measure, 0)) as prolongated_deposites_count,
	sum(coalesce(periods.opening_amt*2 > prev_periods.opening_amt*3, 0)) as up50_deposites_count
from
	(
	select
		distinct year(calendar_dt) as year
	from
		srcdt.calendar
	where
		year(calendar_dt) >= (
		select
			year(min(renewed_dt))
		from
			srcdt.account_periods)) as years
left join (
	select
		opening_amt,
		account_rk,
		account_renewal_cnt,
		account_renewal_cnt = 1 as open_measure,
		account_renewal_cnt >= 2 as prolongated_measure,
		renewed_dt,
		expiration_dt
	from
		srcdt.account_periods) as periods on
	years.year = year(periods.renewed_dt)
left join (
	select
		opening_amt,
		account_rk,
		account_renewal_cnt
	from
		srcdt.account_periods) as prev_periods on
	prev_periods.account_rk = periods.account_rk
	and prev_periods.account_renewal_cnt = periods.account_renewal_cnt - 1
group by
	years.year