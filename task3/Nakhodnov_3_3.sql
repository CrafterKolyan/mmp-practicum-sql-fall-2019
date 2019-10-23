select
	years.year_no,
	ifnull(left_table.n_opens, 0) as n_opens,
	ifnull(left_table.n_prolongations, 0) as n_prolongations,
	ifnull(right_table.increased_deposits, 0) as increased_deposits
from
    (select distinct
        calendar.year_no
    FROM
        srcdt.calendar as calendar
    ) AS years
    left join
    (select
        year(account_periods.renewed_dt) as action_year,
        sum(account_periods.account_renewal_cnt = 1) as n_opens,
        sum(account_periods.account_renewal_cnt > 1) as n_prolongations
     from srcdt.account_periods as account_periods
     group by action_year
    ) as left_table
    on years.year_no = left_table.action_year
    left join (
        select
            year(left_inner_table.renewed_dt) as action_year,
            count(*) as increased_deposits
        from srcdt.account_periods as left_inner_table
        inner join srcdt.account_periods as right_inner_table
        on
            left_inner_table.account_rk = right_inner_table.account_rk
            and 2 * left_inner_table.opening_amt > 3 * right_inner_table.opening_amt
            and left_inner_table.account_renewal_cnt = right_inner_table.account_renewal_cnt + 1
        group by action_year
    ) as right_table
    on years.year_no = right_table.action_year
