{{ config(
    materialized="table",
    schema="mart"
) }}
SELECT
    sum(amount) as total_revenue,
    date_trunc('month', payment_date) as payment_month
FROM {{ ref('fact_payment') }}
GROUP BY payment_month
