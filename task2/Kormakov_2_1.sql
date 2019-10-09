SELECT 
    COUNT(*) AS not_changed_persons_amnt
FROM
    (SELECT 
        customer_rk
    FROM
        srcdt.cd_customers
    GROUP BY customer_rk
    HAVING COUNT(customer_rk) = 1) AS not_changed_persons