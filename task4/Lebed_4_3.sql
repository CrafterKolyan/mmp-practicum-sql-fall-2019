select
	month,
	from_cnt,
	to_cnt,
	count(*) as cnt
from
(
	(
	select
		date_format(curr.renewed_dt, '%Y-%d') as month,
		ifnull(prev.account_renewal_cnt, 0) as from_cnt,
		curr.account_renewal_cnt as to_cnt
	from
		(
		select
			*
		from
			srcdt.account_periods) as prev
	right join (
		select
			*
		from
			srcdt.account_periods) as curr on
		curr.account_rk = prev.account_rk
		and curr.account_renewal_cnt = prev.account_renewal_cnt + 1)
union all (
	select
		date_format(curr.renewed_dt, '%Y-%d') as month,
		curr.account_renewal_cnt as from_cnt,
		ifnull(next.account_renewal_cnt, 2147483647) as to_cnt
	from
		(
		select
			*
		from
			srcdt.account_periods) as curr
	left join (
		select
			*
		from
			srcdt.account_periods) as next on
		curr.account_rk = next.account_rk
		and curr.account_renewal_cnt = next.account_renewal_cnt - 1
	where
		next.account_rk is null
	)
) as trans
group by
	month,
	from_cnt,
	to_cnt
