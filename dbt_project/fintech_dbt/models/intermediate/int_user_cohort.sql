{{
    config(
        materialized='table',
        schema='silver'
    )
}}

SELECT
    customer_id,
    DATE_TRUNC(last_active_date, MONTH) AS cohort_month,
    DATE_DIFF(CURRENT_DATE(), last_active_date, MONTH) AS months_since_last_active, churn_label
FROM {{ ref('stg_customers') }}
WHERE last_active_date IS NOT NULL
