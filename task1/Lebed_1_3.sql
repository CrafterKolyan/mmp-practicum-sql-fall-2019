select
	concat(generations.generation, "-е") as generation
from
	(
	select
		distinct (year(birth_dt) - year(birth_dt) % 10) as generation
	from
		srcdt.cd_customers
	where
		birth_dt is not null
		and valid_to_dttm = "5999-01-01 00:00:00") as generations
order by
	generations.generation desc