SELECT DISTINCT
	concat(floor(year(birth_dt)/10)*10, '-e') as generation
FROM
	srcdt.cd_customers
WHERE
	valid_to_dttm = '5999-01-01 00:00:00'
ORDER BY
	generation DESC