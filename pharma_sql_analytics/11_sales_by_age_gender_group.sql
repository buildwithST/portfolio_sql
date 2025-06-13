WITH customers_ages AS
  (SELECT customer_id,
          gender,
          EXTRACT(YEAR
                  FROM AGE(date_of_birth::DATE)) AS customer_age,
          CASE
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth::DATE)) < 30 THEN 'Мужчины младше 30'
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth::DATE)) BETWEEN 30 AND 45 THEN 'Мужчины 30 - 45'
              WHEN gender = 'муж'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth::DATE)) > 45 THEN 'Мужчины 45+'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth::DATE)) < 30 THEN 'Женщины младше 30'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth::DATE)) BETWEEN 30 AND 45 THEN 'Женщины 30 - 45'
              WHEN gender = 'жен'
                   AND EXTRACT(YEAR
                               FROM AGE(date_of_birth::DATE)) > 45 THEN 'Женщины 45+'
              ELSE 'Другая группа'
          END AS customer_group
   FROM customers),
     customer_groups AS
  (SELECT c_a.customer_group,
          COUNT(DISTINCT c_a.customer_id) AS cust_in_group_cnt,
          SUM(p_o.price * p_o.count) AS cust_group_amnt
   FROM customers_ages AS c_a
   INNER JOIN pharma_orders AS p_o USING (customer_id)
   GROUP BY c_a.customer_group),
     total_sales AS
  (SELECT SUM(price * COUNT) AS total_sales
   FROM pharma_orders)
SELECT customer_group,
       cust_in_group_cnt,
       cust_group_amnt,
       total_sales,
       ROUND((cust_group_amnt::numeric * 100 / total_sales::numeric), 1) AS cust_group_share_perc
FROM customer_groups
CROSS JOIN total_sales;