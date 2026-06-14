{{
    config(
        materialized='table',
        schema='gold'
    )
}}

SELECT
    a.txn_date,
    a.transaction_count,
    a.total_amount AS daily_revenue,
    a.avg_amount,
    a.unique_customers,
    b.customer_segment,
    b.loyalty_level,
    b.risk_segment,
    b.churn_label
FROM {{ ref('int_txn_daily_agg') }} a
CROSS JOIN {{ ref('stg_customers') }} b
