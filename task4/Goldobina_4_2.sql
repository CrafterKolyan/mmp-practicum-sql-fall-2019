SELECT DISTINCT
    customers.customer_rk,
    customers.last_nm,
    customers.first_nm,
    customers.middle_nm
FROM srcdt.cd_customers AS customers
INNER JOIN (
    SELECT t1.customer_rk,
           t1.account_rk,
           t1.date_closed,
           max(t2.expiration_dt) AS all_acc_closed
    FROM (
            SELECT
                customer_rk,
                account_rk,
                max(expiration_dt) AS date_closed,
                min(renewed_dt)    AS date_opened
            FROM srcdt.account_periods
            GROUP BY customer_rk, account_rk
            HAVING year(max(expiration_dt)) = 2011
        ) AS t1
    INNER JOIN srcdt.account_periods AS t2
    ON t1.account_rk != t2.account_rk AND
       t1.customer_rk = t2.customer_rk AND
       t2.renewed_dt <= t1.date_closed
    GROUP BY t1.customer_rk, t1.account_rk, t1.date_closed
    HAVING all_acc_closed <= t1.date_closed
) AS closed_all_acc
ON customers.customer_rk = closed_all_acc.customer_rk AND
   customers.valid_to_dttm = '5999-01-01 00:00:00'
