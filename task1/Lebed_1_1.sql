select
	customer_rk,
	case
		when middle_nm like "%НА" then "F"
		when middle_nm like "%ИЧ" then "M"
	end as gender
from
	srcdt.cd_customers
where
	valid_to_dttm = "5999-01-01 00:00:00"

