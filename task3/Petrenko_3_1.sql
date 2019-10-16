SELECT 
    customer_rk, customers.nm, nm_number
FROM
    (SELECT 
        CONCAT(first_nm, ' ', middle_nm, ' ', last_nm) AS nm,
            customer_rk
    FROM
        srcdt.cd_customers
    WHERE
        valid_to_dttm = '5999:01:01 00:00:00') customers
        INNER JOIN
    (SELECT 
        CONCAT(first_nm, ' ', middle_nm, ' ', last_nm) AS nm,
            COUNT(DISTINCT customer_rk) AS nm_number
    FROM
        srcdt.cd_customers
    WHERE
        valid_to_dttm = '5999:01:01 00:00:00'
    GROUP BY nm) nm_counter ON customers.nm = nm_counter.nm