SELECT
    customer_rk, 
    CONCAT(names_sq.last_nm, ' ', names_sq.first_nm, ' ', names_sq.middle_nm) AS complete_name,
    cnt 
FROM (SELECT
          customer_rk,
          first_nm, middle_nm, last_nm,
          CONCAT(first_nm, '|', middle_nm, '|', last_nm) AS complete_name
      FROM cd_customers
      WHERE YEAR(valid_to_dttm) = 5999) AS names_sq
LEFT JOIN (SELECT
               COUNT(customer_rk) AS cnt,
               CONCAT(first_nm, '|', middle_nm, '|', last_nm) AS complete_name
           FROM cd_customers
           WHERE YEAR(valid_to_dttm) = 5999
           GROUP BY complete_name) AS cnt_sq
    ON names_sq.complete_name = cnt_sq.complete_name
