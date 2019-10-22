SELECT a.renewed_year, cnt_opens, cnt_prolong, IFNULL(cnt_increased, 0) AS cnt_increased
FROM(
	SELECT 
		YEAR(renewed_dt) AS renewed_year, 
		SUM(account_renewal_cnt = 1) AS cnt_opens, 
		SUM(account_renewal_cnt >= 2) AS cnt_prolong
	FROM account_periods
	GROUP BY renewed_year
) a
LEFT JOIN (
	SELECT YEAR(a.renewed_dt) AS renewed_year, COUNT(*) AS cnt_increased
	FROM account_periods a
	INNER JOIN account_periods b
	ON 
		(a.account_rk = b.account_rk) 
		AND (a.account_renewal_cnt = b.account_renewal_cnt + 1) 
		AND (a.opening_amt > 1.5 * b.opening_amt)
	GROUP BY renewed_year
) b
ON a.renewed_year = b.renewed_year
