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
        product_id
        , price
        , name
        , inventory
    FROM src_products
    )

SELECT * FROM products_casted