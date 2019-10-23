SELECT
    calendar_dt,
    IFNULL(COUNT(*), 0) AS COUNT_OPENED
FROM (
    SELECT
        account_rk,
        renewed_dt,
        expiration_dt
    FROM
        account_periods
) as changing_dates
RIGHT JOIN (
    SELECT calendar_dt
    FROM calendar
    WHERE
        calendar_dt <= CURDATE() AND calendar_dt >= (
            SELECT MIN(renewed_dt) FROM account_periods
        )
) as calendar_part
ON
   calendar_dt < expiration_dt AND calendar_dt >= renewed_dt
GROUP BY calendar_dt;
