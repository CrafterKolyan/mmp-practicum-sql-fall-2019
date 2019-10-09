SELECT year_of_birth, COUNT(*) AS count_clients
FROM
(
SELECT customer_rk, YEAR(ANY_VALUE(birth_dt)) AS year_of_birth
FROM srcdt.cd_customers
WHERE monthly_income_amt IN (50000, 60000)
GROUP BY customer_rk
HAVING COUNT(DISTINCT monthly_income_amt) = 2
) AS upd
GROUP BY year_of_birth