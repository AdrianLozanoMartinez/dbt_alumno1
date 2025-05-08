{{
  config(
    materialized='view'
  )
}}

WITH src_budget AS (
    SELECT * 
    FROM {{ source('google_sheets', 'budget') }}
),

renamed_casted AS (
    SELECT
          {{ dbt_utils.generate_surrogate_key(['product_id', 'month']) }} AS budget_id
        ,  product_id
        , quantity
        , month AS last_day_month
        , _fivetran_synced AS data_load
    FROM src_budget
    )

SELECT * FROM renamed_casted