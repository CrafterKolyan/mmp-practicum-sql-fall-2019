SELECT age, COUNT(*) AS count
FROM
(
SELECT DISTINCT customer_rk, 
TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS age 
FROM cd_customers
) AS a
WHERE age < 81 AND age > 14
GROUP BY age
ORDER BY age DESC
