SELECT
    customers.customer_rk,
    customers.full_name,
    full_name_popularity.popularity
FROM (
    SELECT 
        customer_rk,
        CONCAT(last_nm, ':', first_nm, ':', middle_nm) AS full_name
    FROM
        cd_customers
    WHERE
        valid_to_dttm = '5999-01-01 00:00:00'
    ) AS customers
LEFT JOIN (
    SELECT
        CONCAT(last_nm, ':', first_nm, ':', middle_nm) AS full_name,
        COUNT(*) AS popularity
    FROM
        cd_customers
    WHERE
        valid_to_dttm = '5999-01-01 00:00:00'
    GROUP BY
        full_name
    ) AS full_name_popularity
ON customers.full_name = full_name_popularity.full_name
