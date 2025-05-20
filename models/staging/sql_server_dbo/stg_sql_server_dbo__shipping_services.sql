{{
  config(
    materialized='view'
  )
}}

WITH src_shipping_services AS (
    SELECT shipping_service,
    shipping_cost,
    estimated_delivery_at,
    delivered_at
    FROM {{ source('sql_server_dbo', 'orders') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} AS shipping_service_id,
    shipping_service,
    shipping_cost,
    estimated_delivery_at,
    CAST(estimated_delivery_at AS TIMESTAMP)::DATE AS estimated_delivery_at_date,
    CAST(estimated_delivery_at AS TIMESTAMP)::TIME AS estimated_delivery_at_time,
    delivered_at,
    CAST(delivered_at AS TIMESTAMP)::DATE AS delivered_at_date,
    CAST(delivered_at AS TIMESTAMP)::TIME AS delivered_at_time
FROM src_shipping_services
