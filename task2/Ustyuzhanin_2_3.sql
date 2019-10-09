SELECT 
	count(customer_rk), TIMESTAMPDIFF(YEAR, birth_dt, curdate()) as dt
FROM 
	srcdt.cd_customers
WHERE 
	valid_to_dttm = '5999-01-01 00:00:00'
GROUP BY
	dt
HAVING
	dt >= 15 AND dt <= 80
ORDER BY
	dt DESC
