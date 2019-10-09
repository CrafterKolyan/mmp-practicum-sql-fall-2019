SELECT 
    YEAR(birth_dt) AS birth_year,
    COUNT(DISTINCT customer_rk) AS clients_number
FROM
    srcdt.cd_customers
WHERE
    customer_rk IN (SELECT 
            customer_rk
        FROM
            srcdt.cd_customers
        WHERE
            monthly_income_amt IN (50000 , 60000)
        GROUP BY customer_rk
        HAVING COUNT(DISTINCT monthly_income_amt) = 2)
GROUP BY birth_year