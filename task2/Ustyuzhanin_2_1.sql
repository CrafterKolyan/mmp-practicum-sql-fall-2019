SELECT
	count(unique_set)
FROM
(
	SELECT 
		customer_rk as unique_set
	FROM 
		srcdt.cd_customers
	GROUP BY
		customer_rk
	HAVING
		count(customer_rk) = 1
) as sql_kostil
