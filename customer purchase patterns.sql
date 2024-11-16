CREATE TABLE bike.customer_purchase_patterns
SELECT 
    c.customer_id, 
    COUNT(o.order_id) AS total_orders, 
    SUM(oi.quantity * oi.list_price *(1-discount)) AS total_spent
FROM bike.customers c
JOIN bike.orders o ON c.customer_id = o.customer_id
JOIN bike.order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id;