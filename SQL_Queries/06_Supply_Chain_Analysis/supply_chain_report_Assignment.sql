#Write a query for the below scenario.

-- The supply chain business manager wants to see which customers’ forecast accuracy has dropped from 2020 to 2021. 
-- Provide a complete report with these columns: customer_code, customer_name, market, forecast_accuracy_2020, forecast_accuracy_2021

WITH forecast_2020 AS (
    SELECT
        s.customer_code,
        c.customer AS customer_name,
        c.market,

        SUM(s.sold_quantity) AS total_sold_qty,
        SUM(s.forecast_quantity) AS total_forecast_qty,

        SUM(s.forecast_quantity - s.sold_quantity) AS net_error,

        ROUND(
            SUM(s.forecast_quantity - s.sold_quantity) * 100.0 
            / SUM(s.forecast_quantity), 1
        ) AS net_error_pct,

        SUM(ABS(s.forecast_quantity - s.sold_quantity)) AS abs_error,

        ROUND(
            SUM(ABS(s.forecast_quantity - s.sold_quantity)) * 100.0 
            / SUM(s.forecast_quantity), 2
        ) AS abs_error_pct,

        -- Forecast Accuracy
        IF(
            ROUND(
                SUM(ABS(s.forecast_quantity - s.sold_quantity)) * 100.0 
                / SUM(s.forecast_quantity), 2
            ) > 100,
            0,
            100.0 - ROUND(
                SUM(ABS(s.forecast_quantity - s.sold_quantity)) * 100.0 
                / SUM(s.forecast_quantity), 2
            )
        ) AS forecast_accuracy

    FROM fact_act_est s
    JOIN dim_customer c
        ON s.customer_code = c.customer_code

    WHERE s.fiscal_year = 2020

    GROUP BY s.customer_code, c.customer, c.market
),

forecast_2021 AS (
    SELECT
        s.customer_code,
        c.customer AS customer_name,
        c.market,

        SUM(s.sold_quantity) AS total_sold_qty,
        SUM(s.forecast_quantity) AS total_forecast_qty,

        SUM(s.forecast_quantity - s.sold_quantity) AS net_error,

        ROUND(
            SUM(s.forecast_quantity - s.sold_quantity) * 100.0 
            / SUM(s.forecast_quantity), 1
        ) AS net_error_pct,

        SUM(ABS(s.forecast_quantity - s.sold_quantity)) AS abs_error,

        ROUND(
            SUM(ABS(s.forecast_quantity - s.sold_quantity)) * 100.0 
            / SUM(s.forecast_quantity), 2
        ) AS abs_error_pct,

        -- Forecast Accuracy
        IF(
            ROUND(
                SUM(ABS(s.forecast_quantity - s.sold_quantity)) * 100.0 
                / SUM(s.forecast_quantity), 2
            ) > 100,
            0,
            100.0 - ROUND(
                SUM(ABS(s.forecast_quantity - s.sold_quantity)) * 100.0 
                / SUM(s.forecast_quantity), 2
            )
        ) AS forecast_accuracy

    FROM fact_act_est s
    JOIN dim_customer c
        ON s.customer_code = c.customer_code

    WHERE s.fiscal_year = 2021

    GROUP BY s.customer_code, c.customer, c.market
)

-- 🔥 FINAL COMPARISON
SELECT
    f_2020.customer_code,
    f_2020.customer_name,
    f_2020.market,

    f_2020.forecast_accuracy AS forecast_acc_2020,
    f_2021.forecast_accuracy AS forecast_acc_2021

FROM forecast_2020 f_2020
JOIN forecast_2021 f_2021
    ON f_2020.customer_code = f_2021.customer_code

WHERE f_2021.forecast_accuracy < f_2020.forecast_accuracy

ORDER BY forecast_acc_2020 DESC;

