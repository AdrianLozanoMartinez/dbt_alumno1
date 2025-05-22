{{
  config(
    materialized='view'
  )
}} 

WITH src_addresses AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'addresses') }}
),

address_casted AS (
    SELECT
        address_id
        , LPAD(zipcode, 5, '0') AS zipcode 
        , country
        , address
        , state
    FROM src_addresses
    )

SELECT * FROM address_casted