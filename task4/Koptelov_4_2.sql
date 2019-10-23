SELECT 
    finished_deposits.customer_rk, last_nm, first_nm, middle_nm
FROM
    (SELECT 
        finished_deposits.customer_rk AS customer_rk,
            last_nm,
            first_nm,
            middle_nm,
            close_dt
    FROM
        (SELECT 
        *
    FROM
        cd_customers
    WHERE
        valid_to_dttm = '5999-01-01 00:00:00') all_customers
    INNER JOIN (SELECT 
        account_rk, customer_rk, MAX(expiration_dt) AS close_dt
    FROM
        account_periods
    GROUP BY customer_rk , account_rk
    HAVING YEAR(close_dt) = 2011) finished_deposits ON all_customers.customer_rk = finished_deposits.customer_rk) finished_deposits
        LEFT JOIN
    (SELECT 
        customer_rk,
            MIN(renewed_dt) AS open_dt,
            MAX(expiration_dt) AS close_dt
    FROM
        account_periods
    GROUP BY customer_rk , account_rk) all_deposits ON finished_deposits.customer_rk = all_deposits.customer_rk
        AND all_deposits.open_dt < finished_deposits.close_dt
        AND finished_deposits.close_dt < all_deposits.close_dt
WHERE
    all_deposits.customer_rk IS NULL