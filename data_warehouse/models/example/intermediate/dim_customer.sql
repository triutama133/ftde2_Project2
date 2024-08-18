{{ config(
    materialized="table",
    schema="intermediate"
) }}
SELECT *
FROM {{ source('public', 'customer') }}
