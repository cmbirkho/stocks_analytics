{{
    config(
        materialized = "table",
        sort = "ticker"
    )
}}


WITH
cte AS (

    SELECT 
        ticker
    FROM {{ ref('stocks_daily_actions') }}
    UNION DISTINCT
    SELECT 
        ticker 
    FROM {{ ref('stocks_daily_prices') }}

)
SELECT *
FROM cte 
