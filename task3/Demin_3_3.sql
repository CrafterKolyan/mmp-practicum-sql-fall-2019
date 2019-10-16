SELECT prol.dt_year, prol.cnt_prolonged, prol_more_50.cnt_more_50,
	CASE 
		WHEN opened.cnt_opened > 0 THEN opened.cnt_opened
        ELSE 0
	END AS cnt_opened
FROM 
(
	SELECT count(*) as cnt_prolonged, YEAR(valid_from_dttm) as dt_year
	FROM srcdt.account_periods
	WHERE account_renewal_cnt != 1
	GROUP BY YEAR(valid_from_dttm)
        
) AS prol
LEFT JOIN 
( 
	SELECT YEAR(valid_from_dttm) as dt_year, count(*) as cnt_opened
	FROM srcdt.account_periods
    WHERE account_renewal_cnt = 1 
	GROUP BY YEAR(valid_from_dttm)
) AS opened
ON prol.dt_year=opened.dt_year 
LEFT JOIN 
(
	SELECT dt_year, count(*) as cnt_more_50
	FROM 
	(	
		SELECT YEAR(valid_to_dttm) as dt_year, account_rk, account_renewal_cnt as ac_per_prev, opening_amt as prev_amt
		FROM srcdt.account_periods
	) AS a
	LEFT JOIN
	(
		SELECT account_rk, account_renewal_cnt as ac_per_next, opening_amt as next_amt
		FROM srcdt.account_periods
	) AS b 
	ON a.account_rk = b.account_rk AND a.ac_per_prev = b.ac_per_next - 1
	WHERE 2*(b.next_amt - a.prev_amt) > a.prev_amt
	GROUP BY dt_year
) prol_more_50
ON prol.dt_year = prol_more_50.dt_year
