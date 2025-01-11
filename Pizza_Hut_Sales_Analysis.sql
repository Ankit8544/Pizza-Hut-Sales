-- Q.No-01 Retrieve the total number of orders placed.

SELECT 
    COUNT(orders.order_id) AS Total_Orders
FROM
    orders;
    
-- Q.No-02 Calculate the total revenue generated from pizza sales.

SELECT 
    ROUND(SUM(order_details.quantity * pizzas.price),
            2) AS Total_Revenue
FROM
    order_details
        JOIN
    pizzas ON pizzas.pizza_id = order_details.pizza_id;
    
-- Q.No-03 Identify the highest-priced pizza.

SELECT 
    pizza_types.name, pizzas.price
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
ORDER BY pizzas.price DESC
LIMIT 1;

-- Q.No-04 Identify the most common pizza size ordered.

SELECT 
    pizzas.size,
    COUNT(order_details.order_details_id) AS Most_Common_Pizza_Size
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
GROUP BY pizzas.size
ORDER BY Most_Common_Pizza_Size DESC
LIMIT 1;

-- Q.No-05 List the top 5 most ordered pizza types along with their quantities.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity) AS Quantity_Ordered
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Quantity_Ordered DESC
LIMIT 5;

-- Q.No-06 Join the necessary tables to find the total quantity of each pizza category ordered.

SELECT 
    pizza_types.category,
    SUM(order_details.quantity) AS Quantity_Ordered
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category
ORDER BY Quantity_Ordered DESC;

-- Q.No-07 Determine the distribution of orders by hour of the day.

SELECT 
    HOUR(orders.order_time) AS Hour, COUNT(orders.order_id) AS Order_Count
FROM
    orders
GROUP BY HOUR(order_time);

-- Q.No-08 Join relevant tables to find the category-wise distribution of pizzas.

SELECT 
    pizza_types.category AS Category,
    COUNT(pizza_types.name) AS No_of_Pizzas
FROM
    pizza_types
GROUP BY Category;

-- Q.No-09 Group the orders by date and calculate the average number of pizzas ordered per day.

SELECT 
    ROUND(AVG(Quantity), 0) AS Avg_Order_Per_Day
FROM
    (SELECT 
        orders.order_date, SUM(order_details.quantity) AS Quantity
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS Order_Quantity;

-- Q.No-10 Determine the top 3 most ordered pizza types based on revenue.

SELECT 
    pizza_types.name,
    SUM(order_details.quantity * pizzas.price) AS Total_Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY Total_Revenue DESC
LIMIT 3;

-- Q.No-11 Calculate the percentage contribution of each pizza type to total revenue.

SELECT 
    pizza_types.category,
    CONCAT(ROUND((SUM(order_details.quantity * pizzas.price) / (SELECT 
                            ROUND(SUM(order_details.quantity * pizzas.price),
                                        2) AS Total_Revenue
                        FROM
                            order_details
                                JOIN
                            pizzas ON pizzas.pizza_id = order_details.pizza_id)) * 100,
                    2),
            ' %') AS Percentage_Contribution_in_Revenue
FROM
    pizza_types
        JOIN
    pizzas ON pizzas.pizza_type_id = pizza_types.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;

-- Q.No-12 Analyze the cumulative revenue generated over time.

SELECT 
    order_date,
    SUM(Total_Revenue) OVER(ORDER BY order_date) AS Cumulative_Revenue
FROM
    (SELECT 
        orders.order_date,
        SUM(order_details.quantity * pizzas.price) AS Total_Revenue
    FROM 
        order_details 
    JOIN 
        pizzas ON order_details.pizza_id = pizzas.pizza_id
    JOIN 
        orders ON orders.order_id = order_details.order_id
    GROUP BY 
        orders.order_date) AS Per_Day_Revenue;

-- Q.No-13 Determine the top 3 most ordered pizza types based on revenue for each pizza category.

SELECT 
    category, 
    name, 
    Total_Revenue 
FROM
    (SELECT 
        category, 
        name, 
        Total_Revenue,
        RANK() OVER(PARTITION BY category ORDER BY Total_Revenue DESC) AS rn
    FROM
        (SELECT 
            pizza_types.category, 
            pizza_types.name,
            SUM(order_details.quantity * pizzas.price) AS Total_Revenue
        FROM 
            pizza_types 
        JOIN 
            pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN 
            order_details ON order_details.pizza_id = pizzas.pizza_id
        GROUP BY 
            pizza_types.category, 
            pizza_types.name) AS a) AS b
WHERE 
    rn <= 3;
