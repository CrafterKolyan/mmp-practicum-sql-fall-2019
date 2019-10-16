SELECT 
    customer_rk, cust.full_name, popularity
FROM
    (SELECT 
        customer_rk,
            CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) AS full_name
    FROM
        cd_customers
    WHERE
        valid_to_dttm = '5999-01-01 00:00:00') cust
        INNER JOIN
    (SELECT 
        COUNT(*) AS popularity,
            CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) AS full_name
    FROM
        cd_customers
    WHERE
        valid_to_dttm = '5999-01-01 00:00:00'
    GROUP BY full_name) count_names ON cust.full_name = count_names.full_name