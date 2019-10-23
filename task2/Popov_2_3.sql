SELECT
	age,
	COUNT(*) AS amount
FROM (
	SELECT
		TIMESTAMPDIFF(YEAR,
			birth_dt,
            CURDATE()) as age
	FROM
		srcdt.cd_customers
	WHERE
		valid_to_dttm = '5999-01-01 00:00:00'
) AS birth_years
WHERE
	age BETWEEN 15 AND 80
GROUP BY
	age
ORDER BY
	age DESC
    
    
		