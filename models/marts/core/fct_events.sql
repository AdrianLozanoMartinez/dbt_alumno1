{{
  config(
    materialized='table'
  )
}}

SELECT
    event_id,
    page_url,
    page_url_sin_https,
    event_type,
    user_id,
    product_id,
    created_at,
    created_at_date,
    created_at_time,
    order_id
FROM {{ ref('stg_sql_server_dbo__events') }} 