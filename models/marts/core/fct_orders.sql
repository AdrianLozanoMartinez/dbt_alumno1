{{
  config(
    materialized='table'
  )
}}
--1 fila por pedido
SELECT
    o.order_id,
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
FROM {{ ref('stg_sql_server_dbo__orders') }} o
LEFT JOIN {{ ref('dim_shipping') }} s
    ON o.shipping_service_id = s.shipping_service_id
LEFT JOIN {{ ref('dim_addresses') }} a
    ON o.address_id = a.address_id
LEFT JOIN {{ ref('dim_promos') }} p
    ON o.promo_id = p.promo_id
LEFT JOIN {{ ref('dim_users') }} u
    ON o.user_id = u.user_id
