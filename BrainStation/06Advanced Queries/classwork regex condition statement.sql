select * from contactdata limit 5;
select `data` as phone_number
from contactdata 
where `data` 
regexp '^\\([0-9]{3}\\)?[0-9]{3}?[0-9]{4}$';


-- use sakila data base
use sakila;
select title, length,
if (length>50, 'Long','Short') as moive_length
from film
order by moive_length;

-- calulate sum of long movie and short movie
select if (length>50, 'Long','Short') as moive_length, sum(length) as total_len
from film
group by moive_length
order by moive_length;

-- make three bucket long, short, and medium
select title, length,
case 	when length<50 then 'Short'
		when length>=50 and length<=120 then 'Medium'
        else 'Long'
end as movie_len
from film;

-- fizzbuzz exercise
select category_id, 
CASE
	WHEN (0 = category_id%3 && 0 != category_id%5 ) THEN 'Fizz'
    WHEN (0 != category_id%3 && 0 = category_id%5 ) THEN 'Buzz'
    WHEN (0 = category_id%3 && 0 = category_id%5) THEN 'FizzBuzz'
    else category_id
END as fizzbuzz_c
from category;