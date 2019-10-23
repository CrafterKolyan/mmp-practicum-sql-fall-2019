SELECT DISTINCT
    customers.customer_rk,
    customers.last_nm,
    customers.first_nm,
    customers.middle_nm
FROM srcdt.cd_customers AS customers
WHERE customers.valid_to_dttm = '5999-01-01 00:00:00' AND
      customers.customer_rk in (
    SELECT t1.customer_rk
    FROM (
            SELECT
                customer_rk,
                account_rk,
                max(expiration_dt) AS date_closed
            FROM srcdt.account_periods
            GROUP BY customer_rk, account_rk
            HAVING year(max(expiration_dt)) = 2011
        ) AS t1
    LEFT JOIN (
            SELECT
                customer_rk,
                account_rk,
                max(expiration_dt) AS date_closed,
                min(renewed_dt)    AS date_opened
            FROM srcdt.account_periods
            GROUP BY customer_rk, account_rk
        ) AS t2
    ON t1.customer_rk = t2.customer_rk AND
       t2.date_opened <= t1.date_closed AND
       t2.date_closed > t1.date_closed
    where t2.customer_rk is NULL
)
