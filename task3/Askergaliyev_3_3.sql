SELECT
    years.year_no,
    IFNULL(left_table.n_opens, 0) AS n_opens,
    IFNULL(left_table.n_prolongations, 0) AS n_prolongations,
    IFNULL(right_table.n_increased_deposits, 0) AS n_increased_deposits
FROM (
    SELECT DISTINCT
        year_no
    FROM
        calendar
    ) AS years
LEFT JOIN (
    SELECT
        YEAR(renewed_dt) AS action_year,
        SUM(account_renewal_cnt = 1) AS n_opens,
        SUM(account_renewal_cnt > 1) AS n_prolongations
    FROM
        account_periods
	GROUP BY
        action_year
    ) AS left_table
ON years.year_no = left_table.action_year
LEFT JOIN (
    SELECT
        YEAR(former_table.renewed_dt) AS action_year,
        COUNT(*) AS n_increased_deposits
    FROM
		account_periods AS former_table
    INNER JOIN
		account_periods AS latter_table
	ON
		former_table.account_rk = latter_table.account_rk
		AND 2 * former_table.opening_amt > 3 * latter_table.opening_amt
		AND former_table.account_renewal_cnt = latter_table.account_renewal_cnt + 1
	GROUP BY
		action_year
    ) AS right_table
ON years.year_no = right_table.action_year
