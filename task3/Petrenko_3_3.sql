SELECT 
    year_no,
    SUM(CASE
        WHEN account_renewal_cnt = 1 THEN 1
        ELSE 0
    END) AS deposit_openings,
    SUM(CASE
        WHEN account_renewal_cnt > 1 THEN 1
        ELSE 0
    END) AS deposit_prolongations,
    SUM(growth_flag) AS grown_deposits
FROM
    (SELECT 
        a.account_renewal_cnt,
            a.renewed_dt,
            (CASE
                WHEN b.account_renewal_cnt IS NULL THEN 0
                ELSE 1
            END) AS growth_flag
    FROM
        srcdt.account_periods a
    LEFT JOIN srcdt.account_periods b ON a.account_rk = b.account_rk
        AND a.account_renewal_cnt - 1 = b.account_renewal_cnt
        AND a.opening_amt > b.opening_amt * 1.5) accounts
        INNER JOIN
    srcdt.calendar dates ON renewed_dt = calendar_dt
GROUP BY year_no