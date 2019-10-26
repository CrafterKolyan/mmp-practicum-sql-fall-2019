select account_periods.renewed_dt as date
from srcdt.account_periods as account_periods
union
select account_periods.expiration_dt as date
from srcdt.account_periods as account_periods
where account_periods.valid_to_dttm > '2019-09-01'
order by date
