CREATE DATABASE cwiczenia1

USE cwiczenia1 

-- Exercise 1

WITH cte AS (
SELECT o.order_id
	,o.date
	,sum(od.quantity * p.price) AS order_price
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
WHERE date = '2015-02-18'
GROUP BY o.order_id, o.date )

SELECT  date
	,AVG(order_price) AS avg_order_price
FROM cte
GROUP BY date

-- Exercise 2

SELECT	o.order_id
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizza_types pt ON LEFT(od.pizza_id, LEN(od.pizza_id) - 2) = pt.pizza_type_id
WHERE MONTH(date) = 3 AND YEAR(date) = 2015 
GROUP BY o.order_id
HAVING STRING_AGG(ingredients, ',') NOT LIKE '%Pineapple%'

-- Exercise 3

WITH cte AS (
SELECT o.order_id
	,o.date
	,sum(od.quantity * p.price) AS order_price
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
WHERE MONTH(date) = 2
GROUP BY o.order_id, o.date )

SELECT TOP (10) order_id
	,order_price
	,RANK () OVER (ORDER BY order_price DESC) AS rank_price
FROM cte

-- Exercise 4

WITH cte AS (
SELECT o.order_id
	,sum(od.quantity * p.price) AS order_amount
	,o.date
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
GROUP BY o.order_id, o.date )

SELECT	order_id
	,order_amount
	,AVG(order_amount) OVER (PARTITION BY MONTH(date)) AS average_month_amount
	,date
FROM cte

-- Exercise 5

SELECT	count(order_id) AS count_orders
	,date
	,DATEPART(hour, time) AS hour
FROM orders 
WHERE date = '2015-01-01'
GROUP BY date, DATEPART(hour, time)

-- Exercise 6

SELECT	name
	,category
	,COUNT(o.order_id) AS count_orders
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizza_types pt ON LEFT(od.pizza_id, LEN(od.pizza_id) - 2) = pt.pizza_type_id
WHERE MONTH(date) = 1 AND YEAR(date) = 2015
GROUP BY name, category

-- Exercise 7

SELECT	size
	,COUNT(o.order_id) AS count_orders
FROM orders o
JOIN order_details od ON o.order_id = od.order_id
JOIN pizzas p ON od.pizza_id = p.pizza_id
WHERE (MONTH(date) = 2 OR  MONTH(date) = 3) AND YEAR(date) = 2015
GROUP BY size