SELECT DISTINCT
    concat(floor(year(birth_dt) / 10), '0-е') AS generation
FROM
    cd_customers
WHERE
    valid_to_dttm = '5999-01-01'
ORDER BY
    generation DESC;
