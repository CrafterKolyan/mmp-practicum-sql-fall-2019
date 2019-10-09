SELECT 
    age, COUNT(*) AS num_clients
FROM
    (SELECT 
        TIMESTAMPDIFF(YEAR, ANY_VALUE(birth_dt), CURDATE()) AS age
    FROM
        cd_customers
    WHERE
        valid_to_dttm = '5999-01-01 00:00:00') ages
WHERE
    age BETWEEN 15 AND 80
GROUP BY age
ORDER BY age DESC