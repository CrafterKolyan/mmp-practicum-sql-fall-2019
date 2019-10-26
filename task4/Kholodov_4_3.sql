SELECT
  DATE_FORMAT(tabl1.expiration_dt, "%Y-%m") AS `MONTH`,
  tabl1.account_renewal_cnt AS FROM_CNT,
  IFNULL(tabl2.account_renewal_cnt, 2147483647) AS TO_CNT,
  COUNT(*) AS CNT
FROM
	account_periods AS tabl1
  LEFT JOIN 
	account_periods AS tabl2
ON tabl1.expiration_dt = tabl2.renewed_dt AND tabl1.account_rk = tabl2.account_rk 
  WHERE tabl1.expiration_dt <= CURDATE()
  GROUP BY `MONTH`, FROM_CNT, TO_CNT
UNION ALL
SELECT
  DATE_FORMAT(renewed_dt, "%Y-%m") AS `MONTH`,
  0 AS FROM_CNT,
  1 AS TO_CNT,
  COUNT(*) AS CNT
FROM
  account_periods
  WHERE account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
  GROUP BY `MONTH`, FROM_CNT, TO_CNT