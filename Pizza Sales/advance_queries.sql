-- Calculate the percentage contribution of each pizza type to total revenue.
SELECT 
    category,
    ROUND((SUM(quantity * price) / (SELECT 
                    SUM(quantity * price)
                FROM
                    order_details a1
                        JOIN
                    pizzas a2 ON a1.pizza_id = a2.pizza_id)) * 100,
            2) as percentage
FROM
    order_details t1
        JOIN
    pizzas t2 ON t1.pizza_id = t2.pizza_id
        JOIN
    pizza_types t3 ON t2.pizza_type_id = t3.pizza_type_id
GROUP BY category;

-- Analyze the cumulative revenue generated over time.
select date,time,sum(revenue) over(order by date,time) as cum_revenue from
(select date,time,(quantity*price) as revenue from orders t1
join order_details t2
on t1.order_id = t2.order_id
join pizzas t3
on t2.pizza_id = t3.pizza_id
order by date asc,time) d1;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.
select name, revenue from
(select category,name,revenue, rank() over(partition by category order by revenue desc) as rn from
(select category,name,round(sum(quantity*price),2) as revenue from order_details t1
join pizzas t2
on t1.pizza_id = t2.pizza_id
join pizza_types t3
on t2.pizza_type_id = t3.pizza_type_id
group by category,name) as d1) d2
where rn<=3;

