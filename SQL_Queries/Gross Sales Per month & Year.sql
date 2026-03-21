-- Croma monthly Sales
SELECT m.date,
sum(g.gross_price*m.sold_quantity) as total_GS
FROM fact_sales_monthly m
INNER JOIN fact_gross_price g
ON m.product_code = g.product_code
AND g.fiscal_year = get_fiscal_year(m.date)
WHERE m.customer_code = 90002002
group by m.date
ORDER BY m.date ASC;

--  Croma Yearly Sales
SELECT 
    get_fiscal_year(m.date) AS fiscal_year,
    SUM(g.gross_price * m.sold_quantity) AS total_GS
FROM fact_sales_monthly m
INNER JOIN fact_gross_price g
    ON m.product_code = g.product_code
   AND g.fiscal_year = get_fiscal_year(m.date)
WHERE m.customer_code = 90002002
GROUP BY get_fiscal_year(m.date)
ORDER BY fiscal_year ASC;