SELECT DISTINCT
    CONCAT(TRUNCATE(YEAR(birth_dt), - 1), '-e') AS generation
FROM
    srcdt.cd_customers
WHERE
    valid_to_dttm = '5999-01-01 00:00:00'
        AND birth_dt IS NOT NULL
ORDER BY generation DESC;
