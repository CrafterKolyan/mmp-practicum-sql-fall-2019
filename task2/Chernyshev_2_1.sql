SELECT
    COUNT(*) AS cnt_only_one_edit
FROM (
    SELECT
        customer_rk
    FROM
        cd_customers
    GROUP BY
        customer_rk
    HAVING
        COUNT(*) = 1
    ) AS only_one_edit;
