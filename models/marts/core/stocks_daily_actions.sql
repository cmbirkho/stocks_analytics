
{{
    config(
        materialized = "table",
        unique_key = "id"
    )
}}

WITH 
cte AS (

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

)
SELECT 
    date || '-' || ticker || '-' || action AS id
    , *
FROM cte 
{% if is_incremental() %}

    WHERE date > (SELECT MAX(date) FROM {{ this }})

{% endif %}

