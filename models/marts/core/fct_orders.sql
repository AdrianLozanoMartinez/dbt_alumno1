{{
  config(
    materialized='table'
  )
}}

SELECT
    oi.order_item_id,
    o.order_id,
    oi.product_id,
    oi.quantity,
    o.shipping_service_id,
    o.address_id,
    o.created_at,
    o.created_at_date,
    o.created_at_time,
    o.promo_id,
    o.order_cost,
    o.user_id,
    o.order_total,
    o.status_order_id
FROM {{ ref('stg_sql_server_dbo__orders') }} o
LEFT JOIN {{ ref('stg_sql_server_dbo__order_items') }} oi
    ON oi.order_id = o.order_id 
