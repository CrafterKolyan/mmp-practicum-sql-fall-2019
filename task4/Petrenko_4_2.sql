SELECT 
    cust.customer_rk, last_nm, first_nm, middle_nm
FROM
    srcdt.cd_customers cust
        INNER JOIN
    (SELECT 
        customer_rk, ANY_VALUE(if_null) AS if_null
    FROM
        (SELECT 
        a.customer_rk AS customer_rk, b.customer_rk AS if_null
    FROM
        (SELECT 
        customer_rk, MAX(expiration_dt) AS close_dt
    FROM
        srcdt.account_periods
    GROUP BY customer_rk , account_rk
    HAVING YEAR(close_dt) = 2011) a
    LEFT JOIN (SELECT 
        customer_rk,
            MIN(renewed_dt) AS open_dt,
            MAX(expiration_dt) AS close_dt
    FROM
        srcdt.account_periods
    GROUP BY customer_rk , account_rk) b ON a.customer_rk = b.customer_rk
        AND a.close_dt > b.open_dt
        AND a.close_dt < b.close_dt) t
    GROUP BY customer_rk) flag ON cust.customer_rk = flag.customer_rk
        AND if_null IS NULL
WHERE
    cust.valid_to_dttm = '5999-01-01 00:00:00'