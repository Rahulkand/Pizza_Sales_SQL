-- Join the necessary tables to find the total quantity of each pizza category ordered.
SELECT 
    category, SUM(quantity) AS total_quatity
FROM
    order_details t1
        JOIN
    pizzas t2 ON t1.pizza_id = t2.pizza_id
        JOIN
    pizza_types t3 ON t2.pizza_type_id = t3.pizza_type_id
GROUP BY category;

-- Determine the distribution of orders by hour of the day.
SELECT 
    HOUR(TIME(time)) AS time, COUNT(order_id) AS no_of_orders
FROM
    orders
GROUP BY HOUR(TIME(time));

-- Join relevant tables to find the category-wise distribution of ordered.
SELECT 
    category, COUNT(order_id) AS category_count
FROM
    order_details t1
        JOIN
    pizzas t2 ON t1.pizza_id = t2.pizza_id
        JOIN
    pizza_types t3 ON t2.pizza_type_id = t3.pizza_type_id
GROUP BY category;


-- Group the orders by date and calculate the average number of pizzas ordered per day.
SELECT 
    round(AVG(quantity_ordered),0) as avg_per_day
FROM
    (SELECT 
        DATE(date) AS day, SUM(quantity) AS quantity_ordered
    FROM
        order_details t1
    JOIN orders t2 ON t1.order_id = t2.order_id
    GROUP BY DATE(date)) AS t1;
    
-- Determine the top 3 most ordered pizza types based on revenue.
SELECT 
    name, SUM(quantity * price) AS revenue
FROM
    order_details t1
        JOIN
    pizzas t2 ON t1.pizza_id = t2.pizza_id
        JOIN
    pizza_types t3 ON t2.pizza_type_id = t3.pizza_type_id
GROUP BY name
ORDER BY revenue DESC
LIMIT 3;