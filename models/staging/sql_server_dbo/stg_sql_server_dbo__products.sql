{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
),

products_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id_hash
        , product_id
        , price
        , name
        , inventory
        , _fivetran_deleted
        , CAST(_fivetran_synced AS TIMESTAMP)::DATE AS _fivetran_synced_date
        , CAST(_fivetran_synced AS TIMESTAMP)::TIME AS _fivetran_synced_time
    FROM src_products
    )

SELECT * FROM products_casted