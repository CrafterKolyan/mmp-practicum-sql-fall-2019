SELECT birth_year, COUNT(*) FROM
(
SELECT YEAR(ANY_VALUE(birth_dt)) AS birth_year
FROM cd_customers WHERE monthly_income_amt IN (50000,60000)
GROUP BY customer_rk
HAVING COUNT(DISTINCT monthly_income_amt) > 1
)
AS a
GROUP BY birth_year

