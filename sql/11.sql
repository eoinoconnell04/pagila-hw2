/*
 * List the name of all actors who have appeared in a movie that has the 'Behind the Scenes' special_feature
 */

       

select DISTINCT first_name || ' ' || last_name as "Actor Name"
from film
join film_actor using(film_id)
join actor using(actor_id)
where 'Behind the Scenes'=ANY(special_features) 
order by "Actor Name";
