SELECT COUNT(*) AS numb
FROM
(
SELECT customer_rk AS d
FROM srcdt.cd_customers
GROUP BY customer_rk
HAVING COUNT(customer_rk) = 1) AS cust