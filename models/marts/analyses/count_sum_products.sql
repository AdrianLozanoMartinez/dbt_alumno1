{{
  config(
    materialized = 'table' 
  )
}}
--Conocer cuántos productos diferentes y suma de la cantidad total de productos en el pedido
SELECT
    order_id,
    COUNT(DISTINCT product_id) AS product_count,
    SUM(quantity) AS total_quantity
FROM {{ ref('fct_orders') }}
GROUP BY order_id
