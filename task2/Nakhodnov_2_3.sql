select
    timestampdiff(year, cd_customers.birth_dt, current_date()) as age,
    count(*)
from srcdt.cd_customers as cd_customers
where cd_customers.valid_to_dttm = '5999-01-01 00:00:00'
group by age
having age between 15 and 80
order by age desc
