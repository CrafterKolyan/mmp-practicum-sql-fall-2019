SELECT customer_rk, last_nm, first_nm, middle_nm
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00'
AND customer_rk IN 
(
SELECT DISTINCT quit.customer_rk 
FROM 
(
SELECT customer_rk, account_rk
FROM srcdt.account_periods
GROUP BY customer_rk, account_rk
HAVING YEAR(MAX(expiration_dt)) = 2011
) AS quit
LEFT JOIN 
(
SELECT DISTINCT not_really_ended.customer_rk, not_really_ended.account_rk 
FROM 
(
SELECT customer_rk, account_rk,
MIN(renewed_dt) AS minrenewed, MAX(expiration_dt) AS maxexpired
FROM srcdt.account_periods
GROUP BY customer_rk, account_rk
) AS accs1
JOIN 
(
SELECT customer_rk, account_rk, MAX(expiration_dt) AS maxexpired
FROM srcdt.account_periods
GROUP BY customer_rk, account_rk
HAVING YEAR(maxexpired) = 2011
) AS not_really_ended
ON not_really_ended.customer_rk = accs1.customer_rk AND
not_really_ended.account_rk != accs1.account_rk AND
accs1.minrenewed < not_really_ended.maxexpired AND
not_really_ended.maxexpired < accs1.maxexpired
) AS not_quitted
ON quit.customer_rk = not_quitted.customer_rk AND
quit.account_rk = not_quitted.account_rk
WHERE not_quitted.account_rk IS NULL
)