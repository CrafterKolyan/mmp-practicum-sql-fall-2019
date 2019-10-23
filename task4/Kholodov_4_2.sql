SELECT
    customer_rk,
    CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) as full_name
FROM cd_customers
WHERE 
valid_to_dttm = '5999-01-01 00:00:00' AND customer_rk IN (
        SELECT deposits_closed_in_2011.customer_rk
        FROM (
            SELECT
                account_rk,
                ANY_VALUE(customer_rk) AS customer_rk,
                MAX(expiration_dt) AS close_date
            FROM
                account_periods
            GROUP BY account_rk
            HAVING YEAR(close_date) = 2011
        ) AS deposits_closed_in_2011
        LEFT JOIN (
            SELECT
                ANY_VALUE(customer_rk) AS customer_rk,
                MIN(renewed_dt) AS open_date,
                MAX(expiration_dt) AS close_date
            FROM
                account_periods
            GROUP BY account_rk
        ) as deposits
        ON deposits_closed_in_2011.customer_rk = deposits.customer_rk
           AND deposits_closed_in_2011.close_date < deposits.close_date
           AND deposits.open_date < deposits_closed_in_2011.close_date
        WHERE deposits.customer_rk IS NULL
      )