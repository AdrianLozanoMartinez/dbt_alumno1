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
    o.status_order_id,     
    o._fivetran_deleted AS _fivetran_deleted_order,
    o._fivetran_synced AS _fivetran_synced_order,
    o._fivetran_synced_date AS _fivetran_synced_date_order,
    o._fivetran_synced_time AS _fivetran_synced_time_order,    
    oi._fivetran_deleted AS _fivetran_deleted_order_item,
    oi._fivetran_synced AS _fivetran_synced_order_item,
    oi._fivetran_synced_date AS _fivetran_synced_date_order_item,
    oi._fivetran_synced_time AS _fivetran_synced_time_order_item
FROM {{ ref('stg_sql_server_dbo__orders') }} o
LEFT JOIN {{ ref('stg_sql_server_dbo__order_items') }} oi
    ON oi.order_id = o.order_id 
