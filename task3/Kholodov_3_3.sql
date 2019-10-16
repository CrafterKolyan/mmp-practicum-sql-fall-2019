SELECT 
	deps.dep_year,
    IFNULL(new_dep, 0) as new_dep,
    IFNULL(con_dep, 0) as con_dep,
	IFNULL(big_dep, 0) as big_dep
FROM (SELECT 
YEAR(renewed_dt) as dep_year,
SUM(account_renewal_cnt = 1) as new_dep,
SUM(account_renewal_cnt > 1) as con_dep
FROM srcdt.account_periods
GROUP BY dep_year) deps
LEFT JOIN
(SELECT YEAR(table_1.renewed_dt) as dep_year,  COUNT(*) as big_dep
FROM srcdt.account_periods as table_1 INNER JOIN srcdt.account_periods as table_2 
ON table_1.account_rk = table_2.account_rk
	AND table_1.account_renewal_cnt + 1 = table_2.account_renewal_cnt
	AND table_1.opening_amt > 1.5 * table_2.opening_amt
GROUP BY dep_year
) big_deps
ON deps.dep_year = big_deps.dep_year
