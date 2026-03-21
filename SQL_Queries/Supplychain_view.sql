with forecast_err_table as(SELECT 
    customer_code,

    SUM(forecast_quantity - sold_quantity) AS net_error,

    SUM(forecast_quantity - sold_quantity) * 100.0 
    / SUM(forecast_quantity) AS net_error_pct,

    SUM(ABS(forecast_quantity - sold_quantity)) AS abs_net_error,

    SUM(ABS(forecast_quantity - sold_quantity)) * 100.0 
    / SUM(forecast_quantity) AS abs_net_error_pct

FROM gdb0041.fact_act_est

WHERE fiscal_year = 2021

GROUP BY customer_code)
select *,
(100-abs_net_error_pct) as forecast_accuracy
from forecast_err_table
order by forecast_accuracy asc