SELECT t1.calendar_dt,
       coalesce(sum(t2.count), 0) AS count
FROM (
     SELECT calendar_dt
     FROM srcdt.calendar
     WHERE calendar_dt BETWEEN (SELECT min(renewed_dt) FROM srcdt.account_periods)
           AND current_date()
) AS t1
LEFT JOIN (
    SELECT renewed_dt,
           expiration_dt,
           count(*) AS count
    FROM srcdt.account_periods
    GROUP BY renewed_dt, expiration_dt
) AS t2
ON t1.calendar_dt >= t2.renewed_dt AND t1.calendar_dt < t2.expiration_dt
GROUP BY t1.calendar_dt
