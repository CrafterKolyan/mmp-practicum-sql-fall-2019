SELECT 
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> little changes
=======
>>>>>>> f8c718810deedfba7ef77cc2743960c19890ea09
    op_con.deposit_year,
    IFNULL(opens, 0) AS opens,
    IFNULL(continues, 0) AS continues,
    IFNULL(deposit_big, 0) AS deposit_big
<<<<<<< HEAD
<<<<<<< HEAD
=======
    op_con.deposit_year, opens, continues, deposit_big
>>>>>>> solved task_3
=======
>>>>>>> little changes
=======
>>>>>>> f8c718810deedfba7ef77cc2743960c19890ea09
FROM
    (SELECT 
        YEAR(renewed_dt) AS deposit_year,
            SUM(account_renewal_cnt = 1) AS opens,
            SUM(account_renewal_cnt > 1) AS continues
    FROM
        account_periods
    GROUP BY deposit_year) op_con
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
        LEFT JOIN
=======
        JOIN
>>>>>>> solved task_3
=======
        LEFT JOIN
>>>>>>> little changes
=======
        LEFT JOIN
>>>>>>> f8c718810deedfba7ef77cc2743960c19890ea09
    (SELECT 
        YEAR(acc1.renewed_dt) AS deposit_year,
            COUNT(*) AS deposit_big
    FROM
        account_periods acc1
<<<<<<< HEAD
<<<<<<< HEAD
<<<<<<< HEAD
    INNER JOIN account_periods acc2 ON acc1.account_rk = acc2.account_rk
=======
    JOIN account_periods acc2 ON acc1.account_rk = acc2.account_rk
>>>>>>> solved task_3
=======
    INNER JOIN account_periods acc2 ON acc1.account_rk = acc2.account_rk
>>>>>>> little changes
=======
    INNER JOIN account_periods acc2 ON acc1.account_rk = acc2.account_rk
>>>>>>> f8c718810deedfba7ef77cc2743960c19890ea09
        AND acc1.account_renewal_cnt - acc2.account_renewal_cnt = 1
        AND acc1.opening_amt > 1.5 * acc2.opening_amt
    GROUP BY deposit_year) big ON op_con.deposit_year = big.deposit_year