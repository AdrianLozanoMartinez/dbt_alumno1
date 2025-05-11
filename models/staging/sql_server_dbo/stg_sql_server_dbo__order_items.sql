{{
  config(
    materialized='view'
  )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'order_items') }}
),

order_items_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
        , product_id
        , quantity
        , _fivetran_deleted
        , _fivetran_synced
    FROM src_order_items
    )

SELECT * FROM order_items_casted