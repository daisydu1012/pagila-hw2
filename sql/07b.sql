/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */
SELECT DISTINCT f.title
FROM film AS f
JOIN inventory AS i
  ON f.film_id = i.film_id
LEFT JOIN (
    SELECT DISTINCT f2.film_id
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
) AS us_films
  ON f.film_id = us_films.film_id
WHERE us_films.film_id IS NULL
ORDER BY f.title;
