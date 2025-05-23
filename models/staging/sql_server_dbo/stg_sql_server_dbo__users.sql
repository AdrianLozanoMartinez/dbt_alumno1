{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
),

users_casted AS (
    SELECT
        user_id
        , updated_at
        , CAST(updated_at AS TIMESTAMP)::DATE AS updated_at_date
        , CAST(updated_at AS TIMESTAMP)::TIME AS updated_at_time
        , address_id
        , last_name
        , created_at
        , CAST(created_at AS TIMESTAMP)::DATE AS created_at_date
        , CAST(created_at AS TIMESTAMP)::TIME AS created_at_time
        , phone_number
        , total_orders
        , first_name
        , email
    FROM src_users
    )

SELECT * FROM users_casted