SELECT 
    customer_rk,
    CONCAT(last_nm, ' ', first_nm, ' ', middle_nm) AS fname
FROM cd_customers
WHERE customer_rk IN (
    SELECT 
        customer_rk
    FROM (
        SELECT 
	    customer_rk, 
	    account_rk,
	    max(expiration_dt) AS max_exp_dt
        FROM account_periods
	GROUP BY account_rk, customer_rk
	HAVING YEAR(max_exp_dt) = 2011) AS target_accounts
	LEFT JOIN (
            SELECT
            	ANY_VALUE(customer_rk) AS crk,
                account_rk AS account,
                MIN(renewed_dt) AS opened,
                MAX(expiration_dt) AS closed
            FROM
                account_periods
            GROUP BY account_rk) AS accounts
            ON target_accounts.customer_rk = crk AND max_exp_dt > opened AND max_exp_dt < closed
    WHERE crk IS NULL)
AND YEAR(valid_to_dttm) = 5999
