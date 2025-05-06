# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  

**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `sql_project_p1`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_p1;

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

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql

SELECT * FROM retail_sales;

SELECT COUNT(*) FROM retail_sales;

SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

SELECT DISTINCT category FROM retail_sales;

-- How many sales we have?
SELECT COUNT(*) as total_sale FROM retail_sales

-- How many uniuque customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale FROM retail_sales

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **write a sql query to retrieve for the sales made on '2022-11-05'**:
```sql

SELECT total_sale FROM retail_sales
WHERE sale_date = '2022-11-05'
;
```

2. **write a sql query to retrieve all transactions where category is 'clothing' and the quantity sold is more than 10 in the month of Nov-2022**:
```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing' AND 
	  quantity >= 4 AND
	  TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
```

3. ** write a sql query to calculate total sales(total_sale) for each category**:
```sql
SELECT category, SUM(total_sale) AS sale_by_category
FROM retail_sales
GROUP BY 1;
```

4. **write a sql query to find the average age of customers who purchased items from the 'Beauty' category?**:
```sql

SELECT ROUND(AVG(age) , 2) AS Age FROM retail_sales
WHERE category = 'Beauty'
```

5. **Q.5 write a sql query to find all transactions where the total sales is greater than 1000?**:
```sql
SELECT * FROM retail_sales 
WHERE total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category.**:
```sql
SELECT COUNT(transactions_id) AS total_count , gender , category 
FROM retail_sales
GROUP BY 2,3;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
SELECT
		TO_CHAR(sale_date , 'MONTH'),
		TO_CHAR(sale_date , 'YYYY') AS YEAR_, 
		ROUND(AVG(total_sale),2) AS avg_sale,
		RANK() OVER(PARTITION BY TO_CHAR(sale_date , 'YYYY') ORDER BY AVG(total_sale) DESC ) 
FROM retail_sales
GROUP BY 2,1
ORDER BY 2,3 DESC;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT customer_id, 
		SUM(total_sale) AS total_sale FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **write a query to find the number of unique customers who purchased items from each category?.**:
```sql
SELECT COUNT(DISTINCT(customer_id)) AS unique_customers,
		category FROM retail_sales
GROUP BY category 
```

10. **.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


## Author -Akash Kumar Gupta

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!

