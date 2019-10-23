SELECT
    renewed_dt as open_dt
FROM
    account_periods
UNION
SELECT
    expiration_dt as open_dt
FROM
    account_periods
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY
    open_dt ASC
