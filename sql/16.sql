/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */


WITH revenue_per_film AS (
  SELECT
    f.film_id,
    f.title,
    ROUND(COALESCE(SUM(p.amount), 0), 2) AS revenue
  FROM film f
  LEFT JOIN inventory i ON i.film_id = f.film_id
  LEFT JOIN rental r ON r.inventory_id = i.inventory_id
  LEFT JOIN payment p ON p.rental_id = r.rental_id
  GROUP BY f.film_id, f.title
)
SELECT
  RANK() OVER (ORDER BY revenue DESC) AS rank,
  title,
  revenue
FROM revenue_per_film
ORDER BY revenue DESC, title ASC;
