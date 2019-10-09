SELECT CONCAT(SUBSTR(birth_dt, 1, 3), '0-e') as generation
FROM cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00'
GROUP BY generation DESC