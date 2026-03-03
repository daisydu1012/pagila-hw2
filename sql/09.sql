/*
 * Count the number of movies that contain each type of special feature.
 * Order the results alphabetically be the special_feature.
 */
SELECT
  sf AS special_features,
  COUNT(*) AS count
FROM (
  SELECT unnest(special_features) AS sf
  FROM film
) t
GROUP BY sf
ORDER BY sf;
