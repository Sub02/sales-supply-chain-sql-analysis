SELECT
	customers ,
	round(sum(net_sales)/1000000,2) as Net_Sales_millions
	from net_sales
	where fiscal_year=2021
	group by customers
	order by 
	Net_Sales_millions
	desc
	limit 5