SELECT 
    customer_rk, last_nm, first_nm, middle_nm
FROM
    srcdt.cd_customers
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
        AND customer_rk IN (SELECT 
            customer_rk
        FROM
            (SELECT 
                customer_rk, MAX(expiration_dt) AS close_dt
            FROM
                srcdt.account_periods
            GROUP BY customer_rk , account_rk
            HAVING YEAR(close_dt) = 2011) a
        WHERE
            NOT EXISTS( SELECT 
                    customer_rk,
                        MIN(renewed_dt) AS open_dt,
                        MAX(expiration_dt) AS close_dt
                FROM
                    srcdt.account_periods
                GROUP BY customer_rk , account_rk
                HAVING customer_rk = a.customer_rk
                    AND open_dt < a.close_dt
                    AND close_dt > a.close_dt))
