SELECT 
customer_rk,
CONCAT(srcdt.cd_customers.last_nm, " ", srcdt.cd_customers.first_nm, " ", srcdt.cd_customers.middle_nm) AS full_name,
cnt
FROM srcdt.cd_customers
LEFT JOIN 
(
SELECT first_nm, middle_nm, last_nm, COUNT(*) as cnt
FROM srcdt.cd_customers WHERE valid_to_dttm > CURDATE()
GROUP BY first_nm, middle_nm, last_nm
) AS C 
ON srcdt.cd_customers.first_nm = C.first_nm
AND srcdt.cd_customers.middle_nm = C.middle_nm
AND srcdt.cd_customers.last_nm = C.last_nm
WHERE valid_to_dttm > CURDATE()