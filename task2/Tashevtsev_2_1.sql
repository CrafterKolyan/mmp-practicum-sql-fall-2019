SELECT
	COUNT(*) AS total_customers
FROM (
	SELECT COUNT(*) AS entry_count
	FROM cd_customers
	GROUP BY customer_rk
	HAVING entry_count = 1
) as counter;
