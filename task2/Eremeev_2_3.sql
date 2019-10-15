SELECT 
	TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS Age, 
	count(DISTINCT customer_rk) AS Number_of_customers 
FROM cd_customers 
WHERE YEAR(valid_to_dttm) = 5999
GROUP BY Age
HAVING Age <= 80 AND Age >= 15
ORDER BY Age DESC
