{{
    config(
        materialized='table',
        schema='gold'
    )
}}

SELECT
    customer_id,
    age,
    credit_score,
    balance,
    monthly_income,
    origin_province,
    tenure_years,
    married,
    active_member,
    churn_label,
    customer_segment,
    engagement_score,
    loyalty_level,
    risk_score,
    risk_segment,
    cluster_group,
    -- Simple LTV estimation (monetary value per tenure year)
    SAFE_DIVIDE(balance, NULLIF(tenure_years, 0)) AS estimated_ltv
FROM {{ ref('stg_customers') }}
