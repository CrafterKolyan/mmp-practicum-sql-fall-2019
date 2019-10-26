SELECT 
    customer_rk, last_nm, first_nm, middle_nm
FROM
    srcdt.cd_customers
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
        AND customer_rk IN (SELECT DISTINCT
            customer_rk
        FROM
            (SELECT 
                a.customer_rk AS customer_rk, b.customer_rk AS null_flag
            FROM
                (SELECT 
                account_rk,
                    ANY_VALUE(customer_rk) AS customer_rk,
                    MAX(expiration_dt) AS closed_dt
            FROM
                srcdt.account_periods
            GROUP BY account_rk
            HAVING YEAR(closed_dt) = 2011) a
            LEFT JOIN (SELECT 
                account_rk,
                    ANY_VALUE(customer_rk) AS customer_rk,
                    MIN(renewed_dt) AS open_dt,
                    MAX(expiration_dt) AS closed_dt
            FROM
                srcdt.account_periods
            GROUP BY account_rk) b ON a.customer_rk = b.customer_rk
                AND a.closed_dt > b.open_dt
                AND a.closed_dt < b.closed_dt) t
        WHERE
            null_flag IS NULL)


