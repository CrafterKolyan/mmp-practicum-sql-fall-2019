SELECT count(*) AS cnt
FROM (
	SELECT customer_rk
	FROM cd_customers
	GROUP BY customer_rk
	HAVING count(customer_rk) = 1
) AS a