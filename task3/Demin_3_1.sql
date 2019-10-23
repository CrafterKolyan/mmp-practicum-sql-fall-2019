SELECT customer_rk, tab_full_nm.full_nm, tab_full_nm.popular 
FROM (
	SELECT customer_rk, concat(last_nm, ' ', first_nm, ' ', middle_nm) as full_nm
    FROM srcdt.cd_customers
    WHERE YEAR(valid_to_dttm) = 5999 
) AS base
INNER JOIN
(
	SELECT count(*) AS popular, concat(last_nm, ' ', first_nm, ' ', middle_nm) AS full_nm
	FROM srcdt.cd_customers 
	WHERE YEAR(valid_to_dttm) = 5999 
    GROUP BY full_nm
) AS tab_full_nm
ON 
	base.full_nm = tab_full_nm.full_nm 
    
