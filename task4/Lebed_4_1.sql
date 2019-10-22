select
	renewed_dt as date
from
	srcdt.account_periods
union
select
	date_add(expiration_dt, interval 1 day) as date
from
	srcdt.account_periods p
where
	account_renewal_cnt = (
	select
		max(account_renewal_cnt)
	from
		srcdt.account_periods
	where
		account_rk = p.account_rk)
order by date