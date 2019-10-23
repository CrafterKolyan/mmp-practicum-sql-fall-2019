SELECT count(*) as count_no_change
FROM (
	SELECT 
		customer_rk,
		count(customer_rk) as count_uniq
	FROM srcdt.cd_customers
	GROUP BY customer_rk
	HAVING count_uniq=1
) AS count_uniq