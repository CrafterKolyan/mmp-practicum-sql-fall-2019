SELECT old, count(old) as num FROM
(SELECT TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) as old
FROM srcdt.cd_customers
WHERE valid_to_dttm = '5999-01-01'
) AS result
WHERE old BETWEEN 15 AND 80
GROUP BY old
ORDER BY old DESC
