SELECT * FROM bike.order_items;
CREATE TABLE bike.Sales_perfromance AS 
SELECT 
    o.store_id, 
    SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
FROM bike.orders o
JOIN bike.order_items oi ON o.order_id = oi.order_id
GROUP BY o.store_id;
