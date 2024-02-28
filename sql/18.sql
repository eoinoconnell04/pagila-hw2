/*
 * Compute the total revenue for each film.
 * The output should include another new column "revenue percent" that shows the percent of total revenue that comes from the current film and all previous films.
 * That is, the "revenue percent" column is 100*"total revenue"/sum(revenue)
 *
 * HINT:
 * The `to_char` function can be used to achieve the correct formatting of your percentage.
 * See: <https://www.postgresql.org/docs/current/functions-formatting.html#FUNCTIONS-FORMATTING-EXAMPLES-TABLE>
 */
WITH ranked_films AS (
    SELECT
        RANK () OVER (ORDER BY sum(case when amount is null then 0.00 else amount end) DESC) as rank,
        title,
        sum(case when amount is null then 0.00 else amount end) as revenue
    FROM
        film
    LEFT JOIN
        inventory USING (film_id)
    LEFT JOIN
        rental USING (inventory_id)
    LEFT JOIN
        payment USING (rental_id)
    GROUP BY
        title
    ORDER BY
        revenue DESC, title
)
SELECT
    rank,
    title,
    revenue,
    sum(revenue) OVER (ORDER BY rank) as "total revenue",
    to_char(
        CASE WHEN (SUM(revenue) over ()) <> 0 
             THEN 100 * (SUM(revenue) OVER (ORDER BY rank)) / (SUM(revenue) over ()) 
             ELSE 0 
        END, 'FM900.00') as "percent revenue"
FROM
    ranked_films
GROUP BY
    rank, title, revenue
order by rank, title;

