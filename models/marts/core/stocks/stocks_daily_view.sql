{{
    config(
        materialized = "table",
        partition_by = {
            "field": "date",
            "data_type": "timestamp",
            "granularity": "day"
        }

    )
}}


SELECT  
    A.date
    , A.ticker
    , A.open
    , A.close
    , CASE WHEN B.action = 'dividends' THEN B.value END AS dividends
    , CASE WHEN B.action = 'stock_splits' THEN B.value END AS stock_splits
FROM {{ ref('stocks_daily_prices') }} A 
LEFT JOIN {{ ref('stocks_daily_actions') }} B 
ON A.date = B.date
AND A.ticker = B.ticker