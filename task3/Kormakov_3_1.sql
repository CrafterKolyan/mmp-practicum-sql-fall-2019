SELECT 
    customer_rk,
    CONCAT(srcdt.cd_customers.last_nm,
            ' ',
            srcdt.cd_customers.first_nm,
            ' ',
            srcdt.cd_customers.middle_nm) AS full_nm,
    popularity
FROM
    srcdt.cd_customers
    LEFT JOIN
    (SELECT 
        first_nm, middle_nm, last_nm, COUNT(*) AS popularity
    FROM
        srcdt.cd_customers
    WHERE
        (valid_from_dttm <= CURDATE())
            AND (valid_to_dttm >= CURDATE())
    GROUP BY first_nm , middle_nm , last_nm) AS pop 
    ON srcdt.cd_customers.last_nm = pop.last_nm
        AND srcdt.cd_customers.first_nm = pop.first_nm
        AND srcdt.cd_customers.middle_nm = pop.middle_nm
WHERE
    (valid_from_dttm <= CURDATE())
        AND (valid_to_dttm >= CURDATE())
