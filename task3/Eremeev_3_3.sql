SELECT 
    valid_sq.renewal_year, 
    openings, 
    renewals,
    large_renewals
FROM (SELECT 
          IFNULL(SUM(account_renewal_cnt = 1), 0) AS openings,
          IFNULL(SUM(account_renewal_cnt >= 2), 0) AS renewals,
          YEAR(renewed_dt) AS renewal_year
      FROM account_periods 
      GROUP BY renewal_year
) AS cnt_sq
LEFT JOIN (SELECT 
               IFNULL(COUNT(ft.account_rk), 0) AS large_renewals,
	       YEAR(ft.renewed_dt) AS renewal_year
	   FROM account_periods AS ft
	   INNER JOIN account_periods AS st
	   ON ft.account_rk = st.account_rk AND
              ft.opening_amt * 2 > st.opening_amt * 3 AND
              st.account_renewal_cnt = ft.account_renewal_cnt - 1
	   GROUP BY renewal_year) AS valid_sq
    ON cnt_sq.renewal_year = valid_sq.renewal_year
