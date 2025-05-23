-- IMPORTING DATA 
DROP TABLE IF EXISTS retail_sales; 

CREATE TABLE retail_sales(
transactions_id	INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,	
gender VARCHAR(15),
age INT	,
category VARCHAR(15), 
quantiy	INT,
price_per_unit INT,	
cogs NUMERIC(10,2) ,
total_sale NUMERIC(10,2)
);

SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;

--DATA CLEANING
SELECT * FROM retail_sales
WHERE transactions_id IS NULL OR
		sale_date IS NULL OR
		sale_time IS NULL OR
		customer_id IS NULL OR
		gender IS NULL OR
		age IS NULL OR
		category IS NULL OR
		quantity IS NULL OR
		price_per_unit IS NULL OR
		cogs IS NULL OR
		total_sale IS NULL;

DELETE FROM retail_sales
WHERE transactions_id IS NULL OR
		sale_date IS NULL OR
		sale_time IS NULL OR
		customer_id IS NULL OR
		gender IS NULL OR
		age IS NULL OR
		category IS NULL OR
		quantity IS NULL OR
		price_per_unit IS NULL OR
		cogs IS NULL OR
		total_sale IS NULL;

-- DATA EXPLORATION

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?

SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales


-- DATA ANALYSIS & BUSINESS PROBLEM KEY PROBELMS AND ANSWERS
-- MY ANALYSIS AND FINDINGS

-- Q.1 write a sql query to retrieve for the sales made on '2022-11-05'
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


--Q.1 write a sql query to retrieve for the sales made on '2022-11-05'

SELECT total_sale FROM retail_sales
WHERE sale_date = '2022-11-05'
;

--Q.2 write a sql query to retrieve all transactions where category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * FROM retail_sales
WHERE category = 'Clothing' AND 
	  quantity >= 4 AND
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'

--Q.3 write a sql query to calculate total sales(total_sale) for each category?

SELECT category, SUM(total_sale) AS sale_by_category
FROM retail_sales
GROUP BY 1;

--Q.4 write a sql query to find the average age of customers who purchased items from the 'Beauty' category?

SELECT ROUND(AVG(age) , 2) AS Age FROM retail_sales
WHERE category = 'Beauty'
;

--Q.5 write a sql query to find all transactions where the total sales is greater than 1000?

SELECT * FROM retail_sales 
WHERE total_sale > 1000;



--Q.6 Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category.

SELECT COUNT(transactions_id) AS total_count , gender , category 
FROM retail_sales
GROUP BY 2,3;

--Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT
		TO_CHAR(sale_date , 'MONTH'),
		TO_CHAR(sale_date , 'YYYY') AS YEAR_, 
		ROUND(AVG(total_sale),2) AS avg_sale,
		RANK() OVER(PARTITION BY TO_CHAR(sale_date , 'YYYY') ORDER BY AVG(total_sale) DESC ) 
FROM retail_sales
GROUP BY 2,1
ORDER BY 2,3 DESC;


--Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT customer_id, 
		SUM(total_sale) AS total_sale FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Q.9 write a query to find the number of unique customers who purchased items from each category?

SELECT COUNT(DISTINCT(customer_id)) AS unique_customers,
		category FROM retail_sales
GROUP BY category 
;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS (
SELECT * ,CASE 
WHEN sale_time <= '12:00:00' THEN 'morning'
WHEN sale_time BETWEEN '12:00:00' AND '17:00:00' THEN 'afternoon'
WHEN sale_time >= '17:00:00' THEN 'evening'
END AS shift 
FROM retail_sales
)

SELECT shift , COUNT(*) AS total_orders FROM hourly_sale
GROUP BY shift;


-- END OF PROJECT