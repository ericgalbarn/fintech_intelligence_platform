{{
    config(
        materialized='table',
        schema='silver'
    )
}}

SELECT
    DATE(transaction_timestamp) AS txn_date,
    COUNT(*) AS transaction_count,
    SUM(amount) AS total_amount,
    AVG(amount) AS avg_amount,
    COUNT(DISTINCT sender_account) AS unique_customers
FROM {{ ref('stg_transactions') }}
WHERE transaction_timestamp IS NOT NULL
GROUP BY 1
ORDER BY 1
