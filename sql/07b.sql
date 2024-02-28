/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT DISTINCT title from film JOIN inventory USING(film_id) LEFT JOIN (SELECT title, rental_id FROM film JOIN inventory USING(film_id) JOIN rental USING (inventory_id) JOIN customer USING(customer_id) JOIN address USING(address_id) JOIN city USING(city_id) JOIN country USING(country_id) where country.country ILIKE 'United States') as b USING(title) WHERE b.rental_id IS NULL ORDER BY title; 
