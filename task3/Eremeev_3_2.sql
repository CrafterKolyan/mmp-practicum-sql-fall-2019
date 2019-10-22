SELECT
    calendar_dt, 
    SUM(cnt) as cnt
FROM (SELECT 
          calendar_dt 
      FROM calendar
      WHERE calendar_dt <= CURDATE() AND
            calendar_dt >= (SELECT MIN(DATE(valid_from_dttm))
                            FROM account_periods)) AS cal_sq 
LEFT JOIN (SELECT
               IFNULL(COUNT(account_rk), 0) AS cnt,
               renewed_dt, expiration_dt
           FROM account_periods
           GROUP BY renewed_dt, expiration_dt) AS ap_sq 
ON cal_sq.calendar_dt < ap_sq.expiration_dt AND 
   cal_sq.calendar_dt >= ap_sq.renewed_dt
GROUP BY cal_sq.calendar_dt
