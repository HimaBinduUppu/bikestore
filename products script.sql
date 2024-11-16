SELECT * FROM bike.products;
CREATE TABLE bike.BestSelling_products
SELECT 
    p.category_id, 
    p.product_id,p.product_name, 
    SUM(oi.quantity) AS units_sold
FROM bike.products p
JOIN bike.order_items oi ON p.product_id = oi.product_id
GROUP BY p.category_id, p.product_id,p.product_name
ORDER BY units_sold DESC;

CREATE TABLE bike.Product_CategorySales_Contribution
WITH category_sales AS (
    SELECT 
        c.category_id, c.category_name,
        SUM(oi.quantity * oi.list_price * (1-discount)) AS category_total_sales
    FROM bike.categories c
    JOIN bike.products p ON c.category_id = p.category_id
    JOIN bike.order_items oi ON p.product_id = oi.product_id
    GROUP BY c.category_id, category_name
),
total_sales AS (
    SELECT SUM(category_total_sales) AS overall_sales
    FROM category_sales
)
SELECT 
    cs.category_id,cs.category_name,
    cs.category_total_sales,
    (cs.category_total_sales / ts.overall_sales) * 100 AS sales_contribution_pct
FROM category_sales cs, total_sales ts;
