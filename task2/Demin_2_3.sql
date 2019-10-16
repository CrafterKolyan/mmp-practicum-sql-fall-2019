SELECT cur_age, count(*) AS count_this_age
FROM (
	SELECT TIMESTAMPDIFF(YEAR, max(birth_dt), curdate()) AS cur_age
	FROM srcdt.cd_customers
	GROUP BY customer_rk
) AS uniq
WHERE cur_age BETWEEN 15 AND 80
GROUP BY cur_age 
ORDER BY cur_age DESC