WITH customer_sales AS (
    SELECT 
        c.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        SUM(p_o.price * p_o.count) AS total_spent
    FROM pharma_orders AS p_o
    INNER JOIN customers AS c USING (customer_id)
    GROUP BY c.customer_id, full_name
)
SELECT 
    customer_id,
    full_name,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM customer_sales
ORDER BY customer_rank
LIMIT 10;