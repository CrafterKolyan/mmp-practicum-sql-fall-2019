SELECT DISTINCT concat( substr(YEAR(birth_dt), 1, 3), '0-е' ) AS birth_decade 
FROM cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY birth_decade DESC