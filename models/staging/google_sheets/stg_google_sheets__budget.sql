{{ config(
    materialized='incremental'
    ) 
    }}

WITH stg_budget_products AS (
    SELECT * 
    FROM {{ ref('base_google_sheets__budget') }}
    ),

renamed_casted AS (
    SELECT
          _row
        , month
        , quantity 
        , _fivetran_synced AS Date_Load
    FROM stg_budget_products
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}