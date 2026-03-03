/*
 * Create a report that shows the total revenue per month and year.
 *
 * HINT:
 * This query is very similar to the previous problem,
 * but requires an additional JOIN.
 */


SELECT
  EXTRACT(YEAR  FROM r.rental_date)  AS "Year",
  EXTRACT(MONTH FROM r.rental_date)  AS "Month",
  ROUND(SUM(p.amount), 2)            AS "Total Revenue"
FROM rental r
JOIN payment p ON p.rental_id = r.rental_id
GROUP BY ROLLUP (
  EXTRACT(YEAR  FROM r.rental_date),
  EXTRACT(MONTH FROM r.rental_date)
)
ORDER BY
  EXTRACT(YEAR  FROM r.rental_date) NULLS LAST,
  EXTRACT(MONTH FROM r.rental_date) NULLS LAST;
