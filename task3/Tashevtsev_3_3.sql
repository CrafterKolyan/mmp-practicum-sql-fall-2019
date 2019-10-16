SELECT
    cal.YEAR,
    IFNULL(op.COUNT_OPENED, 0),
    IFNULL(ext.COUNT_EXTENDED, 0),
    IFNULL(prof.COUNT_PROFITABLE_EXT, 0)
FROM (
    SELECT DISTINCT
    	year_no as YEAR
    FROM calendar
) as cal
LEFT JOIN (
    SELECT
        YEAR(renewed_dt) as YEAR,
        COUNT(*) as COUNT_OPENED
    FROM account_periods
    WHERE account_renewal_cnt = 1
    GROUP BY YEAR
) as op
ON cal.YEAR = op.YEAR
LEFT JOIN (
    SELECT
        YEAR(renewed_dt) as YEAR,
        COUNT(*) as COUNT_EXTENDED
    FROM account_periods
    WHERE account_renewal_cnt > 1
    GROUP BY YEAR
) as ext
ON cal.YEAR = ext.YEAR
LEFT JOIN (
    SELECT
        YEAR(b.renewed_dt) as YEAR,
        COUNT(*) as COUNT_PROFITABLE_EXT
    FROM
        account_periods as a
    INNER JOIN
        account_periods as b
    ON
        a.account_rk = b.account_rk AND
        a.account_renewal_cnt = b.account_renewal_cnt - 1
    WHERE
        a.opening_amt * 3 < b.opening_amt * 2
    GROUP BY YEAR
) as prof
ON cal.YEAR = prof.YEAR;
