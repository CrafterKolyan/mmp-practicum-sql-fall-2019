SELECT count(*) AS number
FROM (SELECT count(*) AS num_records
      FROM srcdt.cd_customers
      GROUP BY customer_rk) AS t
WHERE num_records = 1;
