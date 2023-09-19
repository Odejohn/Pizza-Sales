
USE pizza_db;
CREATE TABLE pizza_sales
(
  pizza_id INT,
  order_id INT,
  pizza_name_id VARCHAR(50),
  quantity TINYINT,
  order_date DATE,
  order_time TIME,
  unit_price FLOAT,
  total_price FLOAT,
  pizza_size VARCHAR(50),
  pizza_category VARCHAR(50),
  pizza_ingredients VARCHAR(200),
  pizza_name VARCHAR(200)
  );
  
  LOAD DATA INFILE 'C:\\ProgramFiles\\MySQL\\MySQL Server 8.0\\Uploads\\pizza_sales.csv'
  INTO TABLE pizza_sales
  FIELDS TERMINATED BY ',' ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 LINES;

  SHOW VARIABLES LIKE "secure_file_priv";]
show databases;

-- TOTAL REVENUE: sum of the total price of all pizza orders --
SELECT SUM(total_price) as Total_Revenue 
FROM pizza_sales;

-- AVERAGE ORDER VALUE --
SELECT SUM(total_price) / COUNT(DISTINCT order_id) AS Average_Order_Value 
FROM pizza_sales;

-- TOTAL PIZZAS SOLD --
SELECT SUM(quantity) AS Total_Pizzas_Sold FROM pizza_sales;

-- TOTAL ORDERS --
SELECT COUNT(DISTINCT order_id) AS Total_Orders FROM pizza_sales;

-- AVERAGE PIZZAS PER ORDER --
SELECT SUM(quantity) / COUNT(DISTINCT order_id) AS Average_Pizzas_Per_Order 
FROM pizza_sales;

-- DAILY TREND FOR TOTAL ORDERS --
SELECT DATE_FORMAT(order_date,'%W') AS order_day, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY order_day
ORDER BY Total_Orders DESC;


-- MONTHLY TREND FOR TOTAL ORDERS --
SELECT DATE_FORMAT(order_date,'%M') AS Month_Name, COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales
GROUP BY Month_Name
ORDER BY Total_Orders DESC;


-- PERCENTAGE OF SALES BY ORDER CATEGORY --
SELECT pizza_category, SUM(total_price) as Total_Sales , CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2))  AS PCT
FROM pizza_sales
GROUP BY pizza_category;


-- PERCENTAGE OF SALES BY PIZZA'S SIZE --
SELECT pizza_size, SUM(total_price) as Total_Sales , CAST(SUM(total_price) * 100 / 
(SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY PCT DESC;

-- TOP 5 BEST SELLERS BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS --
-- REVENUE --
SELECT pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Revenue DESC LIMIT 5;
-- QUANTITY --
SELECT pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Quantity DESC LIMIT 5;
-- ORDERS --
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Order DESC LIMIT 5;


-- BOTTOM 5 BEST SELLERS BY REVENUE, TOTAL QUANTITY AND TOTAL ORDERS --
-- REVENUE --
SELECT pizza_name, SUM(total_price) AS Total_Revenue FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Revenue ASC LIMIT 5;
-- QUANTITY --
SELECT pizza_name, SUM(quantity) AS Total_Quantity FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Quantity ASC LIMIT 5;
-- ORDERS --
SELECT pizza_name, COUNT(DISTINCT order_id) AS Total_Order FROM pizza_sales 
GROUP BY pizza_name
ORDER BY Total_Order ASC LIMIT 5;



