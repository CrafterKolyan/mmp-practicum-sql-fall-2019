SELECT DISTINCT 
    CONCAT(FLOOR(YEAR(birth_dt) / 10), '0-е') AS Generation 
FROM cd_customers
WHERE YEAR(valid_to_dttm) = 5999 
ORDER BY Generation DESC 
