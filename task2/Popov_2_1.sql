SELECT 
	COUNT(*) AS count_unique_unchanged
FROM (
	SELECT
		1
	FROM
		srcdt.cd_customers
	GROUP BY
		customer_rk
	HAVING
		COUNT(*) = 1
) AS unique_unchanged