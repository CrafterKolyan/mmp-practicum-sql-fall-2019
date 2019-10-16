SELECT
	state.customer_rk, populary.fio, populary.num
FROM
(SELECT CONCAT(first_nm, " ", middle_nm, " ", last_nm) AS fio, COUNT(*) AS num
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00'
GROUP BY fio) populary
INNER JOIN
(SELECT customer_rk, CONCAT(first_nm, " ", middle_nm, " ", last_nm) AS fio
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01 00:00:00') state 
ON populary.fio=state.fio