SELECT year(t1.renewed_dt) AS year,
       sum(t1.account_renewal_cnt = 1)  AS open,
       sum(t1.account_renewal_cnt != 1) AS prolongate,
       sum(t1.opening_amt > 1.5 * t2.opening_amt) AS prolongate_raise
FROM srcdt.account_periods AS t1
LEFT JOIN srcdt.account_periods AS t2
ON t1.account_rk = t2.account_rk AND t1.renewed_dt = t2.expiration_dt
GROUP BY year(t1.renewed_dt)
