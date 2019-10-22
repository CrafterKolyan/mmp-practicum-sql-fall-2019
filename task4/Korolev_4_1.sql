SELECT
  renewed_dt AS `date`
FROM
  account_periods
UNION
SELECT
  expiration_dt AS `date`
FROM
  account_periods
  WHERE expiration_dt > '2019-09-01'
ORDER BY `date` ASC
