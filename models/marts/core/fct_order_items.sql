{{
  config(
    materialized='table'
  )
}}
--1 fila por producto en pedido
SELECT
    oi.order_id,
    oi.order_item_id,
    oi.product_id,
    oi.quantity,    
    oi._fivetran_deleted,
    oi._fivetran_synced,
    oi._fivetran_synced_date,
    oi._fivetran_synced_time 
FROM {{ ref('stg_sql_server_dbo__order_items') }} oi
LEFT JOIN {{ ref('fct_orders') }} o
    ON oi.order_id = o.order_id
LEFT JOIN {{ ref('dim_products') }} p
    ON oi.product_id = p.product_id