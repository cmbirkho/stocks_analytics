
{{
    config(
        materialized = "table",
        sort = "date"
    )
}}


SELECT 
    date 
    , ticker
    , 'dividends' AS action
    , dividends AS value
FROM {{ ref('stg_yfinance_stocks_daily_actions') }}
UNION ALL 
SELECT 
    date 
    , ticker
    , 'stock_splits' AS action
    , stock_splits AS value
FROM {{ ref('stg_yfinance_stocks_daily_actions') }}

