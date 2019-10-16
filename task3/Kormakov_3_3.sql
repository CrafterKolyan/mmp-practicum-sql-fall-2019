SELECT 
    years.year_no,
    IFNULL(new_dep.deposit_amnt, 0) AS new_deposits_amnt,
    IFNULL(new_dep.prolong_amnt, 0) AS prolong_deposits_amnt,
    IFNULL(rised_deposits.rised_deposits_amnt, 0) AS rised_deposits_amnt
FROM
    (SELECT DISTINCT
        year_no
    FROM
        srcdt.calendar) AS years
        LEFT JOIN
    (SELECT 
        YEAR(renewed_dt) AS year_no,
        SUM(IF(account_renewal_cnt = 1, 1, 0)) AS deposit_amnt,
        SUM(IF(account_renewal_cnt > 1, 1, 0)) AS prolong_amnt
    FROM
        srcdt.account_periods
    GROUP BY year_no) AS new_dep
    ON years.year_no = new_dep.year_no
    LEFT JOIN
    (SELECT 
		YEAR(acc_p2.renewed_dt) AS year_no,
		COUNT(*) AS rised_deposits_amnt
    FROM 
		srcdt.account_periods AS acc_p1, srcdt.account_periods AS acc_p2
	WHERE acc_p1.account_rk =  acc_p2.account_rk 
		AND acc_p1.account_renewal_cnt + 1 = acc_p2.account_renewal_cnt
        AND 3 * acc_p1.opening_amt < 2 * acc_p2.opening_amt
    GROUP BY year_no) AS rised_deposits
    ON new_dep.year_no = rised_deposits.year_no;
