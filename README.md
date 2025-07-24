# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_p1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

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
CREATE TABLE retail_sales(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,
customer_id INT,
gender VARCHAR(15),
age	INT,
category VARCHAR(15),	
quantity INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT
);
   
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMERS FROM retail_sales;
SELECT DISTINCT category AS TOTAL_CATEGORY FROM retail_sales;

SELECT * FROM retail_sales
WHERE transactions_id is NULL;

SELECT * FROM retail_sales
WHERE 
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantity is NULL
OR
price_per_unit is NULL
OR
cogs is NULL 
OR
total_sale is NULL;

DELETE FROM retail_sales
WHERE 
transactions_id is NULL
OR
sale_date is NULL
OR
sale_time is NULL
OR
customer_id is NULL
OR
gender is NULL
OR
age is NULL
OR
category is NULL
OR
quantity is NULL
OR
price_per_unit is NULL
OR
cogs is NULL 
OR
total_sale is NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'**:
```sql
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';
```

2. **WRITE A SQL QUERY TO RETREIVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 4 IN THE MONTH OF NOV-2022**:
```sql
SELECT *
FROM retail_sales
WHERE category='Clothing'
AND 
TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
AND 
quantity>=4;
```

3. **WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES (total_sale) FOR EACH CATEGORY**:
```sql
SELECT category ,
SUM(total_sale) AS net_sale,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;
```

4. **WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'Beauty' CATEGORY**:
```sql
SELECT 
ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category='Beauty';
```

5. **WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE total_sale IS GREATER THAN 1000**:
```sql
SELECT * FROM retail_sales
WHERE total_sale>1000;
```

6. **WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (transaction_id) MADE BY EACH GENDER IN EACH CATEGORY**:
```sql
SELECT category,gender,
COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category,gender
ORDER BY 1;
```

7. **WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH.FIND THE BEST SELLING MONTH IN EACH YEAR**:
```sql
 SELECT
year,
month,
AVERAGE_SALE
FROM
(
SELECT 
EXTRACT(YEAR FROM sale_date) AS YEAR,
EXTRACT(MONTH FROM sale_date) AS MONTH,
AVG(total_sale) AS AVERAGE_SALE,
RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS RANK
FROM retail_sales
GROUP BY 1,2) AS T1
WHERE rank=1;
```

8. **WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED 0N THE HIGHEST TOTAL SALES**:
```sql
SELECT 
customer_id,
SUM(total_sale) AS TOTAL_SALES
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

9. **WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FROM EACH CATEGORY**:
```sql
SELECT
category,
COUNT(DISTINCT customer_id) AS COUNT_OF_UNIQUE_CUSTOMERS
FROM retail_sales
GROUP BY category;
```

10. **WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS ( EXAMPLE MORNING <12, AFTERNOON BETWEEN 12 & 17, EVENING >17)**:
```sql
WITH hourly_sale
AS
(
SELECT *,
CASE
WHEN EXTRACT(HOUR FROM sale_time) <12 THEN 'MORNING'
WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
ELSE 'EVENING'
END AS SHIFT
FROM retail_sales
)
SELECT
SHIFT,
COUNT(*) AS TOTAL_ORDERS
FROM hourly_sale
GROUP BY SHIFT;
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


- **LinkedIn**: (www.linkedin.com/in/smtahaimran)

Thank you for your support, and I look forward to connecting with you!
