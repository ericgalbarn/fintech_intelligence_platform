{{
    config(
        materialized='table',
        schema='silver'
    )
}}

SELECT
    id AS customer_id,
    age,
    credit_sco AS credit_score,
    balance,
    monthly_ir AS monthly_income,
    origin_province,
    tenure_ye AS tenure_years,
    married,
    nums_card AS num_cards,
    nums_service AS num_services,
    active_member,
    last_active_date,
    exit AS churn_label,
    customer_segment,
    engagement_score,
    loyalty_level,
    digital_behavior,
    risk_score,
    risk_segment,
    cluster_group
FROM {{ source('fip_dwh', 'bronze_customers') }}
WHERE age BETWEEN 18 AND 100
  AND credit_sco IS NOT NULL
