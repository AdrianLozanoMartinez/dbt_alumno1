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
        , CAST(created_at AS TIMESTAMP)::DATE AS created_at_date
        , CAST(created_at AS TIMESTAMP)::TIME AS created_at_time
        , promo_id
        , estimated_delivery_at
        , CAST(estimated_delivery_at AS TIMESTAMP)::DATE AS estimated_delivery_at_date
        , CAST(estimated_delivery_at AS TIMESTAMP)::TIME AS estimated_delivery_at_time
        , order_cost
        , user_id
        , order_total
        , delivered_at
        , CAST(delivered_at AS TIMESTAMP)::DATE AS delivered_at_date
        , CAST(delivered_at AS TIMESTAMP)::TIME AS delivered_at_time
        , status
        , _fivetran_deleted
        , _fivetran_synced
        , CAST(_fivetran_synced AS TIMESTAMP)::DATE AS _fivetran_synced_date
        , CAST(_fivetran_synced AS TIMESTAMP)::TIME AS _fivetran_synced_time
    FROM src_orders
    )

SELECT * FROM order_casted