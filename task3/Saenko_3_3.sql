SELECT ytbl.year_no, IFNULL(opened, 0) AS opened, 
IFNULL(prolonged, 0) AS prolonged, IFNULL(big_prolonged, 0) AS big_prolonged
FROM 
(
SELECT DISTINCT year_no 
FROM srcdt.calendar
) AS ytbl
LEFT JOIN 
( 
SELECT YEAR(renewed_dt) AS accs_year,
COUNT(CASE WHEN account_renewal_cnt = 1 THEN 1 END) AS opened,
COUNT(CASE WHEN account_renewal_cnt > 1 THEN 1 END) AS prolonged
FROM srcdt.account_periods
GROUP BY accs_year
) AS a
ON ytbl.year_no = a.accs_year
LEFT JOIN 
(
SELECT YEAR(new_accs.renewed_dt) AS deposit_year,
COUNT(*) AS big_prolonged
FROM srcdt.account_periods AS new_accs
JOIN srcdt.account_periods AS old_accs 
ON new_accs.account_rk = old_accs.account_rk
AND new_accs.account_renewal_cnt - old_accs.account_renewal_cnt = 1
AND new_accs.opening_amt > 1.5 * old_accs.opening_amt 
GROUP BY deposit_year
) AS big_deposits
ON a.accs_year = big_deposits.deposit_year

