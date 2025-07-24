---------- RETAIL SALES ANALYSIS ----------

---------------------------------------------------------------------------------------------
--START OF PROJECT
---------------------------------------------------------------------------------------------

--Create Table--

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
----------------
--VIEW TABLE--

SELECT * FROM retail_sales ;

------------------------------------------------------------------------------------------------

--DATA CLEANING--

------------------------------------------------------------------------------------------------
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
--
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
--------------------------------------------------------------------------------------------------------------------------

--DATA EXPLORATION--

--------------------------------------------------------------------------------------------------------------------------
--HOW MANY SALES WE HAVE
SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales;

--
--HOW MANY CUSTOMERS WE HAVE
SELECT COUNT(DISTINCT customer_id) AS TOTAL_CUSTOMERS FROM retail_sales;

--
--HOW MANY CATEGORY WE HAVE
SELECT DISTINCT category AS TOTAL_CATEGORY FROM retail_sales;

-------------------------------------------------------------------------------------------------------------------------------

--DATA ANALYSIS AND BUSINESS KEY PROBLEMS & ANSWERS

-------------------------------------------------------------------------------------------------------------------------------

--
--Q1.WRITE A SQL QUERY TO RETRIEVE ALL COLUMNS FOR SALES MADE ON '2022-11-05'
SELECT * FROM retail_sales
WHERE sale_date='2022-11-05';

--
--Q2.WRITE A SQL QUERY TO RETREIVE ALL TRANSACTIONS WHERE THE CATEGORY IS 'CLOTHING' AND THE QUANTITY SOLD IS MORE THAN 4 IN THE MONTH OF NOV-2022
SELECT *
FROM retail_sales
WHERE category='Clothing'
AND 
TO_CHAR(sale_date,'YYYY-MM') = '2022-11'
AND 
quantity>=4;

--
--Q3.WRITE A SQL QUERY TO CALCULATE THE TOTAL SALES (total_sale) FOR EACH CATEGORY
SELECT category ,
SUM(total_sale) AS net_sale,
COUNT(*) AS total_orders
FROM retail_sales
GROUP BY 1;

--
--Q4.WRITE A SQL QUERY TO FIND THE AVERAGE AGE OF CUSTOMERS WHO PURCHASED ITEMS FROM THE 'Beauty' CATEGORY
SELECT 
ROUND(AVG(age),2) AS avg_age
FROM retail_sales
WHERE category='Beauty';

--
--Q5.WRITE A SQL QUERY TO FIND ALL TRANSACTIONS WHERE THE total_sale IS GREATER THAN 1000
SELECT * FROM retail_sales
WHERE total_sale>1000;

--
--Q6.WRITE A SQL QUERY TO FIND THE TOTAL NUMBER OF TRANSACTIONS (transaction_id) MADE BY EACH GENDER IN EACH CATEGORY
SELECT category,gender,
COUNT(*) AS total_transactions
FROM retail_sales
GROUP BY category,gender
ORDER BY 1;

--
--Q7.WRITE A SQL QUERY TO CALCULATE THE AVERAGE SALE FOR EACH MONTH. FIND THE BEST SELLING MONTH IN EACH YEAR 
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

--
--Q8.WRITE A SQL QUERY TO FIND THE TOP 5 CUSTOMERS BASED 0N THE HIGHEST TOTAL SALES
SELECT 
customer_id,
SUM(total_sale) AS TOTAL_SALES
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--
--Q9.WRITE A SQL QUERY TO FIND THE NUMBER OF UNIQUE CUSTOMERS WHO PURCHASED ITEMS FRPOM EACH CATEGORY
SELECT
category,
COUNT(DISTINCT customer_id) AS COUNT_OF_UNIQUE_CUSTOMERS
FROM retail_sales
GROUP BY category;

--
--Q10.WRITE A SQL QUERY TO CREATE EACH SHIFT AND NUMBER OF ORDERS ( EXAMPLE MORNING <=12, AFTERNOON BETWEEN 12 & 17, EVENING >17SE)
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

------------------------------------------------------------------------------------------
--END OF PROJECT
------------------------------------------------------------------------------------------


