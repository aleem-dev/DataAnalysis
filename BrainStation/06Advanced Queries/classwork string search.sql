select *
from film
where description not like '%epic%';

select *
from city
where city like 'ad___';

select * from film_text where description like '%boring%dentist%';
select * from film_text where description like '%boring_dentist%';

select *
from city
where binary city like 'ad___';

select *
from city
where binary city like 'Ad___';

-- how may films are there about dentist in out data base?