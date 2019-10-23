SELECT
    customer_rk,
    last_nm,
    first_nm,
    middle_nm
FROM
    cd_customers
WHERE
    customer_rk IN (
    SELECT
        proper_deps.customer_rk
    FROM (
        SELECT
            customer_rk,
            account_rk,
            MAX(expiration_dt) AS end
        FROM
            account_periods
        GROUP BY
            customer_rk,
            account_rk
        HAVING
            YEAR(end) = 2011
    ) AS proper_deps
    LEFT JOIN (
        SELECT
            customer_rk,
            MIN(renewed_dt) AS start,
            MAX(expiration_dt) AS end
        FROM
            account_periods
        GROUP BY
            customer_rk,
            account_rk
    ) AS deps
    ON
        proper_deps.customer_rk = deps.customer_rk AND
        deps.start < proper_deps.end AND
        proper_deps.end < deps.end
    WHERE
        deps.customer_rk IS NULL
    ) AND
    valid_to_dttm = '5999-01-01';
