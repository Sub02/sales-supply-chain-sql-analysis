# P & L STATEMENT
-- NET SALES
SELECT *,
(1-pre_invoice_discount_pct)* net_invoice_sales as net_sales
 FROM
 sales_post_inv_discounts s
 