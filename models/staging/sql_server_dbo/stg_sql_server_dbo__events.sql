{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
),

events_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key(['event_id']) }} AS event_id
        , page_url
        , event_type
        , user_id
        , product_id
        , session_id
        , created_at
        , order_id
        , _fivetran_deleted
        , _fivetran_synced
    FROM src_events
    )

SELECT * FROM events_casted