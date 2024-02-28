/*
 * Compute the total revenue for each film.
 */

-- Need to use left join and sum case to capture the films that were never rented, and thus have no revenue

SELECT title, sum(case when amount is null then 0.00 else amount end) as revenue from film
left join inventory using(film_id)
left join rental using(inventory_id)
left join payment using(rental_id)
group by title
order by revenue desc;
