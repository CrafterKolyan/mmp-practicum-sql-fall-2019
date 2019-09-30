select
	customer_rk,
	case
		when upper(middle_nm) like "%НА" then "F"
		when upper(middle_nm) like "%ИЧ" then "M"
		else "не знаю"
	end as gender
from
	srcdt.cd_customers
where
	valid_to_dttm = "5999-01-01 00:00:00"

