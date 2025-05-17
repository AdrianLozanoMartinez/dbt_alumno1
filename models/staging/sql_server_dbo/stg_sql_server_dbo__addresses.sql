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
          {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id_hash
        , address_id
        , LPAD(zipcode, 5, '0') AS zipcode 
        , country
        , address
        , state
        , _fivetran_deleted
        , _fivetran_synced
        , CAST(_fivetran_synced AS TIMESTAMP)::DATE AS _fivetran_synced_date
        , CAST(_fivetran_synced AS TIMESTAMP)::TIME AS _fivetran_synced_time
    FROM src_addresses
    )

SELECT * FROM address_casted