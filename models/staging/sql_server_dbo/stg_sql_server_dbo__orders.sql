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
          {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id_hash
        , o.order_id
        , sh.shipping_service_id
        , sh.shipping_service
        , o.shipping_cost
        , o.address_id
        , CAST(o.created_at AS TIMESTAMP)::DATE AS created_at_date
        , CAST(o.created_at AS TIMESTAMP)::TIME AS created_at_time
        , o.promo_id
        , o.estimated_delivery_at
        , CAST(o.estimated_delivery_at AS TIMESTAMP)::DATE AS estimated_delivery_at_date
        , CAST(o.estimated_delivery_at AS TIMESTAMP)::TIME AS estimated_delivery_at_time
        , o.order_cost
        , o.user_id
        , o.order_total
        , o.delivered_at
        , CAST(o.delivered_at AS TIMESTAMP)::DATE AS delivered_at_date
        , CAST(o.delivered_at AS TIMESTAMP)::TIME AS delivered_at_time
        , s.status_order_id      
        , s.status_order        
        , o._fivetran_deleted
        , o._fivetran_synced
    FROM src_orders o
    LEFT JOIN {{ ref('stg_sql_server_dbo__status_orders') }} s
        ON o.status = s.status_order
    LEFT JOIN {{ ref('stg_sql_server_dbo__shipping_services') }} sh
        ON o.shipping_service = sh.shipping_service
)

SELECT * FROM order_casted
