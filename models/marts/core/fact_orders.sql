{{
  config(
    materialized='table'
  )
}}

SELECT
    o.order_id,
    oi.order_item_id,
    o.shipping_service_id,
    oi.product_id,
    oi.quantity,
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
    oi._fivetran_deleted AS _fivetran_deleted_order_items,
    oi._fivetran_synced AS _fivetran_synced_order_items,
    oi._fivetran_synced_date AS _fivetran_synced_date_order_items,
    oi._fivetran_synced_time AS _fivetran_synced_time_order_items
FROM {{ ref('stg_sql_server_dbo__orders') }} o
LEFT JOIN {{ ref('stg_sql_server_dbo__order_items') }} oi
    ON o.order_id = oi.order_id
LEFT JOIN {{ ref('dim_shipping') }} sh
    ON o.shipping_service_id = sh.shipping_service_id
LEFT JOIN {{ ref('dim_addressed') }} sh
    ON o.address_id = sh.address_id