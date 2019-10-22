select
  left_table.customer_rk,
  CONCAT(left_table.last_nm, ' ', left_table.first_nm, ' ', left_table.middle_nm) AS full_name,
  right_table.popularity
from (
    srcdt.cd_customers as left_table
    left join (
        select
            cd_customers_inner.last_nm,
            cd_customers_inner.first_nm,
            cd_customers_inner.middle_nm,
            count(*) as popularity
        from srcdt.cd_customers as cd_customers_inner
        where
            NOW() BETWEEN cd_customers_inner.valid_from_dttm and cd_customers_inner.valid_to_dttm
        group by
            cd_customers_inner.last_nm,
            cd_customers_inner.first_nm,
            cd_customers_inner.middle_nm
        ) as right_table
    on
        left_table.last_nm = right_table.last_nm
        and left_table.first_nm = right_table.first_nm
        and left_table.middle_nm = right_table.middle_nm
)
where
    NOW() BETWEEN left_table.valid_from_dttm and left_table.valid_to_dttm
