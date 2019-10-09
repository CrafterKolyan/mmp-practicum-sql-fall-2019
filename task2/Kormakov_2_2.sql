SELECT 
    birth_date, COUNT(*) AS amnt_of_50k_60k
FROM
    (SELECT 
        YEAR(ANY_VALUE(birth_dt)) AS birth_date
    FROM
        srcdt.cd_customers
    WHERE
        monthly_income_amt IN (50000 , 60000)
    GROUP BY customer_rk
 HAVING COUNT(DISTINCT monthly_income_amt) >= 2) AS grouped_birth_date
GROUP BY birth_date;
