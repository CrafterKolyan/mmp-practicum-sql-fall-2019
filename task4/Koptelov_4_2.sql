SELECT 
    customer_rk, last_nm, first_nm, middle_nm
FROM
    cd_customers
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
        AND customer_rk IN (SELECT 
            filtered_deposits.customer_rk
        FROM
            (SELECT 
                account_rk,
                    ANY_VALUE(customer_rk) AS customer_rk,
                    MAX(expiration_dt) AS close_dt
            FROM
                account_periods
            GROUP BY account_rk
            HAVING YEAR(close_dt) = 2011) AS filtered_deposits
                LEFT JOIN
            (SELECT 
                ANY_VALUE(customer_rk) AS customer_rk,
                    MIN(renewed_dt) AS open_dt,
                    MAX(expiration_dt) AS close_dt
            FROM
                account_periods
            GROUP BY account_rk) AS deposits ON filtered_deposits.customer_rk = deposits.customer_rk
                AND deposits.open_dt < filtered_deposits.close_dt
                AND filtered_deposits.close_dt < deposits.close_dt
        WHERE
            deposits.customer_rk IS NULL)