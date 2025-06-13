SELECT 
    pharmacy_name,
    report_date::DATE AS order_date,
    SUM(price * count) OVER (PARTITION BY pharmacy_name ORDER BY report_date::DATE) AS cumulative_sales
FROM pharma_orders
ORDER BY pharmacy_name, order_date;