SELECT
    YEAR(birth_dt) AS year,
    COUNT(*) AS cnt_customers
FROM (
    SELECT
        ANY_VALUE(birth_dt) AS birth_dt
    FROM
        cd_customers
    WHERE
        monthly_income_amt IN (50000, 60000)
    GROUP BY
        customer_rk
    HAVING
        COUNT(DISTINCT monthly_income_amt) = 2
    ) AS customers_with_2_salaries
GROUP BY
    YEAR(birth_dt);
