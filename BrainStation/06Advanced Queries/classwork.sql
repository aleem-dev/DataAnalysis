select count(*) from category;
select count(*) from `channel`;
select count(*) from product;
select count(*) from purchase;
select count(*) from `user`;

-- People - 9185 users
select * from `user` limit 5;
select channel_id, count(distinct id) as count_per_channel from `user` group by channel_id order by count_per_channel desc;

-- Products - 752 products
select count(*) from product ;
select * from product;

-- CTE is explaind by SAM