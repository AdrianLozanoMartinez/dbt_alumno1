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
)

SELECT * FROM order_items
