SELECT
    cc.customer_rk,
    cnt.name,
    cnt.amount
FROM
    cd_customers cc
INNER JOIN (
    SELECT
        CONCAT_WS(' ', last_nm, first_nm, middle_nm) AS name,
        COUNT(*) AS amount
    FROM
        cd_customers
    WHERE
        valid_to_dttm = '5999-01-01'
    GROUP BY
        name
) AS cnt
ON
    CONCAT_WS(' ', cc.last_nm, cc.first_nm, cc.middle_nm) = cnt.name
WHERE
    cc.valid_to_dttm = '5999-01-01';
