SELECT customer_rk, last_nm, first_nm, middle_nm
FROM srcdt.cd_customers
WHERE customer_rk IN (SELECT group_dep.customer_rk
FROM( SELECT account_rk, ANY_VALUE(customer_rk) AS customer_rk, MAX(expiration_dt) AS closedate
FROM srcdt.account_periods GROUP BY account_rk
HAVING YEAR(closedate) = 2011) AS group_dep
LEFT JOIN (
SELECT ANY_VALUE(customer_rk) AS customer_rk,
MIN(renewed_dt) AS opendate, MAX(expiration_dt) AS closedate
FROM srcdt.account_periods GROUP BY account_rk
) AS dep ON group_dep.customer_rk = dep.customer_rk
AND group_dep.closedate > dep.opendate
AND dep.closedate > group_dep.closedate
WHERE dep.customer_rk IS NULL
) AND valid_to_dttm = '5999-01-01 00:00:00'