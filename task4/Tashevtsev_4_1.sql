SELECT renewed_dt as reopen_date FROM account_periods
UNION
SELECT MAX(expiration_dt) as reopen_date FROM account_periods
GROUP BY account_rk
ORDER BY reopen_date ASC;
