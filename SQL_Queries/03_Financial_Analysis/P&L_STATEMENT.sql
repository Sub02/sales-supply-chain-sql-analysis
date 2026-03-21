EXPLAIN analyze
SELECT 
    m.date,
    m.product_code,
    p.product,
    p.variant,
    m.sold_quantity,
    g.gross_price AS gross_price_per_item,
    (m.sold_quantity * g.gross_price) AS gross_price_total,
    pre.pre_invoice_discount_pct
FROM fact_sales_monthly m
INNER JOIN dim_product p
    ON m.product_code = p.product_code
INNER JOIN fact_gross_price g
    ON m.product_code = g.product_code
   AND g.fiscal_year = get_fiscal_year(m.date)
INNER JOIN fact_pre_invoice_deductions pre
    ON pre.customer_code = m.customer_code 
   AND pre.fiscal_year = get_fiscal_year(m.date)
ORDER BY m.date ASC
LIMIT 1000000;