# Create Database Ecommerce project and i have Dataset to import 

CREATE DATABASE ecommerce_project;
USE ecommerce_project;

#Create Table
CREATE TABLE ecommerce (
    order_id INT,
    customer_id INT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    price INT,
    total_amount INT,
    payment_type VARCHAR(50),
    order_date DATE
);

#Check data should visible or not
SELECT * FROM ecommerce LIMIT 10;

#Primary Key is Order_id
ALTER TABLE ecommerce ADD PRIMARY KEY (order_id);


#Total Revenue
SELECT SUM(total_amount) AS total_revenue FROM ecommerce;


#Total Order
SELECT COUNT(order_id) FROM ecommerce;

# Unique Customer 
SELECT COUNT(DISTINCT customer_id) FROM ecommerce;

# Monthly Revenue Trend
SELECT 
    DATE_FORMAT(order_date, '%Y-%m') AS month,
    SUM(total_amount) AS revenue
FROM ecommerce
GROUP BY month
ORDER BY month;

# Top 10 Products
SELECT 
    product_name,
    SUM(quantity) AS total_sold
FROM ecommerce
GROUP BY product_name
ORDER BY total_sold DESC
LIMIT 10;

# Top Customers High Value
SELECT 
    customer_id,
    SUM(total_amount) AS total_spent
FROM ecommerce
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 10;

# Revenue by Category
SELECT 
    category,
    SUM(total_amount) AS revenue
FROM ecommerce
GROUP BY category
ORDER BY revenue DESC;

# Repeat vs New Customers
SELECT 
    CASE 
        WHEN COUNT(order_id) = 1 THEN 'New'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS total_customers
FROM ecommerce
GROUP BY customer_id;

# Payment Method Analysis
SELECT 
    payment_type,
    COUNT(*) AS total_orders,
    SUM(total_amount) AS revenue
FROM ecommerce
GROUP BY payment_type;

# Average Order Value
SELECT 
    AVG(total_amount) AS avg_order_value
FROM ecommerce;

# Customer Lifetime Value
SELECT 
    customer_id,
    SUM(total_amount) AS lifetime_value
FROM ecommerce
GROUP BY customer_id
ORDER BY lifetime_value DESC;

# Ranking Customers
SELECT 
    customer_id,
    total_spent,
    RANK() OVER (ORDER BY total_spent DESC) AS customer_rank
FROM (
    SELECT 
        customer_id,
        SUM(total_amount) AS total_spent
    FROM ecommerce
    GROUP BY customer_id
) t;


# Running Revenue (Cumulative)
SELECT 
    order_date,
    SUM(total_amount) OVER (ORDER BY order_date) AS running_revenue
FROM ecommerce;