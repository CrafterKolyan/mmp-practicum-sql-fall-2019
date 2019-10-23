SELECT
    customer_rk,
    CONCAT(last_nm, ':', first_nm, ':', middle_nm) as full_name
FROM
    cd_customers
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
        AND customer_rk IN (
        SELECT
            valid_deposits.customer_rk
        FROM (
            SELECT
                customer_rk,
                MAX(expiration_dt) AS close_dt
	    FROM
                account_periods
            GROUP BY
                account_rk,
                customer_rk
            HAVING
                YEAR(close_dt) = 2011
        ) AS valid_deposits
        LEFT JOIN (
            SELECT
                customer_rk,
                MIN(renewed_dt) AS open_dt,
                MAX(expiration_dt) AS close_dt
            FROM
                account_periods
            GROUP BY
                account_rk,
                customer_rk
        ) AS open_deposits
        ON valid_deposits.customer_rk = open_deposits.customer_rk
            AND open_deposits.open_dt < valid_deposits.close_dt
            AND valid_deposits.close_dt < open_deposits.close_dt
        WHERE
            open_deposits.customer_rk IS NULL
      )
