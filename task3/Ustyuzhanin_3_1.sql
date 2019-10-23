SELECT 
	customer_rk, a.nm, popularity
FROM
(
	SELECT
		customer_rk, CONCAT(last_nm, " ", first_nm, " ", middle_nm) as nm
	FROM
		srcdt.cd_customers
	WHERE
		valid_to_dttm = '5999-01-01 00:00:00'
) a
INNER JOIN
(
	SELECT
		CONCAT(last_nm, " ", first_nm, " ", middle_nm) as nm, COUNT(*) as popularity
	FROM
		srcdt.cd_customers
	WHERE
		valid_to_dttm = '5999-01-01 00:00:00'
	GROUP BY
		nm
) b
ON (a.nm = b.nm)