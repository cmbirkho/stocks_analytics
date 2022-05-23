{{
    config(
        materialized = "table",
        sort = "date"
    )
}}


SELECT 
    date 
    , open
    , high
    , low
    , close
    , adj_close
    , volume
    , ticker
FROM {{ ref('stg_yfinance_stocks_daily_prices') }}