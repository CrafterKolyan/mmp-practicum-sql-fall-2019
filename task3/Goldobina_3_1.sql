SELECT t1.customer_rk,
       t2.name,
       t2.count
FROM srcdt.cd_customers AS t1
INNER JOIN (
    SELECT concat_ws(' ', last_nm, first_nm, middle_nm) AS name,
           count(*)                                     AS count
    FROM srcdt.cd_customers
    WHERE valid_to_dttm = '5999-01-01'
    GROUP BY name
) AS t2
ON concat_ws(' ', t1.first_nm, t1.middle_nm, t1.last_nm) = t2.name
AND t1.valid_to_dttm = '5999-01-01';
