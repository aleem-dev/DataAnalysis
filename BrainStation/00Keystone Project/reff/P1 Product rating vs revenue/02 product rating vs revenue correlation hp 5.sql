use shopping_behavior;

-- do higher rated products generate more purchase?

select
	product_rating,
	sum(purchase_amount) as sum_by_rating
from
	shopping_behavior
group by
	product_rating
order by
	product_rating desc;


-- is there are positive correlation between product rating and average purhcase amount?

select
	product_rating,
	avg(purchase_amount)
From
	shopping_behavior
group by
	product_rating
order by
	product_rating desc;
    
-- which product categories or sesons show the strongest rating-revenue relationship?
-- rating, category, season from product table as pr
-- purchase_amount from purchase table as p
select
	pr.product_category,
	pr.product_season,
    pr.product_rating,
    sum(p.purchase_amount) as total_revenue,
    avg(p.purchase_amount) as avg_spend,
    count(p.purchase_id) as purchase_count
from
	products as pr
    join
    purchases as p
    on pr.product_id = p.product_id
Group by
	pr.product_category,
	pr.product_season,
    pr.product_rating
Order by
	total_revenue desc;


-- other references while developing the dataset
select
	product_rating,
    avg(purchase_amount),
    sum(purchase_amount) as total_revenue,
    COUNT(purchase_id) AS purchase_count,
    product_category,
    product_season
from
	shopping_behavior
group by
	product_category,
    product_rating,
    product_season
order by
	total_revenue desc
limit 10;

SELECT 
    pr.product_rating,
    pr.product_category,
    pr.product_season,
    COUNT(p.purchase_id) AS purchase_count,
    AVG(p.purchase_amount) AS avg_purchase_amount,
    SUM(p.purchase_amount) AS total_revenue
FROM 
    purchases p
JOIN 
    products pr ON p.product_id = pr.product_id
GROUP BY 
    pr.product_rating, pr.product_category, pr.product_season
ORDER BY 
    total_revenue DESC
limit 10;



