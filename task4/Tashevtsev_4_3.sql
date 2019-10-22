SELECT
	DATE_FORMAT(prev_state.expiration_dt, "%Y-%m") AS MONTH,
    prev_state.account_renewal_cnt AS FROM_CNT,
    IFNULL(next_state.account_renewal_cnt, 2147483647) AS TO_CNT,
    COUNT(*) AS CNT
FROM (
	SELECT account_rk, account_renewal_cnt, expiration_dt
	FROM account_periods
    WHERE expiration_dt <= CURDATE()
) AS prev_state LEFT JOIN (
	SELECT account_rk, account_renewal_cnt, renewed_dt
    FROM account_periods
) AS next_state
ON prev_state.account_rk = next_state.account_rk AND
	prev_state.expiration_dt = next_state.renewed_dt
GROUP BY MONTH, FROM_CNT, TO_CNT
UNION
SELECT
	DATE_FORMAT(renewed_dt, "%Y-%m") AS MONTH,
	0 AS FROM_CNT,
    1 AS TO_CNT,
    COUNT(*) AS CNT
FROM account_periods
WHERE account_renewal_cnt = 1 AND renewed_dt <= CURDATE()
GROUP BY MONTH;
