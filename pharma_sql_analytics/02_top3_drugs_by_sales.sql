SELECT 
    drug,
    SUM(price * count) AS total_revenue
FROM pharma_orders
GROUP BY drug
ORDER BY total_revenue DESC
LIMIT 3;