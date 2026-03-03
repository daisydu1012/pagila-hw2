/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */


SELECT f.title
FROM rental r
JOIN inventory i
  ON r.inventory_id = i.inventory_id
JOIN film f
  ON i.film_id = f.film_id
WHERE r.customer_id = 1
GROUP BY f.title
HAVING COUNT(*) > 1
ORDER BY f.title;
