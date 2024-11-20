USE sakila;

-- Query 1: Customers who have rented some films from all stores
SELECT customer_id,
    first_name,
    last_name
FROM customer c
WHERE NOT EXISTS (
        SELECT store_id
        FROM store s
        WHERE NOT EXISTS (
                SELECT rental_id
                FROM rental r
                WHERE r.customer_id = c.customer_id
                    AND r.inventory_id IN (
                        SELECT i.inventory_id
                        FROM inventory i
                        WHERE i.store_id = s.store_id
                    )
            )
    );

-- Query 2: Customers who have rented at least one film in every category
SELECT customer_id,
    first_name,
    last_name
FROM customer c
WHERE NOT EXISTS (
        SELECT cat.category_id
        FROM category cat
        WHERE NOT EXISTS (
                SELECT r.rental_id
                FROM rental r
                    JOIN inventory USING (inventory_id)
                    JOIN film_category fc USING (film_id)
                WHERE r.customer_id = c.customer_id
                    AND fc.category_id = cat.category_id
            )
    );

-- Query 3: Customers who have rented at least one film in each rating
SELECT c.customer_id,
    c.first_name,
    c.last_name
FROM customer c
WHERE NOT EXISTS (
        SELECT DISTINCT f.rating
        FROM film f
        WHERE NOT EXISTS (
                SELECT r.rental_id
                FROM rental r
                    JOIN inventory i ON r.inventory_id = i.inventory_id
                WHERE r.customer_id = c.customer_id
                    AND i.film_id = f.film_id
            )
    );