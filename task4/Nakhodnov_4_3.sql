select
    date_format(left_table.expiration_dt, '%Y-%m') as month,
    left_table.account_renewal_cnt as from_cnt,
    ifnull(right_table.account_renewal_cnt, 2147483647) as to_cnt,
    count(*) as cnt
from
    (
        select
            account_periods.account_rk,
            account_periods.expiration_dt,
            account_periods.account_renewal_cnt
        from srcdt.account_periods as account_periods
        where account_periods.expiration_dt <= curdate()
    ) as left_table
    left join
    srcdt.account_periods as right_table
    on
        left_table.account_rk = right_table.account_rk and
        left_table.expiration_dt = right_table.renewed_dt
group by month, from_cnt, to_cnt
union all
select
    date_format(left_table.renewed_dt, '%Y-%m') as month,
    0 as from_cnt,
    left_table.account_renewal_cnt as to_cnt,
    count(*) as cnt
from
    srcdt.account_periods as left_table
    left join
    srcdt.account_periods as right_table
    on
        left_table.account_rk = right_table.account_rk and
        right_table.expiration_dt = left_table.renewed_dt
    where
        right_table.expiration_dt is null and
        left_table.renewed_dt <= curdate()
    group by month, from_cnt, to_cnt
