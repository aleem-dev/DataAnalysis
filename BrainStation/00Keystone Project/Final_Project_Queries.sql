CREATE schema shopping;
USE shopping;

create table shopping_behavior (
	customer_id int primary key,
    customer_age int,
    customer_gender varchar(10),
    item_purchased varchar(50),
    product_category varchar(30),
    purchase_amount decimal(10,2),
    customer_location varchar(50),
    product_size varchar(5),
    product_color varchar(30),
    product_season varchar(20),
    product_rating decimal(2,1),
    customer_subscription varchar(5),
    purchase_shipping_type varchar(30),
    discount_applied varchar(5),
    promo_code_used varchar(5),
    customer_previous_purchases int,
    purchase_payment_type varchar(30),
    customer_purchase_frequency varchar(20)
);

select * from shopping_behavior limit 10;
-- customer_purchase_count how do we calculate, assuming it is previous_purchase + 1
SELECT customer_subscription,
       AVG(customer_purchase_count) AS avg_purchase_count,
       AVG(purchase_amount) AS avg_spend
FROM shopping_behavior
GROUP BY customer_subscription;

-- We dont have puchase_date in our data set, if you have updated data set can you share same with me so we have same data sets?
SELECT product_season, MONTH(purchase_date) AS month, COUNT(*) AS 
purchases
FROM shopping_behavior
GROUP BY product_season, MONTH(purchase_date)
ORDER BY product_season, month;