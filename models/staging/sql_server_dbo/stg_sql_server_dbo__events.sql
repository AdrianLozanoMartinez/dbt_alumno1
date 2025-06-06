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
        event_id
        , page_url
        , REGEXP_REPLACE(page_url, '^https?://', '') AS page_url_sin_https
        , event_type
        , user_id
        , product_id
        , CAST(created_at AS TIMESTAMP_TZ) AS created_at
        , CAST(created_at AS TIMESTAMP)::DATE AS created_at_date
        , CAST(created_at AS TIMESTAMP)::TIME AS created_at_time
        , order_id
    FROM src_events
    )

SELECT * FROM events_casted