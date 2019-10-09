SELECT age, COUNT(customer_rk) AS customers_cnt
FROM (
	SELECT customer_rk, TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS age
	FROM cd_customers
	WHERE valid_to_dttm = '5999-01-01 00:00:00'
) AS a
GROUP BY age 
HAVING age <= 80 AND age >=15
ORDER BY age DESC