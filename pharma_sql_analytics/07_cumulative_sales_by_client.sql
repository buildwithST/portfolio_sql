WITH customer_orders AS (
    SELECT 
        p_o.customer_id,
        CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name,
        p_o.report_date::DATE AS order_date,
        SUM(p_o.price * p_o.count) AS total_spent
    FROM pharma_orders AS p_o
    INNER JOIN customers AS c USING (customer_id)
    GROUP BY p_o.customer_id, full_name, order_date
)
SELECT 
    customer_id,
    full_name,
    order_date,
    total_spent,
    SUM(total_spent) OVER (PARTITION BY customer_id ORDER BY order_date) AS cumulative_spent
FROM customer_orders
ORDER BY customer_id, order_date;