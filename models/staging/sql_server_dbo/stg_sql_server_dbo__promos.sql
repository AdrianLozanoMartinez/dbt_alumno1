{{
  config(
    materialized='view'
  )
}}

WITH src_promos AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'promos') }}
),

promos_casted AS (
    SELECT
        p.promo_id
        , p.discount
        , s.status_promo_id
        , p._fivetran_deleted
        , p._fivetran_synced
        , CAST(p._fivetran_synced AS TIMESTAMP)::DATE AS _fivetran_synced_date
        , CAST(p._fivetran_synced AS TIMESTAMP)::TIME AS _fivetran_synced_time
    FROM src_promos p
    LEFT JOIN {{ ref('stg_sql_server_dbo__status_promos') }} s
        ON p.status = s.status_promo
    )

SELECT * FROM promos_casted