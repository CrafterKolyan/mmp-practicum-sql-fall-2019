select
    left_table.calendar_dt,
    sum(ifnull(right_table.n_accounts, 0)) as n_accounts
from
     (select calendar.calendar_dt
      from srcdt.calendar as calendar
      where calendar.calendar_dt between (
          select min(account_periods.renewed_dt)
          from srcdt.account_periods as account_periods
      ) and curdate()
     ) as left_table
    left join (
        select
            account_periods.renewed_dt,
            account_periods.expiration_dt,
            count(*) as n_accounts
        from srcdt.account_periods as account_periods
        group by
            account_periods.renewed_dt,
            account_periods.expiration_dt
    ) as right_table
    on
        right_table.renewed_dt <= left_table.calendar_dt and left_table.calendar_dt < right_table.expiration_dt
group by left_table.calendar_dt
