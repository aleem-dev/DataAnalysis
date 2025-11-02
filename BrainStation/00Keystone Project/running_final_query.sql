CREATE DATABASE IF NOT EXISTS shopping_behavior;
USE shopping_behavior;
drop table customers;
drop database shopping_behavior;
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    customer_age INT,
    customer_gender VARCHAR(10),
    customer_location VARCHAR(100),
    customer_subscription BOOLEAN,
    customer_purchase_count INT,
    customer_purchase_frequency VARCHAR(50)
);

select * from customers limit 5;

Drop table products;
CREATE TABLE Products (
	product_id INT PRIMARY KEY,
    product_item VARCHAR(100),
    product_category VARCHAR(50),
    product_size VARCHAR(20),
    product_colour VARCHAR(30),
    product_season VARCHAR(20),
    product_rating DECIMAL(3,2)
);
select * from products limit 5;
select count(*) from products;

CREATE TABLE Purchases (
    purchase_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    product_item VARCHAR(100),
    purchase_amount DECIMAL(10,2),
    purchase_shipping_type VARCHAR(50),
    purchase_discount VARCHAR(50),
    purchase_promocode VARCHAR(50),
    purchase_payment_type VARCHAR(50),
    purchase_date date,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

select * from purchases limit 5;
select count(*) from purchases;

-- 1.	Do older customers spend more per purchase?
--
SELECT
  CASE
    WHEN c.customer_age BETWEEN 18 AND 25 THEN '18-25'
    WHEN c.customer_age BETWEEN 26 AND 35 THEN '26-35'
    WHEN c.customer_age BETWEEN 36 AND 45 THEN '36-45'
    WHEN c.customer_age BETWEEN 46 AND 55 THEN '46-55'
    WHEN c.customer_age BETWEEN 56 AND 65 THEN '56-65'
    ELSE '66+'
  END AS age_group,
  SUM(p.purchase_amount) AS total_purchase_amount
FROM customers c
JOIN purchases p ON c.customer_id = p.customer_id
GROUP BY age_group
ORDER BY total_purchase_amount DESC;

-- 2.	Do subscribed customers purchase more frequently?
SELECT 
    customer_subscription,
    AVG(customer_purchase_count) AS avg_purchase_count
FROM customers
GROUP BY customer_subscription;

-- 3.	Do product preferences vary by gender?
SELECT customer_gender, product_category, COUNT(*) AS purchase_count
FROM shopping_behavior
GROUP BY customer_gender, product_category
ORDER BY customer_gender, purchase_count DESC;

-- 4.	Are seasonal products purchased more during their season?
SELECT product_season, MONTH(purchase_date) AS month, COUNT(*) AS purchases
FROM shopping_behavior
GROUP BY product_season, MONTH(purchase_date)
ORDER BY product_season, month;

-- 5.	Do higher-rated products sell more?
SELECT product_rating, COUNT(*) AS purchase_count, AVG(purchase_amount) AS avg_spend
FROM shopping_behavior
GROUP BY product_rating
ORDER BY product_rating DESC;

-- 6.	Does shipping type affect spending?
SELECT purchase_shipping_type, AVG(purchase_amount) AS avg_spend
FROM shopping_behavior
GROUP BY purchase_shipping_type;

-- 7. Do payment methods vary by age group?
SELECT customer_age, purchase_payment_type, COUNT(*) AS usage_count
FROM shopping_behavior
GROUP BY customer_age, purchase_payment_type
ORDER BY customer_age;

-- Queries average purchase count per category grouped by season compared to average purchase count per item grouped by season to establish a stocking pattern per category and item based on seasonality. * we can then take it one step further if you like and drill into this by location to know how much to stock by location as well. 

SELECT
    pr.product_category,
    pr.product_season,
    AVG(c.customer_purchase_count) AS avg_purchase_count
FROM
    customers c
JOIN
    purchases p ON c.customer_id = p.customer_id
JOIN
    products pr ON p.product_item = pr.product_item
GROUP BY
    pr.product_category, pr.product_season
ORDER BY
    avg_purchase_count DESC;



--  COMPARE TO 
-- note pr.season coulumn is named as pr.product_season and c.purchase_count is named as c.customer_purchase_count

SELECT 
    pr.product_item,
    pr.product_season,
    AVG(c.customer_purchase_count) AS avg_purchase_count
FROM 
    customers c
JOIN 
    purchases p ON c.customer_id = p.customer_id
JOIN 
    products pr ON p.product_item = pr.product_item
GROUP BY 
    pr.product_item, pr.product_season
ORDER BY 
Pr.product_season;




