select
    cd_customers.customer_rk,
    concat(last_nm, ' ', first_nm, ' ', middle_nm) as name
from srcdt.cd_customers as cd_customers
where
    cd_customers.valid_to_dttm = '5999-01-01 00:00:00' and
    cd_customers.customer_rk in (
        select closed_accounts.customer_rk
        from (
            select
                any_value(account_periods.customer_rk) as customer_rk,
                account_periods.account_rk as account_rk,
                max(account_periods.expiration_dt) as right_border
            from
                srcdt.account_periods as account_periods
            group by account_periods.account_rk
            having year(right_border) = 2011
        ) as closed_accounts
        left join (
            select
                any_value(account_periods.customer_rk) as customer_rk,
                min(account_periods.renewed_dt) as left_border,
                max(account_periods.expiration_dt) as right_border
            from
                srcdt.account_periods as account_periods
            group by account_periods.account_rk
        ) as accounts
        on
            closed_accounts.customer_rk = accounts.customer_rk and
            accounts.left_border < closed_accounts.right_border and
            closed_accounts.right_border < accounts.left_border
        where accounts.customer_rk is null
      )
