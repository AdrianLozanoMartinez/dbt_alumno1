{{
  config(
    materialized='view'
  )
}}

WITH src_status AS (
    SELECT DISTINCT status 
    FROM {{ source('sql_server_dbo', 'promos') }}
)

SELECT
    {{ dbt_utils.generate_surrogate_key(['status']) }} AS status_promo_id,
    status AS status_promo
FROM src_status
