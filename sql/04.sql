/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */

-- returns all film_ids that customer 1 rented
-- select film_id from rental join customer using(customer_id) join inventory using(inventory_id) join film using(film_id) where customer_id=1;

-- returns all titles that customer 1 rented
-- select title from film join (select film_id from rental join customer using(customer_id) join inventory using(inventory_id) join film using(film_id) where customer_id=1) as ids using(film_id); 

select title from film join (select film_id from rental join customer using(customer_id) join inventory using(inventory_id) join film using(film_id) where customer_id=1) as ids using(film_id) group by film_id having count(*) > 1 order by title;

