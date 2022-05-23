
{{
    config(
        materialized = "view",
        sort = "date"
    )
}}



WITH daily_prices_cte AS (
    
    SELECT 
        date 
        , open
        , high
        , low
        , close
        , adj_close
        , volume
        , ticker
        , ROW_NUMBER() OVER(PARTITION BY ticker, date ORDER BY run_date DESC) AS rn 
    FROM stocks.daily_prices

)
SELECT 
    'yfinance' AS source
    , date 
    , open
    , high
    , low
    , close
    , adj_close
    , volume
    , ticker
FROM daily_prices_cte
WHERE rn = 1
