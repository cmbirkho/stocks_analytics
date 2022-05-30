{{
    config(
        materialized="ephemeral"
    )
}}


SELECT 
    ticker
    , ROUND(SUM(CASE WHEN earnings_metric = 'earnings' THEN value ELSE 0 END) * 1.0 / COUNT(*), 2) AS avg_earnings 
    , ROUND(SUM(CASE WHEN earnings_metric = 'revenue' THEN value ELSE 0 END) * 1.0 / COUNT(*), 2) AS avg_revenue
FROM {{ ref('stocks_annual_earnings') }}
GROUP BY 
    ticker