{{ config(
    materialized='table',
    schema='mart'
) }}

WITH actor_film_counts AS (
  SELECT
    a.actor_id,
    CONCAT(a.first_name, ' ', a.last_name) AS full_name,
    COUNT(*) AS total_films
  FROM actor a
  JOIN film_actor fa ON a.actor_id = fa.actor_id
  GROUP BY a.actor_id, a.first_name, a.last_name
)
SELECT
  actor_id,
  full_name,
  total_films
FROM actor_film_counts
ORDER BY total_films DESC