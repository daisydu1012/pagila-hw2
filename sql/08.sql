/*
 * Select the title of all 'G' rated movies that have the 'Trailers' special feature.
 * Order the results alphabetically.
 *
 * HINT:
 * Use `unnest(special_features)` in a subquery.
 */

SELECT DISTINCT f.title
FROM film AS f
WHERE f.rating = 'G'
  AND f.film_id IN (
      SELECT f2.film_id
      FROM film AS f2,
           unnest(f2.special_features) AS feature
      WHERE feature = 'Trailers'
  )
ORDER BY f.title;
