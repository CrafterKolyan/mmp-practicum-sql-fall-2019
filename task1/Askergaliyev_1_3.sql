SELECT DISTINCT
    CONCAT(FLOOR(YEAR(birth_dt) / 10), '0-e')
        AS generation
FROM
    cd_customers
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY
    generation DESC
