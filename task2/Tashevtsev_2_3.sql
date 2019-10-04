SELECT
	age, COUNT(*) as customer_count
FROM (
	SELECT DISTINCT
		customer_rk,
		TIMESTAMPDIFF(YEAR, ANY_VALUE(birth_dt), CURDATE()) AS age
	FROM cd_customers
	GROUP BY customer_rk
) AS ages
WHERE age BETWEEN 15 AND 80
GROUP BY age
ORDER BY age DESC;
