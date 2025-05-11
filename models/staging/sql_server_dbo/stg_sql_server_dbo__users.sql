{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
),

address_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key(['user_id']) }} AS user_id
        , updated_at
        , address_id
        , last_name
        , created_at
        , phone_number
        , total_orders
        , first_name
        , email
        , _fivetran_deleted
        , _fivetran_synced
    FROM src_users
    )

SELECT * FROM address_casted