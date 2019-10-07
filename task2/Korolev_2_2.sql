SELECT COUNT(*) FROM (
SELECT customer_rk
FROM cd_customers
WHERE monthly_income_amt IN (50000, 60000)
GROUP BY customer_rk
HAVING COUNT(DISTINCT monthly_income_amt) = 2
) as filtered_customers
