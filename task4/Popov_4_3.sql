SELECT
	DATE_FORMAT(periods_new.renewed_dt, "%Y-%m") AS `MONTH`,
	periods_old.account_renewal_cnt AS FROM_CNT,
	IFNULL(periods_new.account_renewal_cnt, 2147483647) AS TO_CNT,
	COUNT(*) AS CNT
FROM
	srcdt.account_periods AS periods_old
LEFT JOIN
    srcdt.account_periods AS periods_new
ON 
	periods_old.account_rk = periods_new.account_rk 
    AND periods_old.expiration_dt = periods_new.renewed_dt
WHERE
	periods_old.expiration_dt <= CURDATE()
GROUP BY `MONTH`, FROM_CNT, TO_CNT
UNION
SELECT
	DATE_FORMAT(renewed_dt, "%Y-%m") AS `MONTH`,
	0 AS FROM_CNT,
	1 AS TO_CNT,
	COUNT(*) AS CNT
FROM
	srcdt.account_periods
WHERE account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
GROUP BY `MONTH`