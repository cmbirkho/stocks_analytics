{{
    config(
        materialized = "incremental"
    )
}}


SELECT *
FROM {{ source('yfinance', 'daily_prices') }}
{% if is_incremental() %}
WHERE run_date >= (SELECT MAX(run_date) FROM {{ this }})
{% endif %}