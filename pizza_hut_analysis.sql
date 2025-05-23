-- 1. Sales Performance Analysis 

--   ----------  a) Find best-selling pizzas based on quantity and revenue  ----------  
-- (helps determine which pizzas are the most popular, finds top 5 pizzas based on selling i.e. total_sold )

use pizzahut;
SELECT 
    pt.name AS pizza_name,  
    SUM(od.quantity) AS total_sold, 
    SUM(od.quantity * p.price) AS total_revenue
FROM orders_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id  
GROUP BY pt.name
ORDER BY total_sold DESC
LIMIT 5;   


-- (helps determine which pizzas are the most profitable, finds top 5 pizzas based on revenue i.e. total_revenue)  

SELECT 
    pt.name AS pizza_name,  
    SUM(od.quantity) AS total_sold, 
    SUM(od.quantity * p.price) AS total_revenue
FROM orders_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id  
GROUP BY pt.name
ORDER BY total_revenue DESC
LIMIT 5; 

--  ----------   B)Peak Sales Hours  ----------  
-- (This helps in staff scheduling and resourses allocation.)


SELECT 
  HOUR(order_time) AS order_hour,
  count(order_id) as total_orders
FROM orders
GROUP BY order_hour
ORDER BY total_orders DESC
LIMIT 5 ; 

--   ----------  c)Sales Trend (Daily Revenue)  ---------- 
 
SELECT 
    order_date, 
    round(SUM(od.quantity * p.price),2) AS daily_revenue
FROM orders o
JOIN orders_details od 
ON o.order_id = od.order_id
JOIN pizzas p 
ON od.pizza_id = p.pizza_id
GROUP BY order_date
ORDER BY order_date;

--   ----------  d)Sales by Pizza Size  ----------  
-- insighgts : Determines customer preferences for different pizza sizes.)

SELECT p.size, SUM(od.quantity) AS total_sold
FROM orders_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY p.size
ORDER BY total_sold DESC; 

-- 2. Revenue & Profit Optimization

 -- ----------a) Monthly Revenue Trends  ----------
 
 -- Insight: Helps predict future revenue and seasonal trends.

SELECT MONTH(o.order_date) AS Ord_month, 
       round(SUM(od.quantity * p.price),2) AS total_revenue
FROM orders o
JOIN orders_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY Ord_month
ORDER BY Ord_month; 

-- ---------- b) Low-Selling Pizzas  ----------

-- Insight: Identifies pizzas that should be discontinued or promoted.

SELECT 
    p.pizza_type_id, pt.name, SUM(od.quantity) AS total_sold
FROM
    orders_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
        JOIN
    pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY p.pizza_type_id , pt.name
ORDER BY total_sold ASC
LIMIT 1;

-- ----------c) Average Order Value (AOV) ----------

-- Helps set pricing strategies .

SELECT 
    ROUND(AVG(order_value), 2) AS avg_order_value
FROM
    (SELECT 
        o.order_id, SUM(od.quantity * p.price) AS order_value
    FROM
        orders o
    JOIN orders_details od ON o.order_id = od.order_id
    JOIN pizzas p ON od.pizza_id = p.pizza_id
    GROUP BY o.order_id) sub;
    
    -- 3) Inventory & Ingredient Optimization

-- ----------  a) Most Used Ingredients ----------

-- Insight: Helps optimize ingredient procurement and reduce waste.

SELECT pt.ingredients, COUNT(od.pizza_id) AS usage_count
FROM orders_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.ingredients
ORDER BY usage_count DESC;


-- ----------  b) Predict Ingredient Shortages  ----------

-- Insight: Helps plan ingredient stock levels based on past demand.

SELECT pt.ingredients, COUNT(od.pizza_id) AS usage_last_30_days
FROM orders_details od
JOIN orders o ON od.order_id = o.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
WHERE o.order_date >= DATE_SUB('2015-12-31', INTERVAL 30 DAY) -- (current date should be used at the place of "2015-12-31")
GROUP BY pt.ingredients
ORDER BY usage_last_30_days DESC;

-- 4)Customer & Marketing Insights

--  ----------  a) Commonly Ordered Pizza Combinations ----------  

-- Insight: Helps create combo offers to boost sales.

SELECT od1.pizza_id AS pizza1, od2.pizza_id AS pizza2, COUNT(*) AS order_count
FROM orders_details od1
JOIN orders_details od2 
ON od1.order_id = od2.order_id AND od1.pizza_id < od2.pizza_id
GROUP BY od1.pizza_id, od2.pizza_id
ORDER BY order_count DESC
LIMIT 5; 

-- ----------  b) Most Popular Pizza Categories  ----------  

--  Insight: Helps decide which pizza categories to promote or expand

SELECT pt.category, SUM(od.quantity) AS total_sold
FROM orders_details od
JOIN pizzas p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON p.pizza_type_id = pt.pizza_type_id
GROUP BY pt.category
ORDER BY total_sold DESC;



