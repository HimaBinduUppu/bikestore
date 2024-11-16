SELECT * FROM bike.customers;
CREATE TABLE bike.customer_purchase_patterns
SELECT 
    c.customer_id, 
    COUNT(o.order_id) AS total_orders, 
    SUM(oi.quantity * oi.list_price *(1-discount)) AS total_spent
FROM bike.customers c
JOIN bike.orders o ON c.customer_id = o.customer_id
JOIN bike.order_items oi ON o.order_id = oi.order_id
GROUP BY c.customer_id;

CREATE TABLE bike.TopSpentCustomer
SELECT customer_id, total_spent,customer_name
FROM (
    SELECT 
        c.customer_id,c.customer_name,
        SUM(oi.quantity * oi.list_price *(1-discount)) AS total_spent
    FROM bike.customers c
    JOIN bike.orders o ON c.customer_id = o.customer_id
    JOIN bike.order_items oi ON o.order_id = oi.order_id
    GROUP BY c.customer_id,c.customer_name
) AS customer_spending
ORDER BY total_spent DESC
LIMIT 1;
