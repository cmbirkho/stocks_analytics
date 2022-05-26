WITH
prices_cte AS (

    SELECT *
    FROM {{ ref('stg_yfinance_stocks_daily_prices') }}
)
SELECT *
FROM prices_cte
WHERE open < 0 