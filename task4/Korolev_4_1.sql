SELECT
  renewed_dt AS dates
FROM
  account_periods
UNION
SELECT
  expiration_dt AS dates
FROM
  account_periods
ORDER BY dates ASC