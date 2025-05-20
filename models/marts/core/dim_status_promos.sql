{{
  config(
    materialized='table'
  )
}}

SELECT * 
FROM {{ ref('stg_sql_server_dbo__promos') }}