SELECT
	customer_rk,
	CONCAT(current_customers.last_nm, ' ', current_customers.first_nm, ' ', current_customers.middle_nm) AS full_nm,
    nm_amt
FROM (
	SELECT
		*
	FROM
		srcdt.cd_customers
	WHERE
		NOW() BETWEEN valid_from_dttm AND valid_to_dttm) AS current_customers		
LEFT JOIN (
    SELECT
		last_nm,
		first_nm,
		middle_nm,
		COUNT(*) AS nm_amt
	FROM
		srcdt.cd_customers
	WHERE
		NOW() BETWEEN valid_from_dttm AND valid_to_dttm
	GROUP BY 
		last_nm,
		first_nm,
		middle_nm
	) AS name_amounts
	ON
		current_customers.last_nm = name_amounts.last_nm
		AND current_customers.first_nm = name_amounts.first_nm
		AND current_customers.middle_nm = name_amounts.middle_nm
;