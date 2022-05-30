{{
    config(
        materialized = "table"
    )
}}

WITH 
earn_cte AS (
    SELECT 
        year 
        , ticker 
        , 'earnings' AS earnings_metric
        , earnings AS value 
    FROM {{ ref('stg_yfinance_stocks_annual_earnings') }}
),
rev_cte AS (
    SELECT 
        year 
        , ticker 
        , 'revenue' AS earnings_metric
        , revenue AS value 
    FROM {{ ref('stg_yfinance_stocks_annual_earnings') }}

)
SELECT *
FROM earn_cte
UNION ALL 
SELECT *
FROM rev_cte 
