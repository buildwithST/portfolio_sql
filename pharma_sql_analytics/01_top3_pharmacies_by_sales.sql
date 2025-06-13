SELECT 
    pharmacy_name,
    SUM(price * count) AS total_revenue
FROM pharma_orders
GROUP BY pharmacy_name
ORDER BY total_revenue DESC
LIMIT 3;