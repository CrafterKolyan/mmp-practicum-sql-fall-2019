-- Подзапрос для агреггации по отрезку времени не обязателен, но он уменьшает время выполнения с 25 минут до 12 секунд

SELECT
	dates.calendar_dt,
    IFNULL(SUM(same_time_deposit_amt), 0) AS open_deposit_amt
FROM (
    SELECT
		*
	FROM
		srcdt.calendar
	WHERE
		calendar_dt BETWEEN (
			SELECT
				MIN(renewed_dt)
			FROM
				srcdt.account_periods
			)
		AND CURDATE()
	) AS dates
LEFT JOIN (
	SELECT
		renewed_dt,
		expiration_dt,
		COUNT(*) AS same_time_deposit_amt
	FROM
		srcdt.account_periods
	GROUP BY
		renewed_dt,
        expiration_dt
	) AS time_segments
ON
	dates.calendar_dt BETWEEN time_segments.renewed_dt AND SUBDATE(time_segments.expiration_dt, 1)
GROUP BY
	dates.calendar_dt
;