
{{
    config(
        materialized = "table",
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
    FROM stocks.daily_actions

)
SELECT 
    date 
    , ticker
    , 'dividends' AS action
    , dividends AS value
FROM daily_actions_cte
WHERE rn = 1
UNION ALL 
SELECT 
    date 
    , ticker
    , 'stock_splits' AS action
    , stock_splits AS value
FROM daily_actions_cte
WHERE rn = 1
