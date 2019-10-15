SELECT
  TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS age,
  COUNT(*) AS customers
FROM
  cd_customers
WHERE
  valid_to_dttm = '5999-01-01 00:00:00'
GROUP BY
  age
HAVING
  age BETWEEN 15 AND 80
ORDER BY
  age DESC
