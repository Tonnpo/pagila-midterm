/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch similar movies.
 * You've already watched all other movies with the same actors,
 * so now you need a new strategy for finding similar movies.
 * You decide that two movies X and Y are similar if they have been rented by the same customer,
 * and you further quantify this similarity by defining the "similarity score" to be the number of distinct customers that have rented both X and Y.
 *
 * Write a SQL SELECT query that:
 * computes the "similarity score" for all movies with 'AMERICAN CIRCUS'
 * and orders the results from highest to lowest.
 *
 * NOTE:
 * Your results should not contain any duplicate titles.
 *
 * NOTE:
 * You do not have to include movies with similarity score 0 in your results (but you may if you like).
 */
SELECT
    title,
    COUNT(*) AS similarity
FROM (
    SELECT DISTINCT
        f2.title, c1.customer_id
    FROM film f1
    INNER JOIN
        inventory inv1 ON inv1.film_id = f1.film_id
    INNER JOIN
        rental r1 ON r1.inventory_id = inv1.inventory_id
    INNER JOIN
        customer c1 ON c1.customer_id = r1.customer_id
    INNER JOIN
        rental r2 ON r2.customer_id = c1.customer_id
    INNER JOIN
        inventory inv2 ON inv2.inventory_id = r2.inventory_id
    INNER JOIN
        film f2 ON f2.film_id = inv2.film_id AND f2.film_id != f1.film_id
    WHERE
        f1.title = 'AMERICAN CIRCUS'
) t
GROUP BY title
ORDER BY similarity DESC, title ASC;
