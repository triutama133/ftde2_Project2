{{ config(
    materialized='table',
    schema='mart'
) }}

WITH film_rentals AS (
  SELECT
    f.film_id,
    f.title,
    COUNT(*) AS total_rentals
  FROM film f
  JOIN inventory i ON f.film_id = i.film_id
  JOIN rental r ON i.inventory_id = r.inventory_id
  GROUP BY f.film_id, f.title
)
SELECT
  film_id,
  title,
  total_rentals
FROM film_rentals
ORDER BY total_rentals DESC