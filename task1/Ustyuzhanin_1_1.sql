SELECT 
	customer_rk,
    CASE
		WHEN middle_nm LIKE "%НА" THEN 'M'
        WHEN middle_nm LIKE "%ИЧ" THEN 'F'
        ELSE NULL
	END as gender
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00'

