SELECT age, count(*) AS number
FROM (SELECT timestampdiff(YEAR, birth_dt, curdate()) AS age
      FROM srcdt.cd_customers
      WHERE valid_to_dttm = '5999-01-01') AS t
WHERE age BETWEEN 15 and 80
GROUP BY age
ORDER BY age DESC;
