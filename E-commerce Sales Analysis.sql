/*
 Dataset: The dataset contains the following tables:
 
 `orders`: Contains information about each order, including order ID, customer ID, order date, and order amount.
 `customers`: Contains customer information, including customer ID, name, email, and location.
 `products`: Contains product information, including product ID, name, category, and price.
 
 */

-- Questions to Answer:
-- 1.What are the total sales and the average order amount?
-- 2.Which products are the top-selling in terms of quantity and revenue?
-- 3.What is the distribution of sales by month and year?
-- 4.Who are the top 5 customers based on total order amount?
-- 5.How many customers are repeat customers (made more than one order)?

-- SQL Queries:

-- Total Sales and Average Order Amount:
SELECT SUM(order_amount) AS total_sales,
    AVG(order_amount) AS average_order_amount
FROM orders;

-- Top-Selling Products:
SELECT p.name AS product_name,
    SUM(o.quantity) AS total_quantity_sold,
    SUM(o.order_amount) AS total_revenue
FROM products p
    JOIN orders o ON p.product_id = o.product_id
GROUP BY p.name
ORDER BY total_quantity_sold DESC;

-- Sales Distribution by Month and Year:
SELECT DATE_FORMAT(order_date, '%Y-%m') AS month_year,
    COUNT(order_id) AS num_orders,
    SUM(order_amount) AS total_revenue
FROM orders
GROUP BY month_year
ORDER BY month_year;

-- Top 5 Customers by Total Order Amount:
SELECT c.name AS customer_name,
    SUM(o.order_amount) AS total_order_amount
FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.name
ORDER BY total_order_amount DESC
LIMIT 5;

-- Count of Repeat Customers:
SELECT COUNT(*) AS num_repeat_customers
FROM (
        SELECT customer_id
        FROM orders
        GROUP BY customer_id
        HAVING COUNT(*) > 1
    ) AS repeat_customers;
