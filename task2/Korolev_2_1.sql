SELECT
  COUNT(*)
FROM (
  SELECT
    1
  FROM
    cd_customers
  GROUP BY
    customer_rk
  HAVING
    COUNT(*) = 1
  ) AS unique_customers
