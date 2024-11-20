USE sakila;

-- Find the films (title) played by Zero Cage.
SELECT title
FROM film
WHERE film_id IN (
                SELECT film_id
                FROM film_actor
                WHERE actor_id = (
                                SELECT actor_id
                                FROM actor
                                WHERE first_name = 'Zero'
                                        AND last_name = 'Cage'
                        )
        );

-- Find the films (title) rented by George Linton.
SELECT title
FROM film
WHERE film_id IN (
                SELECT inventory.film_id
                FROM inventory
                WHERE inventory_id IN (
                                SELECT inventory_id
                                FROM rental
                                WHERE customer_id = (
                                                SELECT customer_id
                                                FROM customer
                                                WHERE first_name = 'George'
                                                        AND last_name = 'Linton'
                                        )
                        )
        );

-- Find the customers (name) who have rented some action (category) films.
SELECT first_name,
        last_name
FROM customer
WHERE customer_id IN (
                SELECT customer_id
                FROM rental
                WHERE inventory_id IN (
                                SELECT inventory_id
                                FROM inventory
                                WHERE film_id IN (
                                                SELECT film_id
                                                FROM film
                                                WHERE film_id IN (
                                                                SELECT film_id
                                                                FROM film_category
                                                                WHERE category_id = (
                                                                                SELECT category_id
                                                                                FROM category
                                                                                WHERE name = 'Action'
                                                                        )
                                                        )
                                        )
                        )
        );

-- Find the id of the films which have the lowest rental rate.
SELECT film_id
FROM film
WHERE rental_rate = (
                SELECT MIN(rental_rate)
                FROM film
        );

-- Find the actors who have played a same film with Bolger (the last name of an actor).
SELECT DISTINCT a.first_name,
        a.last_name
FROM actor a
WHERE a.actor_id IN (
                SELECT fa.actor_id
                FROM film_actor fa
                WHERE fa.film_id IN (
                                SELECT film_id
                                FROM film_actor
                                WHERE actor_id IN (
                                                SELECT actor_id
                                                FROM actor
                                                WHERE last_name = 'Bolger'
                                        )
                        )
                        AND fa.actor_id NOT IN (
                                SELECT actor_id
                                FROM actor
                                WHERE last_name = 'Bolger'
                        )
        );

-- Count the number of customers who have not rented any film. You have to use OUTER JOIN, aggregation, and subqueries.
SELECT COUNT(*)
FROM customer c
        LEFT OUTER JOIN rental r ON c.customer_id = r.customer_id
WHERE r.rental_id IS NULL;