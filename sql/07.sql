/*
 * A group of social scientists is studying American movie watching habits.
 * To help them, select the titles of all films that have never been rented by someone who lives in the United States.
 *
 * NOTE:
 * Not every film in the film table is available in the store's inventory,
 * and you should only return films in the inventory.
 *
 * NOTE:
 * This can be solved by either using a LEFT JOIN or by using the NOT IN clause and a subquery.
 * For this problem, you should use the NOT IN clause;
 * in problem 07b you will use the LEFT JOIN clause.
 *
 * NOTE:
 * This is the last problem that will require you to use a particular method to solve the query.
 * In future problems, you may choose whether to use the LEFT JOIN or NOT IN clause if they are more applicable.
 */



SELECT DISTINCT f.title
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
WHERE f.film_id NOT IN (
  SELECT f2.film_id
  FROM film AS f2
  JOIN inventory AS i2
    ON f2.film_id = i2.film_id
  JOIN rental AS r
    ON i2.inventory_id = r.inventory_id
  JOIN customer AS c
    ON r.customer_id = c.customer_id
  JOIN address AS a
    ON c.address_id = a.address_id
  JOIN city AS ci
    ON a.city_id = ci.city_id
  JOIN country AS co
    ON ci.country_id = co.country_id
  WHERE co.country = 'United States'
)
ORDER BY f.title;
