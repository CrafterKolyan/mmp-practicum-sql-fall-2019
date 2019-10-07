SELECT customer_rk,
	(CASE
		WHEN middle_nm LIKE '%ИЧ' THEN 'M'
        WHEN middle_nm LIKE '%А' THEN 'F'
    END) AS gender
FROM cd_customers
WHERE valid_to_dttm = '5999-01-01'