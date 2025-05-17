{{
  config(
    materialized='view'
  )
}}

WITH src_status AS (
    SELECT DISTINCT status 
    FROM {{ source('sql_server_dbo', 'orders') }}
    WHERE status IS NOT NULL
    AND TRIM(status) != ''
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['status']) }} AS status_order_id,
    status AS status_order
FROM src_status
