/*
 * This problem is the same as 05.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT
  a.last_name,
  a.first_name
FROM actor AS a
LEFT JOIN customer AS c
  ON a.first_name = c.first_name
 AND a.last_name  = c.last_name
WHERE c.customer_id IS NULL
ORDER BY a.last_name, a.first_name;
