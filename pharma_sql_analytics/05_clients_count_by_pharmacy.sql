SELECT 
    p_o.pharmacy_name,
    COUNT(DISTINCT p_o.customer_id) AS unique_customers
FROM pharma_orders AS p_o
INNER JOIN customers AS c USING (customer_id)
GROUP BY p_o.pharmacy_name
ORDER BY unique_customers DESC;