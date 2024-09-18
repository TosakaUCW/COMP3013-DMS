-- 1. Find the films (name) played by Zero Cage.
SELECT film.title
FROM actor,
    film,
    film_actor
WHERE actor.first_name = "Zero"
    AND actor.last_name = "Cage"
    AND film_actor.actor_id = actor.actor_id
    AND film.film_id = film_actor.film_id

-- 2. Find the films (name) rented by George Linton.

SELECT DISTINCT film.title
FROM rental,
    film,
    customer,
    inventory
WHERE customer.first_name = "George"
    AND customer.last_name = "Linton"
    AND rental.customer_id = customer.customer_id
    AND rental.inventory_id = inventory.inventory_id
    AND inventory.film_id = film.film_id

-- 3. Find the customers (name) who have rented some action (category) films.

SELECT customer.first_name,
    customer.last_name
FROM rental,
    film,
    customer,
    inventory,
    category,
    film_category
WHERE category.name = "Action"
    AND category.category_id = film_category.category_id
    AND film_category.film_id = inventory.film_id
    AND rental.inventory_id = inventory.inventory_id
    AND rental.customer_id = customer.customer_id

-- 4. Find the customers who live in China and have rented some Japanese films.

SELECT c.first_name,
    c.last_name
FROM rental,
    film AS f,
    customer AS c,
    inventory AS i,
    language AS lang,
    rental AS r
WHERE lang.name = "Japanese"
    AND lang.language_id = f.language_id
    AND f.film_id = i.film_id
    AND r.inventory_id = i.inventory_id
    AND c.customer_id = r.customer_id

-- 5. Find all pairs of customers (name) who have rented a same film.

SELECT DISTINCT
    CONCAT(c1.first_name, ' ', c1.last_name) AS customer_1,
    CONCAT(c2.first_name, ' ', c2.last_name) AS customer_2,
    f.title AS film_title
FROM rental r1
    JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
    JOIN film f ON i1.film_id = f.film_id
    JOIN customer c1 ON r1.customer_id = c1.customer_id
    JOIN rental r2 ON i1.inventory_id = r2.inventory_id
    JOIN customer c2 ON r2.customer_id = c2.customer_id
WHERE c1.customer_id < c2.customer_id;

-- 6. Find the actors who have played a same film with Bolger (the last name of an actor)

SELECT DISTINCT
    concat(a1.first_name, ' ', a1.last_name) AS actor_name
FROM actor a1
    JOIN film_actor fa1 ON a1.actor_id = fa1.actor_id
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE a2.last_name = 'Bolger' AND a1.actor_id != a2.actor_id