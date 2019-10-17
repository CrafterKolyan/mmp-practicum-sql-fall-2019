SELECT customer_rk, a.full_nm, customers_cnt
FROM (
	SELECT customer_rk, CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) AS full_nm
    FROM cd_customers
    WHERE valid_to_dttm = '5999-01-01 00:00:00'
) a
LEFT JOIN (
	SELECT COUNT(*) AS customers_cnt, CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) AS full_nm
	FROM cd_customers
	WHERE valid_to_dttm = '5999-01-01 00:00:00'
	GROUP BY full_nm
) b
ON a.full_nm = b.full_nm

