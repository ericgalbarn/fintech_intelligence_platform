{{
    config(
        materialized='table',
        schema='silver'
    )
}}

SELECT
    transaction_id,
    SAFE_CAST(timestamp AS TIMESTAMP) AS transaction_timestamp,
    sender_account,
    receiver_account,
    amount,
    transaction_type,
    merchant_category,
    location,
    device_used,
    CASE WHEN is_fraud = TRUE THEN 1 ELSE 0 END AS is_fraud_flag,
    payment_channel
FROM {{ source('fip_dwh', 'bronze_transactions') }}
WHERE amount > 0
  AND timestamp IS NOT NULL
  AND transaction_id IS NOT NULL
