USE sakila;

-- 1) In the Example (pg. 5) of Set Operation for UNION, 
--    rewrite the query with set operation without the keyword UNION.
SELECT title,
        first_name
FROM actor
        JOIN film_actor USING (actor_id)
        JOIN film USING (film_id)
WHERE first_name = 'Bob'
        OR first_name = 'Zero';

-- 2) In the Example for Intersect, “Find the id of the English films which are played by Tim Hackman”, 
--    the query result only show the film_id.  
--    Rewrite the query to display the language as well in the result.
(
        SELECT film_id,
                language.name AS language
        FROM film
                JOIN language USING(language_id)
        WHERE language.name = 'English'
)
INTERSECT
(
        SELECT film_id,
                'English' AS language
        FROM film_actor
                JOIN actor USING(actor_id)
                JOIN film USING(film_id)
                JOIN language ON film.language_id = language.language_id
        WHERE first_name = 'Tim'
                AND last_name = 'Hackman'
                AND language.name = 'English'
);

-- 3) In the Example for Set Difference, 
--    “Find the id of the films which are played by Tim Hackman that are not in English”, 
--    the result seems to be empty.  
--    Verify this by writing a query to display the film_id and language of all films played by Tim Hackman.
SELECT film_id,
        language.name AS language
FROM film_actor
        JOIN actor USING (actor_id)
        JOIN film USING (film_id)
        JOIN language ON film.language_id = language.language_id
WHERE first_name = 'Tim'
        AND last_name = 'Hackman';

-- 4) Find the id of the customers who live in Australia that have not rented any film. 
SELECT customer_id,
        country
FROM customer
        JOIN address USING (address_id)
        JOIN city USING (city_id)
        JOIN country USING (country_id)
WHERE country.country = 'Australia'
        AND customer_id NOT IN (
                SELECT customer_id
                FROM rental
        );