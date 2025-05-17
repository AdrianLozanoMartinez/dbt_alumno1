{{
  config(
    materialized='view'
  )
}}

WITH order_items AS (
    SELECT
        {{ dbt_utils.generate_surrogate_key(['order_id', 'product_id']) }} AS order_item_id,
        order_id,
        product_id,
        quantity,
        _fivetran_deleted,
        _fivetran_synced,
        CAST(_fivetran_synced AS TIMESTAMP)::DATE AS _fivetran_synced_date,
        CAST(_fivetran_synced AS TIMESTAMP)::TIME AS _fivetran_synced_time
    FROM {{ source('sql_server_dbo', 'order_items') }}
),

products AS (
    SELECT
        product_id,
        price
    FROM {{ ref('stg_sql_server_dbo__products') }}
)

SELECT
    oi.order_item_id,
    oi.order_id,
    p.product_id,
    oi.quantity,
    p.price,
    oi._fivetran_deleted,
    oi._fivetran_synced,
    oi._fivetran_synced_date,
    oi._fivetran_synced_time
FROM order_items oi
LEFT JOIN products p
  ON oi.product_id = p.product_id
