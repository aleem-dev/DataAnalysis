use shopping_behavior;
SELECT
    p.product_rating,
    COUNT(*) AS number_of_sales,
    SUM(pr.purchase_amount) AS total_sales,
    AVG(pr.purchase_amount) AS average_sales
FROM
    products p
JOIN
    purchases pr ON p.product_item = pr.product_item
WHERE
    p.product_rating IS NOT NULL
GROUP BY
    p.product_rating
ORDER BY
    p.product_rating DESC;
    
select count(*) from products where product_rating = 4.80;

-- total rows in table 3900
select count(*) as total_rows from products;

-- total distinct product items are 25
select count(distinct product_item) as product_items from products;

-- total distinct product items with respective color and size are 1823
select count(distinct product_colour, product_size, product_item) as distict_products from products;


SELECT product_item, product_colour, product_size, COUNT(*) AS count
FROM products
GROUP BY product_item, product_colour, product_size
-- HAVING COUNT(*) > 1
ORDER BY count DESC;

-- solutions
-- 1. create a clean table with uniqe products
-- 2. drop duplicate from the existing table
-- 3. create view from existing table and use view name instead table name in queries

-- CREATE TABLE products_deduped AS
-- SELECT DISTINCT product_item, product_colour, product_size, other_columns...
-- FROM products;

-- CREATE VIEW clean_products AS
-- SELECT DISTINCT product_item, product_colour, product_size, other_columns...
-- FROM products;

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


-- **************************************** ----
-- hp1
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

-- hp2
SELECT 
    customer_subscription,
    AVG(customer_purchase_count) AS avg_purchase_count
FROM customers
GROUP BY customer_subscription;

-- hp3
select distinct product_category, product_item from shopping_behavior order by product_category, product_item;

SELECT customer_gender, product_category,product_item, COUNT(*) AS purchase_count
FROM shopping_behavior
GROUP BY customer_gender, product_category, product_item
ORDER BY customer_gender, purchase_count;

SELECT *
FROM (
  SELECT
    customer_gender,
    product_category,
    product_item,
    COUNT(*) AS purchase_count,
    ROW_NUMBER() OVER (
      PARTITION BY customer_gender
      ORDER BY COUNT(*) DESC
    ) AS gender_rank
  FROM shopping_behavior
  GROUP BY customer_gender, product_category, product_item
) AS ranked
WHERE gender_rank <= 5
ORDER BY customer_gender, gender_rank;

-- hp 4
SELECT product_season, MONTH(purchase_date) AS month, COUNT(*) AS purchases
FROM shopping_behavior
GROUP BY product_season, MONTH(purchase_date)
ORDER BY product_season, month;

SELECT 
	MONTH(purchase_date) AS purchase_month,
	COUNT(*) AS total_purchases,
	product_season,
  SUM(
    CASE 
      WHEN (product_season = 'Winter' AND MONTH(purchase_date) IN (12, 1, 2)) OR
           (product_season = 'Spring' AND MONTH(purchase_date) IN (3, 4, 5)) OR
           (product_season = 'Summer' AND MONTH(purchase_date) IN (6, 7, 8)) OR
           (product_season = 'Fall'   AND MONTH(purchase_date) IN (9, 10, 11))
      THEN 1 ELSE 0
    END
  ) AS in_season_purchases,
  SUM(
    CASE 
      WHEN (product_season = 'Winter' AND MONTH(purchase_date) NOT IN (12, 1, 2)) OR
           (product_season = 'Spring' AND MONTH(purchase_date) NOT IN (3, 4, 5)) OR
           (product_season = 'Summer' AND MONTH(purchase_date) NOT IN (6, 7, 8)) OR
           (product_season = 'Fall'   AND MONTH(purchase_date) NOT IN (9, 10, 11))
      THEN 1 ELSE 0
    END
  ) AS out_of_season_purchases
FROM shopping_behavior
GROUP BY product_season, MONTH(purchase_date)
ORDER BY product_season, purchase_month;

-- hp5
SELECT product_rating, COUNT(*) AS purchase_count, AVG(purchase_amount) AS avg_spend
FROM shopping_behavior
GROUP BY product_rating
ORDER BY product_rating DESC;

-- personas

SELECT 
    c.customer_id,
    c.customer_age,
    c.customer_gender,
    c.customer_location,
    c.customer_subscription,
    c.customer_purchase_count,
    c.customer_purchase_frequency,
    AVG(p.purchase_amount) AS avg_spend,
    SUM(p.purchase_amount) AS total_spend
FROM 
    customers c
JOIN 
    purchases p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.customer_age, c.customer_gender, c.customer_location, 
    c.customer_subscription, c.customer_purchase_count, c.customer_purchase_frequency;




--
-- total rows in table 3900
select count(*) as total_rows from products;

-- total distinct product items are 25
select count(distinct product_item) as product_items from products;

-- total distinct product items with respective color and size are 1823
select count(distinct product_colour, product_size, product_item) as distict_products from products;

-- hp7
SELECT 
    purchase_shipping_type, 
    COUNT(*) AS purchase_count,
    AVG(purchase_amount) AS avg_spend
FROM 
    purchases
GROUP BY 
    purchase_shipping_type
ORDER BY 
    purchase_count DESC;

-- hp4 (product preference by gender)
SELECT 
    c.customer_gender, 
    p.product_category, 
    COUNT(pu.purchase_id) AS purchase_count
FROM 
    Purchases pu
JOIN 
    Customers c ON pu.customer_id = c.customer_id
JOIN 
    Products p ON pu.product_ID = p.product_ID
GROUP BY 
    c.customer_gender, p.product_category
ORDER BY 
    c.customer_gender, purchase_count DESC;


-- Customer persona
