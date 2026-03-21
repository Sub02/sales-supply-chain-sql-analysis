SELECT * FROM fact_sales_monthly;
-- All availabe markets
select DISTINCT market from dim_customer;
-- All distribution methods
select DISTINCT channel from dim_customer;
-- All operating regions
select DISTINCT region from dim_customer;
-- product divisions in which AtliQ usually operates
select DISTINCT division from dim_product;
-- Every product segments in production
select DISTINCT segment from dim_product;
-- Business product categories
select DISTINCT category from dim_product;

-- division -> segment -> category -> product -> variant
-- the above is the product hirarchy 
