-- Retrieve the total number of orders placed.

select 
	count(order_id) as total_orders 
from orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
	ROUND(SUM(order_details.quantity * CAST(pizzas.price AS FLOAT)), 2) AS Total_Revenue_Generated
FROM order_details 
JOIN pizzas 
	ON CAST(pizzas.pizza_id AS VARCHAR(MAX)) = CAST(order_details.pizza_id AS VARCHAR(MAX));

-- Identify the highest-priced pizza.

select 
	top 1 pizza_types.name Name_of_pizza,
	pizzas.price Price_of_pizza
from pizza_types 
join pizzas
	on pizza_types.pizza_type_id = CAST(pizzas.pizza_type_id AS VARCHAR(MAX))
order by pizzas.price desc;

-- Replace TEXT with VARCHAR(MAX)

ALTER TABLE pizzas ALTER COLUMN pizza_id VARCHAR(50);
ALTER TABLE order_details ALTER COLUMN pizza_id VARCHAR(50);
ALTER TABLE pizzas ALTER COLUMN size VARCHAR(50);
ALTER TABLE pizzas ALTER COLUMN pizza_type_id VARCHAR(50);

-- Identify the most common pizza size ordered.

SELECT 
	pizzas.size Size_of_pizza,
    COUNT(order_details.pizza_id) AS No_of_times_ordered
FROM pizzas
JOIN order_details 
    ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
order by No_of_times_ordered desc;

-- List the top 5 most ordered pizza types along with their quantities.

SELECT 
	top 5
	pizza_types.name Name_of_pizza,
    SUM(order_details.quantity) AS Quantity_ordered
FROM pizzas
JOIN order_details 
    ON pizzas.pizza_id = order_details.pizza_id 
JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.name
order by Quantity_ordered desc;

-- Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
	pizza_types.category Category_of_pizza,
    SUM(order_details.quantity) AS Quantity_ordered
FROM pizzas
JOIN order_details 
    ON pizzas.pizza_id = order_details.pizza_id 
JOIN pizza_types
	ON pizzas.pizza_type_id = pizza_types.pizza_type_id
GROUP BY pizza_types.category
order by Quantity_ordered desc;

-- Determine the distribution of orders by hour of the day.

SELECT 
    DATEPART(HOUR, order_time) AS Hour_during_which_ordered,
    COUNT(order_id) AS Total_Orders
FROM orders
GROUP BY DATEPART(HOUR, order_time)
ORDER BY Total_Orders desc;

-- Join relevant tables to find the category-wise distribution of pizzas.

select
	pizza_types.category Category_of_pizza,
	count(pizza_types.name) Total_pizzas_ordered
from pizza_types
group by pizza_types.category
order by Total_pizzas_ordered desc;

-- Group the orders by date and calculate the average number of pizzas ordered per day.

select round(avg(quantity),0) average_pizzas_ordered
from
(select 
	orders.order_date order_date,
	sum(order_details.quantity) as quantity
from orders
JOIN order_details
on orders.order_id=order_details.order_id
group by orders.order_date) as ordered_quantity;

-- Determine the top 3 most ordered pizza types based on revenue.

SELECT 
	TOP 3
	pizza_types.name Name_of_pizza,
	ROUND(SUM(order_details.quantity * CAST(pizzas.price AS FLOAT)), 2) AS Revenue_Generated
FROM order_details 
JOIN pizzas 
	ON pizzas.pizza_id=order_details.pizza_id
JOIN pizza_types
	ON pizzas.pizza_type_id=pizza_types.pizza_type_id
group by pizza_types.name
order by Revenue_Generated desc;

-- Calculate the percentage contribution of each pizza type to total revenue.


SELECT 
	pizza_types.category Category_of_pizza,
	ROUND(SUM(order_details.quantity * CAST(pizzas.price AS FLOAT))/ 
	(SELECT 
	ROUND(SUM(order_details.quantity * CAST(pizzas.price AS FLOAT)), 2) AS Total_Revenue_Generated
		FROM order_details 
		JOIN pizzas 
			ON CAST(pizzas.pizza_id AS VARCHAR(MAX)) = CAST(order_details.pizza_id AS VARCHAR(MAX)))*100,2)
	AS Revenue_Generated
FROM order_details 
JOIN pizzas 
	ON pizzas.pizza_id=order_details.pizza_id
JOIN pizza_types
	ON pizzas.pizza_type_id=pizza_types.pizza_type_id
group by pizza_types.category
order by Revenue_Generated desc;

-- Analyze the cumulative revenue generated over time.

select 
	Date_of_order,
	sum(Revenue_Generated) over(order by Date_of_order)
from
(SELECT 
	orders.order_date Date_of_order,
	SUM(order_details.quantity * CAST(pizzas.price AS FLOAT)) AS Revenue_Generated
FROM order_details 
JOIN pizzas 
	ON pizzas.pizza_id=order_details.pizza_id
JOIN orders
	ON order_details.order_id=orders.order_id
group by orders.order_date) as sales;

-- Determine the top 3 most ordered pizza types based on revenue for each pizza category.

select 
	Category_of_pizza,
	Name_of_pizza,
	Revenue_Generated
from 
(select 
	Name_of_pizza,
	Category_of_pizza,
	Revenue_Generated,
	rank() over(partition by Category_of_pizza order by Revenue_Generated desc) Ranks
from
(select 
	pizza_types.name Name_of_pizza,
	pizza_types.category Category_of_pizza,
	SUM(order_details.quantity * CAST(pizzas.price AS FLOAT)) AS Revenue_Generated
from pizzas
JOIN pizza_types
on pizzas.pizza_type_id=pizza_types.pizza_type_id
JOIN order_details
on order_details.pizza_id=pizzas.pizza_id
group by pizza_types.name,pizza_types.category) as sales) as a
where Ranks<=3;