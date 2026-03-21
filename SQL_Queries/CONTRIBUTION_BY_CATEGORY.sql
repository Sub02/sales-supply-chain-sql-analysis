with cte1 as (
SELECT 
    s.customers,
    c.region,
    ROUND(SUM(s.net_sales)/1000000,2) AS Net_Sales_millions
FROM net_sales s
INNER JOIN dim_customer c
    USING(customer_code)
WHERE s.fiscal_year = 2021
GROUP BY s.customers, c.region)
select * ,
Net_Sales_millions*100/sum(Net_Sales_millions) over (partition by region) as pct_share_region
from cte1
order by region, Net_Sales_millions desc