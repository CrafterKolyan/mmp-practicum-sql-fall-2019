SELECT 
    op_con.deposit_year, opens, continues, deposit_big
FROM
    (SELECT 
        YEAR(renewed_dt) AS deposit_year,
            SUM(account_renewal_cnt = 1) AS opens,
            SUM(account_renewal_cnt > 1) AS continues
    FROM
        account_periods
    GROUP BY deposit_year) op_con
        JOIN
    (SELECT 
        YEAR(acc1.renewed_dt) AS deposit_year,
            COUNT(*) AS deposit_big
    FROM
        account_periods acc1
    JOIN account_periods acc2 ON acc1.account_rk = acc2.account_rk
        AND acc1.account_renewal_cnt - acc2.account_renewal_cnt = 1
        AND acc1.opening_amt > 1.5 * acc2.opening_amt
    GROUP BY deposit_year) big ON op_con.deposit_year = big.deposit_year