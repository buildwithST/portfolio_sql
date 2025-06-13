WITH pharmacy_drug AS
  (SELECT pharmacy_name,
          drug,
          SUM(price * COUNT) AS order_amnt
   FROM pharma_orders
   WHERE LOWER(drug) LIKE 'аква%'
   GROUP BY pharmacy_name,
            drug),
     pharmacy_total_sales AS
  (SELECT pharmacy_name,
          SUM(price * COUNT) AS total_pharmacy_sales
   FROM pharma_orders
   GROUP BY pharmacy_name)
SELECT pd.pharmacy_name,
       pd.drug,
       ROW_NUMBER() OVER (PARTITION BY pd.pharmacy_name
                          ORDER BY pd.order_amnt DESC) AS drug_rank,
       pd.order_amnt,
       pts.total_pharmacy_sales,
       ROUND((pd.order_amnt::numeric * 100 / pts.total_pharmacy_sales::numeric), 1) AS drug_in_pharmacy_share
FROM pharmacy_drug AS pd
INNER JOIN pharmacy_total_sales AS pts USING (pharmacy_name)
ORDER BY pd.pharmacy_name,
         pd.order_amnt DESC;