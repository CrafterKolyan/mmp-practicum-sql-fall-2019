select
	renewed_dt as date
from
	srcdt.account_periods
union
select
	expiration_dt as date
from
	srcdt.account_periods
where
	expiration_dt >= current_date
	and account_renewal_cnt = (
	select
		max(account_renewal_cnt)
	from
		srcdt.account_periods p
	where
		account_rk = p.account_rk)
order by
	date