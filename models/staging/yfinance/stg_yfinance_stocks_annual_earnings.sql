{{
    config(
        materialized = "view"
    )
}}

WITH annual_earn_cte AS (
    
    SELECT 
        year
        , ticker
        , earnings
        , revenue
        , ROW_NUMBER() OVER(PARTITION BY ticker, year ORDER BY run_date DESC) AS rn 
    FROM {{ source('yfinance', 'annual_earnings') }}

)
SELECT 
    'yfinance' AS source
    , year 
    , ticker
    , earnings
    , revenue
FROM annual_earn_cte
WHERE rn = 1