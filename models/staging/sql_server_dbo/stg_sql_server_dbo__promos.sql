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
    FROM src_promos p
    LEFT JOIN {{ ref('stg_sql_server_dbo__status_promos') }} s
        ON p.status = s.status_promo
    )

SELECT * FROM promos_casted