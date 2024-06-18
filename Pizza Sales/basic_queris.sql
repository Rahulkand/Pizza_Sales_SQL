-- Retrieve the total number of orders placed.
SELECT 
    COUNT(*)
FROM
    orders;

-- Calculate the total revenue generated from pizza sales.
SELECT 
    ROUND(SUM(quantity * price), 2) AS total_sales
FROM
    order_details t1
        JOIN
    pizzas t2 ON t1.pizza_id = t2.pizza_id;
    
-- Identify the highest-priced pizza.
with highest_pizza as (SELECT 
    pizza_type_id,price as highest_priced_pizza
FROM
    pizzas
where price = (select max(price) from pizzas))

SELECT 
    name
FROM
    pizza_types t1
        JOIN
    highest_pizza t2 ON t1.pizza_type_id = t2.pizza_type_id;
    
-- Identify the most common pizza size ordered.
SELECT 
    size, COUNT(order_details_id)
FROM
    order_details t1
        JOIN
    pizzas t2 ON t1.pizza_id = t2.pizza_id
GROUP BY size;

-- Identify the ordered quatity of each pizza size
SELECT 
    size, SUM(total_count)
FROM
    (SELECT 
        size, quantity * COUNT(size) AS total_count
    FROM
        order_details t1
    JOIN pizzas t2 ON t1.pizza_id = t2.pizza_id
    GROUP BY size , quantity) t1
GROUP BY size;

-- List the top 5 most ordered pizza types along with their quantities.
SELECT 
    name, total_quantity
FROM
    (SELECT 
        pizza_type_id, SUM(quantity) AS total_quantity
    FROM
        order_details t1
    JOIN pizzas t2 ON t1.pizza_id = t2.pizza_id
    GROUP BY pizza_type_id) d1
        JOIN
    pizza_types d2 ON d1.pizza_type_id = d2.pizza_type_id
ORDER BY total_quantity DESC
LIMIT 5;
