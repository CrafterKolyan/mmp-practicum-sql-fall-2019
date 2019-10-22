-- Понятие "год" для формулировки "каждый год" взято из таблицы с календарём

SELECT
	years.date_year,
    IFNULL(SUM(deposits.account_renewal_cnt = 1), 0) AS new_opened_amt,
    IFNULL(SUM(deposits.account_renewal_cnt > 1), 0) AS prolonged_amt,
    IFNULL(SUM(1.5 * prev_deposits.opening_amt < deposits.opening_amt), 0) AS profitable_amt
FROM (
	SELECT
		DISTINCT YEAR(calendar_dt) AS date_year
	FROM
		srcdt.calendar
	) as years
LEFT JOIN 
	srcdt.account_periods AS deposits
ON
	years.date_year = YEAR(deposits.renewed_dt)
LEFT JOIN
	srcdt.account_periods AS prev_deposits
ON
	deposits.account_rk = prev_deposits.account_rk
    AND deposits.account_renewal_cnt = prev_deposits.account_renewal_cnt + 1
GROUP BY
	years.date_year
;