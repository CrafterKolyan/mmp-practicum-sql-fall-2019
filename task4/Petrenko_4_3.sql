SELECT 
    MONTH, FROM_CNT, TO_CNT, COUNT(*) AS CNT
FROM
    ((SELECT 
        b.account_rk,
            DATE_FORMAT(b.renewed_dt, '%Y-%m') AS MONTH,
            IFNULL(a.account_renewal_cnt, 0) AS FROM_CNT,
            b.account_renewal_cnt AS TO_CNT
    FROM
        srcdt.account_periods a
    RIGHT JOIN srcdt.account_periods b ON a.account_rk = b.account_rk
        AND a.account_renewal_cnt + 1 = b.account_renewal_cnt) UNION (SELECT 
        a.account_rk,
            DATE_FORMAT(a.expiration_dt, '%Y-%m') AS MONTH,
            a.account_renewal_cnt AS FROM_CNT,
            IFNULL(b.account_renewal_cnt, 2147483647) AS TO_CNT
    FROM
        srcdt.account_periods a
    LEFT JOIN srcdt.account_periods b ON a.account_rk = b.account_rk
        AND a.account_renewal_cnt + 1 = b.account_renewal_cnt)) new_table
WHERE
    MONTH <= DATE_FORMAT(CURDATE(), '%Y-%m')
GROUP BY MONTH , FROM_CNT , TO_CNT