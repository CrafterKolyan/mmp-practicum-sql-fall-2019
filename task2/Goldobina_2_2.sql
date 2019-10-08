SELECT year_of_birth,
       count(*) AS number
FROM (
         SELECT customer_rk,
                year(any_value(birth_dt)) AS year_of_birth
         FROM srcdt.cd_customers
         WHERE monthly_income_amt IN (50000, 60000)
         GROUP BY customer_rk
         HAVING count(DISTINCT monthly_income_amt) = 2) AS t
GROUP BY year_of_birth;
