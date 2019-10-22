SELECT
  renewed_dt AS `date`
FROM
  account_periods
UNION
SELECT
  periods1.expiration_dt AS `date`
FROM
  account_periods AS periods1
  JOIN account_periods AS periods2
  ON periods1.account_rk = periods2.account_rk AND periods1.expiration_dt = periods2.renewed_dt
UNION
SELECT
  expiration_dt AS `date`
FROM
  account_periods
  WHERE expiration_dt > '2019-09-01'