#  1:Get all pairs of actors that worked together.


SELECT
    CONCAT(a1.first_name, ' ', a1.last_name) AS actor1,
    CONCAT(a2.first_name, ' ', a2.last_name) AS actor2
FROM
    film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id AND fa1.actor_id < fa2.actor_id
    JOIN actor a1 ON fa1.actor_id = a1.actor_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id;

#  2:Get all pairs of customers that have rented the same film more than 3 times.


SELECT
    c1.customer_id AS customer1_id,
    c1.first_name AS customer1_first_name,
    c1.last_name AS customer1_last_name,
    c2.customer_id AS customer2_id,
    c2.first_name AS customer2_first_name,
    c2.last_name AS customer2_last_name,
    COUNT(*) AS rental_count
FROM
    rental r1
    JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
    JOIN film f ON i1.film_id = f.film_id
    JOIN rental r2 ON f.film_id = (SELECT film_id FROM inventory WHERE inventory_id = r2.inventory_id) AND r1.customer_id < r2.customer_id
    JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
    JOIN customer c1 ON r1.customer_id = c1.customer_id
    JOIN customer c2 ON r2.customer_id = c2.customer_id
GROUP BY
    c1.customer_id, c2.customer_id
HAVING
    rental_count > 3
LIMIT 0, 1000;

#  3:Get all possible pairs of actors and films.

SELECT 
    actor.actor_id,
    actor.first_name AS actor_first_name,
    actor.last_name AS actor_last_name,
    film.film_id,
    film.title AS film_title
FROM
    actor
join film_actor on actor.actor_id = film_actor.actor_id
join film on film_actor.film_id = film.film_id;
