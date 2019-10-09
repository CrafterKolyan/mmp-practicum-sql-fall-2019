SELECT YEAR(birthday) as birthday_year, COUNT(*) as num FROM
	(SELECT DISTINCT any_value(birth_dt) AS birthday
	FROM srcdt.cd_customers 
	WHERE monthly_income_amt IN (50000, 60000)
	GROUP BY customer_rk 
	HAVING COUNT(*)=2) AS result
GROUP BY YEAR(birthday)
