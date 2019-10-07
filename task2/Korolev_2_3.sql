select age, count(*) as quantity
from (
select
  customer_rk,
  TIMESTAMPDIFF(YEAR, birth_dt, CURDATE()) as age
from
  cd_customers
where
  valid_to_dttm = '5999-01-01 00:00:00'
) as a
where age >= 15 and age <= 80
group by age
order by age desc
