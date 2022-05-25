
{{
    config(
        materialized = "view",
        sort = "date"
    )
}}



WITH daily_actions_cte AS (
    
    SELECT 
        date 
        , dividends
        , stock_splits
        , ticker
        , ROW_NUMBER() OVER(PARTITION BY ticker, date ORDER BY run_date DESC) AS rn 
    FROM {{ source('yfinance', 'daily_actions') }}

)
SELECT 
    'yfinance' AS source
    , date 
    , ticker
    , dividends
    , stock_splits
FROM daily_actions_cte
WHERE rn = 1
