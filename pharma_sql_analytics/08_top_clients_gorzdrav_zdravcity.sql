WITH gorzdrav_clients AS (
    SELECT 
        p_o.customer_id,
        c.first_name,
        c.last_name,
        COUNT(p_o.order_id) AS total_orders,
        SUM(p_o.price * p_o.count) AS total_spent
    FROM pharma_orders AS p_o
    INNER JOIN customers AS c USING (customer_id)
    WHERE p_o.pharmacy_name = 'Горздрав'
    GROUP BY p_o.customer_id, c.first_name, c.last_name
    ORDER BY total_orders DESC
    LIMIT 10
),
zdravsiti_clients AS (
    SELECT 
        p_o.customer_id,
        c.first_name,
        c.last_name,
        COUNT(p_o.order_id) AS total_orders,
        SUM(p_o.price * p_o.count) AS total_spent
    FROM pharma_orders AS p_o
    INNER JOIN customers AS c USING (customer_id)
    WHERE p_o.pharmacy_name = 'Здравсити'
    GROUP BY p_o.customer_id, c.first_name, c.last_name
    ORDER BY total_orders DESC
    LIMIT 10
)
SELECT 
    'Горздрав' AS pharmacy_name, 
    customer_id, 
    first_name, 
    last_name, 
    total_orders, 
    total_spent
FROM gorzdrav_clients
UNION ALL
SELECT 
    'Здравсити' AS pharmacy_name, 
    customer_id, 
    first_name, 
    last_name, 
    total_orders, 
    total_spent
FROM zdravsiti_clients;