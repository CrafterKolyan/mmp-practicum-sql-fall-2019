SELECT
  DATE_FORMAT(expiration_dt, "%Y-%m") AS `MONTH`,
  0 AS FROM_CNT,
  account_renewal_cnt AS TO_CNT,
  COUNT(*) AS CNT
FROM
  account_periods
  WHERE account_renewal_cnt = 1 AND expiration_dt <= CURDATE()
  GROUP BY `MONTH`, FROM_CNT, TO_CNT
UNION ALL
SELECT
  DATE_FORMAT(periods1.expiration_dt, "%Y-%m") AS `MONTH`,
  periods1.account_renewal_cnt AS FROM_CNT,
  IFNULL(periods2.account_renewal_cnt, 2147483647) AS TO_CNT,
  COUNT(*) AS CNT
FROM
  account_periods AS periods1
  LEFT JOIN account_periods AS periods2
    ON periods1.account_rk = periods2.account_rk AND periods1.expiration_dt = periods2.renewed_dt
  WHERE periods1.expiration_dt <= CURDATE()
  GROUP BY `MONTH`, FROM_CNT, TO_CNT