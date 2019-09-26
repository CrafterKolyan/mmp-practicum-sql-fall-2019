<<<<<<< HEAD
SELECT customer_rk, 
CASE
WHEN middle_nm LIKE '%ИЧ' THEN 'M'
WHEN middle_nm LIKE '%НА' THEN 'F'
END AS gender 
FROM cd_customers WHERE valid_to_dttm = '5999-01-01 00:00:00'
=======
SELECT customer_rk, 
CASE
WHEN middle_nm LIKE ('%ИЧ') THEN 'M'
WHEN middle_nm LIKE ('%НА') THEN 'F'
END AS gender 
FROM srcdt.cd_customers WHERE valid_to_dttm = '5999-01-01 00:00:00'
>>>>>>> Create Saenko_1_1.sql
