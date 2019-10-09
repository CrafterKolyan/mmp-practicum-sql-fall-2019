select filtered_users.birth_year, count(*)
from (
    select any_value(year(cd_customers.birth_dt)) as birth_year
    from srcdt.cd_customers as cd_customers
    where cd_customers.monthly_income_amt in (50000, 60000)
    group by cd_customers.customer_rk
    having count(DISTINCT cd_customers.monthly_income_amt) = 2
) as filtered_users
group by filtered_users.birth_year