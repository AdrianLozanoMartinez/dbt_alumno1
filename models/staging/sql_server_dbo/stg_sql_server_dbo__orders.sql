{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
),

order_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
        , shipping_service
        , shipping_cost
        , address_id
        , created_at
        , promo_id
        , estimated_delivery_at
        , order_cost
        , user_id
        , order_total
        , delivered_at
        , tracking_id
        , status
        , _fivetran_deleted
        , _fivetran_synced
    FROM src_orders
    )

SELECT * FROM order_casted