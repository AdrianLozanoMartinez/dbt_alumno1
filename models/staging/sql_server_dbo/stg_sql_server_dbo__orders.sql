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
        o.order_id
        , sh.shipping_service_id
        , o.address_id
        , o.created_at
        , CAST(o.created_at AS TIMESTAMP)::DATE AS created_at_date
        , CAST(o.created_at AS TIMESTAMP)::TIME AS created_at_time
        , o.promo_id
        , o.order_cost
        , o.user_id
        , o.order_total
        , s.status_order_id        
        , o._fivetran_deleted
        , o._fivetran_synced
        , CAST(o._fivetran_synced AS TIMESTAMP)::DATE AS _fivetran_synced_date
        , CAST(o._fivetran_synced AS TIMESTAMP)::TIME AS _fivetran_synced_time
    FROM src_orders o
    LEFT JOIN {{ ref('stg_sql_server_dbo__status_orders') }} s
        ON o.status = s.status_order
    LEFT JOIN {{ ref('stg_sql_server_dbo__shipping_services') }} sh
        ON o.shipping_service = sh.shipping_service
)

SELECT * FROM order_casted