/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */
SELECT DISTINCT c.customer_id
FROM customer c
JOIN rental r    ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.film_id IN (
    SELECT f.film_id
    FROM film f
    JOIN inventory i2 ON f.film_id = i2.film_id
    JOIN rental r2    ON i2.inventory_id = r2.inventory_id
    JOIN payment p    ON r2.rental_id = p.rental_id
    GROUP BY f.film_id
    ORDER BY SUM(p.amount) DESC, f.film_id ASC
    LIMIT 5
)
ORDER BY c.customer_id;
