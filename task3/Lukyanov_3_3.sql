SELECT res1.year_d,
IFNULL(op_count, 0) AS op_count,
IFNULL(count_prol, 0) AS count_prol,
IFNULL(int_prol, 0) AS int_prol
FROM
(
SELECT YEAR(renewed_dt) AS year_d,
SUM(account_renewal_cnt = 1) AS op_count,
SUM(account_renewal_cnt > 1) AS count_prol
FROM srcdt.account_periods
GROUP BY year_d) AS res1
LEFT JOIN
(
SELECT YEAR(x1.renewed_dt) AS year_d, COUNT(*) AS int_prol
FROM account_periods x1
INNER JOIN account_periods x2 ON x1.account_rk = x2.account_rk
AND x1.account_renewal_cnt = x2.account_renewal_cnt + 1
AND  2 * x1.opening_amt > 3 * x2.opening_amt
GROUP BY year_d) AS res2 
ON res1.year_d = res2.year_d