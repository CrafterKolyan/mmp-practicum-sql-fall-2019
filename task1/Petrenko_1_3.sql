SELECT DISTINCT
    CONCAT(YEAR(birth_dt) DIV 10, '0-е') AS generation
FROM
    srcdt.cd_customers
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY generation DESC