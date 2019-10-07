SELECT
    customer_rk,
    CASE
        WHEN middle_nm LIKE '%А' THEN 'F'
        WHEN middle_nm LIKE '%Ч' THEN 'M'
    END AS Gender
FROM cd_customers WHERE YEAR(valid_to_dttm) = 5999
