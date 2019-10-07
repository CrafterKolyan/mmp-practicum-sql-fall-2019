select distinct concat(floor(year(cd_customers.birth_dt) / 10), '0-е') as generation
from srcdt.cd_customers as cd_customers
where cd_customers.valid_to_dttm = '5999-01-01 00:00:00'
order by generation desc