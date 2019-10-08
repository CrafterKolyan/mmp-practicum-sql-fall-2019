SELECT age_client, COUNT(*) AS count_clients
FROM 
(
SELECT TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS age_client
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00'
) AS customers_ages
WHERE age_client BETWEEN 15 AND 80
GROUP BY age_client
ORDER BY age_client DESC