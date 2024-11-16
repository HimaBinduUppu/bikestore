
CREATE TABLE bike.SalesByStaff_and_stores
SELECT 
    st.store_id, 
    sf.staff_id,staff_name, 
    SUM(oi.quantity * oi.list_price *(1-discount)) AS total_sales
FROM bike.staffs sf
JOIN bike.orders o ON sf.staff_id = o.staff_id
JOIN bike.order_items oi ON o.order_id = oi.order_id
JOIN bike.stores st ON sf.store_id = st.store_id
GROUP BY st.store_id, sf.staff_id,staff_name;
CREATE TABLE bike.AvgOrderValue_ByStore
WITH store_sales AS (
    SELECT 
        o.store_id,
        o.order_id,
        SUM(oi.quantity * oi.list_price) AS order_value
    FROM bike.orders o
    JOIN bike.order_items oi ON o.order_id = oi.order_id
    GROUP BY o.store_id, o.order_id
)
SELECT 
    store_id,
    AVG(order_value) AS avg_order_value
FROM store_sales
GROUP BY store_id;


CREATE TABLE bike.Staff_Ranking_ByStore 
SELECT 
    store_id,
    staff_id,
    total_sales,
    rank_value
FROM (
    SELECT 
        store_id, 
        staff_id, 
        total_sales,
        ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY total_sales DESC) AS rank_value
    FROM (
        SELECT 
            s.store_id,
            sf.staff_id,
            SUM(oi.quantity * oi.list_price * (1 - oi.discount)) AS total_sales
        FROM bike.staffs sf
        JOIN bike.orders o ON sf.staff_id = o.staff_id
        JOIN bike.order_items oi ON o.order_id = oi.order_id
        JOIN bike.stores s ON sf.store_id = s.store_id
        GROUP BY s.store_id, sf.staff_id
    ) staff_sales
) ranked_staff
WHERE rank_value <= 5;
