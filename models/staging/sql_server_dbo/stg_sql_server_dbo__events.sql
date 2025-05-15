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
        , created_at
        , CAST(created_at AS TIMESTAMP)::DATE AS created_at_date
        , CAST(created_at AS TIMESTAMP)::TIME AS created_at_time
        , order_id
        , _fivetran_deleted
        , _fivetran_synced
        , CAST(_fivetran_synced AS TIMESTAMP)::DATE AS _fivetran_synced_date
        , CAST(_fivetran_synced AS TIMESTAMP)::TIME AS _fivetran_synced_time
    FROM src_events
    )

SELECT * FROM events_casted