{{
  config(
    materialized='table'
  )
}}

SELECT
    e.event_id,
    e.page_url,
    e.page_url_sin_https,
    e.event_type,
    e.user_id,
    e.product_id,
    e.created_at,
    e.created_at_date,
    e.created_at_time,
    e.order_id,
    e._fivetran_deleted,
    e._fivetran_synced,
    e._fivetran_synced_date,
    e._fivetran_synced_time
FROM {{ ref('stg_sql_server_dbo__events') }} e
LEFT JOIN {{ ref('dim_users') }} u ON e.user_id = u.user_id
LEFT JOIN {{ ref('dim_products') }} p ON e.product_id = p.product_id