-- Total revenue
SELECT 
    SUM(amount) AS total_revnue
FROM
    orders;

-- Total orders 
SELECT 
    COUNT(order_id) AS total_orders
FROM
    orders;

-- Orders by status 
SELECT 
    status, COUNT(*) AS total_orders
FROM
    orders
GROUP BY status;


-- Category revenue
SELECT 
    category, SUM(amount) AS Total_revenue
FROM
    orders
GROUP BY category
ORDER BY Total_revenue DESC;



-- Monthly Revenue
SELECT 
    order_month, COUNT(*) AS orders, SUM(amount) AS Revenue
FROM
    orders
GROUP BY order_month
ORDER BY order_month;

-- Delivery Sucess rate
SELECT 
    SUM(is_delivered) * 100 / COUNT(*) AS Delivery_rate
FROM
    orders;

 -- Promotion Effect 
SELECT 
    promotion_ids, COUNT(*) AS orders, SUM(amount) AS revenue
FROM
    orders
GROUP BY promotion_ids
ORDER BY revenue DESC;


-- TOP 5 Cities by revenue

SELECT 
    ship_city, SUM(amount) AS revenue
FROM
    orders
GROUP BY ship_city
ORDER BY revenue DESC
LIMIT 5;


-- Orders per city
SELECT 
    ship_city AS city, COUNT(DISTINCT order_id) AS orders
FROM
    orders
GROUP BY city
ORDER BY orders DESC;

-- Category revenue contribution %
WITH Total_Revenue AS (SELECT SUM(amount) as Total_revenue FROM orders)

SELECT category, SUM(amount) * 100 / (SELECT total_revenue from Total_Revenue) AS Revenue_rate
from orders
GROUP BY category
ORDER BY Revenue_rate DESC;


-- Average Amount spent on category
SELECT 
    category, AVG(amount) AS average_spent
FROM
    orders
GROUP BY category;


-- Average spent by city
SELECT 
    ship_city, AVG(amount) AS average_spent
FROM
    orders
GROUP BY ship_city
ORDER BY average_spent DESC;


-- Peak Order month
SELECT 
    order_month, COUNT(*) AS orders
FROM
    orders
GROUP BY order_month
ORDER BY orders DESC
LIMIT 1;

-- Revenue per order by category
SELECT 
    category,
    SUM(amount) / COUNT(DISTINCT order_id) AS revenue_per_order
FROM
    orders
GROUP BY category
ORDER BY revenue_per_order DESC;


-- Monthly Revenue Growth
WITH revenue_by_month AS (SELECT order_month , Round(SUM(amount) ) AS revenue, LAG(ROUND(SUM(amount)), 1, 0) OVER(ORDER BY order_month) AS previous_month FROM orders GROUP BY order_month)
SELECT 
    *, (revenue - pmonth) / pmonth * 100 AS revenue_growth
FROM
    revenue_by_month
ORDER BY order_month;

