CREATE TABLE bike.MonthlySalesTrend
WITH monthly_sales AS (
    SELECT 
        DATE_FORMAT(o.order_date,'%Y-%m') AS month,
        SUM(oi.quantity * oi.list_price *(1-discount)) AS monthly_total_sales
    FROM bike.orders o
    JOIN bike.order_items oi ON o.order_id = oi.order_id
    GROUP BY month
)
SELECT 
    month,
    monthly_total_sales
FROM monthly_sales
ORDER BY month;
SELECT * FROM bike.orders;