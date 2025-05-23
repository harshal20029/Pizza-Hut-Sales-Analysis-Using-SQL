# Pizza Hut Sales Analysis – Project Summary  

## 🔹 Situation (S)  
Pizza Hut’s vast sales data holds valuable insights regarding customer behavior, sales patterns, and profitability. By analyzing this data using SQL, we can optimize business strategies, improve inventory management, and enhance marketing efforts.  

## 🔹 Task (T)  
This project focuses on leveraging SQL to extract key insights, addressing business questions like:  
- Which pizzas generate the highest sales and revenue?  
- What are the peak hours for orders to optimize staff scheduling?  
- How do revenue trends fluctuate over time?  
- Which ingredients are most frequently used, helping with procurement?  
- What are the best marketing strategies based on customer ordering habits?  

## 🔹 Action (A) – SQL Logic Overview  
SQL queries were designed to systematically extract insights from Pizza Hut’s sales database.  

### 1️⃣ Sales Performance Analysis  
- **Best-selling pizzas:** Aggregated sales (`SUM(quantity)`) and revenue (`SUM(quantity * price)`) to find top performers.  
- **Peak Sales Hours:** Extracted `HOUR(order_time)` and grouped by frequency to optimize staffing.  
- **Daily Sales Trend:** Used `DATE(order_date)` and grouped by revenue per day.  
- **Pizza Size Preference:** Analyzed `GROUP BY size` to understand customer preferences.  

### 2️⃣ Revenue & Profit Optimization  
- **Monthly revenue trends:** Used `MONTH(order_date)` to track seasonal fluctuations.  
- **Low-selling pizzas:** Identified underperforming items (`ORDER BY total_sold ASC`) for potential discontinuation or promotions.  
- **Average Order Value (AOV):** Calculated the average transaction value using nested queries.  

### 3️⃣ Inventory Optimization  
- **Most used ingredients:** Queried ingredient occurrences across all orders (`COUNT(pizza_id)`) to optimize procurement.  
- **Ingredient shortage predictions:** Analyzed past 30-day consumption to forecast future demand (`DATE_SUB(current_date, INTERVAL 30 DAY)`).  

### 4️⃣ Customer & Marketing Insights  
- **Commonly ordered pizza combinations:** Identified frequently paired items using self-joins (`JOIN orders_details ON order_id`).  
- **Most popular pizza categories:** Ranked total sales per category (`GROUP BY category ORDER BY total_sold DESC`).  

## 🔹 Result (R) – Key Insights & Business Impact  
- 🍕 **Top-selling pizzas dominate revenue**, revealing customer favorites.  
- 🕑 **Peak sales hours** occur between 6-9 PM, helping optimize staff allocation.  
- 📊 **Daily and monthly revenue trends** provide seasonal insights for forecasting.  
- 📦 **Ingredient consumption tracking** aids in efficient inventory management.  
- 🎯 **Marketing insights** suggest combo offers and targeted promotions.  

## 🔹 Limitations & Future Work  
- The analysis is based on historical sales only; external factors like promotions and competitor actions weren’t included.  
- Ingredient prediction could be enhanced with machine learning for better forecasting.  
