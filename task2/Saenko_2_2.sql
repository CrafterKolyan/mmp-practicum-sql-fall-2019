SELECT COUNT(*) FROM
(
SELECT customer_rk FROM srcdt.cd_customers WHERE monthly_income_amt IN (50000,60000)
GROUP BY customer_rk
HAVING COUNT(DISTINCT monthly_income_amt) > 1)
AS a

