USE importing_data;

SELECT * FROM pizza_sales;

-- Total revenue
SELECT SUM(total_price) "Total_Revenue" FROM pizza_sales;

-- Average Order value
SELECT SUM(total_price)/count(DISTINCT order_id) AS "Average Order Value" FROM pizza_sales;

-- Total pizzas sold
SELECT SUM(quantity) "Total pizzas sold" from pizza_sales;

-- Total orders
SELECT COUNT(DISTINCT order_id) "Total Orders" from pizza_sales;

-- Average Pizzas per Order
SELECT SUM(quantity)/COUNT(DISTINCT order_id) "Average Pizzas per Order" from pizza_sales;

-- Average Pizzas per Order in decimal format
SELECT CAST(SUM(quantity) AS DECIMAL(10,2))/CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) "Average Pizzas per Order" from pizza_sales;

-- Average Pizzas per Order, Round to 2 decimals
SELECT ROUND(SUM(quantity)/COUNT(DISTINCT order_id),2) "Average Pizzas per Order" from pizza_sales;

SELECT DATE_FORMAT(DATE("2024-12-04"),"%d/%M/%y");


-- Let's find count of orders for every day
SELECT dayname(order_date),COUNT(order_id) Count_of_allorders from pizza_sales group by dayname(order_date);

-- Let's find count of distinct orders for every day
SELECT dayname(order_date),COUNT(DISTINCT order_id)  from pizza_sales group by dayname(order_date);


-- Let's find count of distinct orders for every month
SELECT MONTHNAME(order_date),COUNT(DISTINCT order_id) Count_of_allorders_monthwise from pizza_sales group by MONTH(order_date);

-- Let's find count of distinct orders for every year
SELECT YEAR(order_date) from pizza_sales GROUP BY YEAR(order_date) 
HAVING COUNT(DISTINCT order_id)= (SELECT MAX(Count_of_allorders_monthwise) 
FROM (SELECT COUNT(DISTINCT order_id) Count_of_allorders_monthwise from pizza_sales group by YEAR(order_date)) As A);

-- % of sales by pizza category
SELECT pizza_category,SUM(total_price) "Total_price_of_category",
ROUND((ROUND(SUM(total_price),2)/ (SELECT SUM(total_price) FROM pizza_sales))*100,2) "% sales" FROM pizza_sales GROUP BY pizza_category;



-- % of sales by pizza category only for febraury month
SELECT pizza_category,SUM(total_price) "Total_price_of_category",
ROUND((ROUND(SUM(total_price),2)/ (SELECT SUM(total_price) FROM pizza_sales WHERE MONTH(order_date)=1)*100),2) "% sales" 
FROM pizza_sales Where MONTH(order_date)=1 GROUP BY pizza_category;


-- % of sales by pizza_size
SELECT pizza_size, SUM(total_price) "Total_price", ROUND(SUM(total_price)/(SELECT SUM(total_price) FROM pizza_sales WHERE QUARTER(order_date)=1)*100,2) AS PCT 
FROM pizza_sales 
WHERE QUARTER(order_date)=1 GROUP BY pizza_size ORDER BY PCT DESC;

-- Total pizzas sold by pizza category
SELECT pizza_category, SUM(quantity) "Total_Quantity" FROM pizza_sales GROUP BY pizza_category;

-- Top 5 best sellers by total pizzas sold
SELECT pizza_name, SUM(total_price) Total_price FROM pizza_sales GROUP BY pizza_name ORDER BY SUM(total_price) DESC LIMIT 5;

-- Top 5 worst sellers by total pizzas sold
SELECT pizza_name, SUM(total_price) Total_price FROM pizza_sales GROUP BY pizza_name ORDER BY SUM(total_price) ASC LIMIT 5;

-- Total 5 worst pizzas sold by pizza name
SELECT pizza_name, SUM(quantity) "Total_Quantity" FROM pizza_sales GROUP BY pizza_name ORDER BY SUM(quantity) LIMIT 5;

-- Total 5 best pizzas sold by distinct orders
SELECT pizza_name, COUNT(DISTINCT order_id) "Total_DistinctOrders" FROM pizza_sales GROUP BY pizza_name ORDER BY COUNT(distinct order_id) DESC LIMIT 5;

-- Total 5 worst pizzas sold by distinct orders
SELECT pizza_name, COUNT(DISTINCT order_id) "Total_DistinctOrders" FROM pizza_sales GROUP BY pizza_name ORDER BY COUNT(distinct order_id) ASC LIMIT 5;

SELECT pizza_category,SUM(quantity) "Sum_of_quantity" from pizza_sales group by pizza_category;