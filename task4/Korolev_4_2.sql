SELECT
  cd_customers.customer_rk,
  cd_customers.last_nm,
  cd_customers.first_nm,
  cd_customers.middle_nm
FROM (
  SELECT DISTINCT
    ANY_VALUE(customer_rk) AS customer_rk,
  FROM account_periods
  GROUP BY account_rk
  HAVING YEAR(MAX(expiration_dt)) = 2011
) AS customer_ids
JOIN
  cd_customers
ON cd_customers.customer_rk = customer_ids.customer_rk
WHERE valid_to_dttm = '5999-01-01 00:00:00'
      AND customer_rk NOT IN (
        SELECT
          customer_rk
        FROM (
          SELECT calendar_dt
          FROM calendar
          WHERE year_no = 2011
        ) AS dates
          JOIN
          (SELECT 
            MIN(renewed_dt) AS open_dt,
            MAX(expiration_dt) AS close_dt,
            ANY_VALUE(customer_rk) AS customer_rk
          FROM account_periods
          GROUP BY account_rk) AS accounts
          ON accounts.open_dt < dates.calendar_dt AND dates.calendar_dt < accounts.close_dt
        GROUP BY customer_rk
        HAVING COUNT(DISTINCT calendar_dt) = (
          SELECT COUNT(DISTINCT calendar_dt)
          FROM calendar
          WHERE year_no = 2011
        )
      )