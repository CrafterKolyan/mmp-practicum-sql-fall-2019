select count(*) as n_unaltered_clients
from (
     select 1
     from srcdt.cd_customers as cd_customers
     group by cd_customers.customer_rk
     having count(*) = 1
) as _
