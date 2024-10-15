-- 1. Calculate the average rental duration among all films.
SELECT AVG(f.rental_duration) AS avg_rental_duration
FROM film f;

-- 2. Calculate the number of films rented by Norman Currier.
SELECT COUNT(DISTINCT film_id) AS num_films_rented
FROM rental r
    JOIN customer USING(customer_id)
    JOIN inventory USING(inventory_id)
    JOIN film USING(film_id)
WHERE first_name = 'Norman'
    AND last_name = 'Currier';

-- 3. Calculate the number of films rented by each customer.
SELECT CONCAT(first_name, ' ', last_name) AS customer_name,
    COUNT(DISTINCT film_id) AS num_films_rented
FROM rental
    JOIN customer USING(customer_id)
    JOIN inventory USING(inventory_id)
GROUP BY customer_id;

-- 4. Calculate the number of films rented by each group of customers from the same country.
SELECT country,
    COUNT(DISTINCT film_id) AS num_films_rented
FROM rental
    JOIN customer USING(customer_id)
    JOIN address USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING(country_id)
    JOIN inventory USING(inventory_id)
GROUP BY country_id;

-- 5. Calculate the number of horror films rented by each group of customers from the same country.
SELECT country,
    COUNT(DISTINCT film_id) AS num_horror_films_rented
FROM rental
    JOIN customer USING(customer_id)
    JOIN address USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING(country_id)
    JOIN inventory USING(inventory_id)
    JOIN film_category USING(film_id)
    JOIN category USING(category_id)
WHERE name = 'Horror'
GROUP BY country_id;

-- 6. Find the countries which have some customers who have rented more than 4 horror films.
SELECT country,
    COUNT(DISTINCT film_id) AS num_horror_films_rented
FROM rental
    JOIN customer USING(customer_id)
    JOIN address USING(address_id)
    JOIN city USING(city_id)
    JOIN country USING(country_id)
    JOIN inventory USING(inventory_id)
    JOIN film_category USING(film_id)
    JOIN category USING(category_id)
WHERE name = 'Horror'
GROUP BY country_id
HAVING COUNT(*) > 4;