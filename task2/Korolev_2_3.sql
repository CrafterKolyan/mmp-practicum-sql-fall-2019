SELECT age, COUNT(*) AS quantity
FROM (
  SELECT
    TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) AS age
  FROM
    cd_customers
  WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
  ) AS ages
WHERE
  age >= 15
  AND age <= 80
GROUP BY
  age
ORDER BY
  age DESC
