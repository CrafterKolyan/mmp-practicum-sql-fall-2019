SELECT 
    age, COUNT(*) AS distribution
FROM
    (SELECT 
        TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS age
    FROM
        srcdt.cd_customers
    WHERE
        valid_to_dttm = '5999-01-01 00:00:00') AS ages
WHERE
    age BETWEEN 15 AND 80
GROUP BY age
ORDER BY age DESC;
