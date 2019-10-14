SELECT
  calendar_dt,
  SUM(total_accounts) AS number_opened_accounts
FROM
  calendar
  LEFT JOIN
    (SELECT
      renewed_dt,
      expiration_dt,
      COUNT(*) AS total_accounts
    FROM
      account_periods
    GROUP BY renewed_dt,
      expiration_dt) AS open_close_dates
    ON
      renewed_dt <= calendar_dt AND calendar_dt < expiration_dt
WHERE calendar_dt BETWEEN
  (SELECT
    MIN(renewed_dt)
  FROM
    account_periods
  )
  AND CURDATE()
GROUP BY calendar_dt