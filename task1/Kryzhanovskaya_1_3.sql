SELECT DISTINCT
	concat(TRUNCATE(YEAR(birth_dt), -1), '-е') AS generation
FROM 
	cd_customers
WHERE 
	valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY 
	generation DESC
