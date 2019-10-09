select
       cd_customers.customer_rk, (
           case
               when cd_customers.middle_nm like '%НА' then 'F'
               when cd_customers.middle_nm like '%ИЧ' then 'M'
               end
           ) as gender
from srcdt.cd_customers as cd_customers
where cd_customers.valid_to_dttm = '5999-01-01 00:00:00'