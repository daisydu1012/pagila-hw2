/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */




















SELECT
    rank,
    title,
    revenue,
    total_revenue AS "total revenue",
CASE 
    WHEN 100.0 * total_revenue / SUM(revenue) OVER () >= 100 
    THEN '100.00'
    ELSE to_char(100.0 * total_revenue / SUM(revenue) OVER (), 'FM00.00')
END AS "percent revenue"
FROM (
    SELECT
        rank() OVER (ORDER BY revenue DESC) AS rank,
        title,
        revenue,
        SUM(revenue) OVER (
            ORDER BY revenue DESC
            RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ) AS total_revenue
    FROM (
        SELECT
            f.title,
            COALESCE(ROUND(SUM(p.amount), 2), 0.00) AS revenue
        FROM film f
        LEFT JOIN inventory i ON i.film_id = f.film_id
        LEFT JOIN rental r ON r.inventory_id = i.inventory_id
        LEFT JOIN payment p ON p.rental_id = r.rental_id
        GROUP BY f.title
    ) t
) q
ORDER BY revenue DESC, title ASC;
