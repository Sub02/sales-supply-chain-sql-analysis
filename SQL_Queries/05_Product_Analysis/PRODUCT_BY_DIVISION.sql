-- Product Analysis: Top 3 Products by Division (FY 2021)

WITH ranked_products AS (
    SELECT 
        p.division,
        s.product_code,
        p.product,
        SUM(s.sold_quantity) AS total_sold_quantity,
        RANK() OVER (
            PARTITION BY p.division 
            ORDER BY SUM(s.sold_quantity) DESC
        ) AS rank_order
    FROM fact_sales_monthly s
    JOIN dim_product p 
        ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY p.division, s.product_code, p.product
)

SELECT 
    division,
    product_code,
    product,
    total_sold_quantity,
    rank_order
FROM ranked_products
WHERE rank_order <= 3
ORDER BY division, rank_order;
