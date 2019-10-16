SELECT
	cust.customer_rk,
    counter.NAME,
    counter.NAME_COUNT
FROM (
	SELECT
		customer_rk,
		CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) as NAME
    FROM cd_customers
    WHERE valid_to_dttm = '5999-01-01 00:00:00'
) as cust
INNER JOIN (
	SELECT
		CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) as NAME,
		COUNT(*) as NAME_COUNT
	FROM cd_customers
	WHERE valid_to_dttm = '5999-01-01 00:00:00'
	GROUP BY NAME
) as counter
ON counter.NAME = cust.NAME;
