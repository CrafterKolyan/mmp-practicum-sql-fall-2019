SELECT
  TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS age,
  COUNT(*) AS customers
FROM
  cd_customers
WHERE
  valid_to_dttm = '5999-01-01 00:00:00'
  AND TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) BETWEEN 15 AND 80
GROUP BY
  age
ORDER BY
  age DESC
