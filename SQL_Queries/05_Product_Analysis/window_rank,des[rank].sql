with cte1 as(SELECT * ,
row_number() over(partition by category order by category desc) as rn,
rank() over(partition by category order by category desc) as rnk,
dense_rank() over(partition by category order by category desc) as d_rnk
FROM expenses
order by category)

select * from cte1 where d_rnk<=2