SELECT customer_rk,
       (CASE
            WHEN middle_nm LIKE '%А' THEN 'F'
            WHEN middle_nm LIKE '%Ч' THEN 'M'
        END) AS gender
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01';
