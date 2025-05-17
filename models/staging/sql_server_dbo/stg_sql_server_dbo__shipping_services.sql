{{
  config(
    materialized='view'
  )
}}

WITH src_shipping_services AS (
    SELECT DISTINCT shipping_service 
    FROM {{ source('sql_server_dbo', 'orders') }}
    WHERE shipping_service IS NOT NULL
      AND TRIM(shipping_service) != ''
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} AS shipping_service_id,
    shipping_service
FROM src_shipping_services
