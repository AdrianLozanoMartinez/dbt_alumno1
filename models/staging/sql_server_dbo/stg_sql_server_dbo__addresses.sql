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
          {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS addresses_id
        ,  address_id
        , zipcode
        , country
        , address
        , state
        , _fivetran_deleted
        , _fivetran_synced
    FROM src_addresses
    )

SELECT * FROM address_casted