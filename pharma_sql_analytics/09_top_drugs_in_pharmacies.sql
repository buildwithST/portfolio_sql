WITH moscow_sales AS (
    SELECT 
        TO_CHAR(report_date::DATE, 'YYYY-MM-DD') AS month,
        pharmacy_name,
        SUM(price * count) AS total_sales
    FROM pharma_orders
    WHERE city = 'Москва'
    GROUP BY month, pharmacy_name
),
spb_sales AS (
    SELECT 
        TO_CHAR(report_date::DATE, 'YYYY-MM-DD') AS month,
        pharmacy_name,
        SUM(price * count) AS total_sales
    FROM pharma_orders
    WHERE city = 'Санкт-Петербург'
    GROUP BY month, pharmacy_name
)
SELECT 
    m.month,
    m.pharmacy_name,
    m.total_sales AS moscow_sales,
    s.total_sales AS spb_sales,
    ROUND(((m.total_sales - s.total_sales) * 100.0 / NULLIF(s.total_sales, 0)), 1) AS sales_diff_percent
FROM moscow_sales AS m
FULL JOIN spb_sales AS s USING (month, pharmacy_name)
ORDER BY month, pharmacy_name;