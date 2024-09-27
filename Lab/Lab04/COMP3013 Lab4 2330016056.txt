-- 1. Find the films (title) played by Zero Cage.
SELECT DISTINCT f.title
FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    JOIN actor a ON fa.actor_id = a.actor_id
WHERE a.first_name = 'Zero'
    AND a.last_name = 'Cage';
-- 2. Find the films (title) rented by George Linton. The join condition is ON.
SELECT DISTINCT f.title
FROM film f
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN customer c ON r.customer_id = c.customer_id
WHERE c.first_name = 'George'
    AND c.last_name = 'Linton';
-- 3. Find the customers (name) who have rented some action (category) films. The join condition is USING.
SELECT DISTINCT CONCAT(c.first_name, ' ', c.last_name) AS customer_name
FROM customer c
    JOIN rental r USING (customer_id)
    JOIN inventory i USING (inventory_id)
    JOIN film f USING (film_id)
    JOIN film_category fc USING (film_id)
    JOIN category cat USING (category_id)
WHERE cat.name = 'Action';
-- 4. Join the tables film, film_category, and category, using both conditions ON and USING.
SELECT f.title,
    cat.name
FROM film f
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category cat USING(category_id);
-- 5. Find all pairs of customers (name) who have rented a same film. Any join condition is fine.
SELECT DISTINCT CONCAT(c1.first_name, ' ', c1.last_name) AS customer_1,
    CONCAT(c2.first_name, ' ', c2.last_name) AS customer_2,
    f.title AS film_title
FROM rental r1
    JOIN inventory i1 ON r1.inventory_id = i1.inventory_id
    JOIN film f ON i1.film_id = f.film_id
    JOIN customer c1 ON r1.customer_id = c1.customer_id
    JOIN rental r2 ON i1.inventory_id = r2.inventory_id
    JOIN customer c2 ON r2.customer_id = c2.customer_id
WHERE c1.customer_id < c2.customer_id;
-- 6. Find the films rented by each customer. If a customer has not rented any film, give it a NULL value.
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
    f.title AS film_title
FROM customer c
    LEFT JOIN rental r ON c.customer_id = r.customer_id
    LEFT JOIN inventory i ON r.inventory_id = i.inventory_id
    LEFT JOIN film f ON i.film_id = f.film_id;