select
	aged.age as age,
	count(*) as count
from
	(
	select
		timestampdiff(year,
		birth_dt,
		current_date) as age
	from
		srcdt.cd_customers
	where
		valid_to_dttm = "5999-01-01 00:00:00") as aged
where
	aged.age between 15 and 80
group by
	aged.age
order by
	aged.age desc