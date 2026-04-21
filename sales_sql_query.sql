-- Data Setup 

select  * 
from sales1 ;

create table sales2
(
  `transactions_id` int DEFAULT NULL,
  `sale_date` text,
  `sale_time` text,
  `customer_id` int DEFAULT NULL,
  `gender` text,
  `age` int DEFAULT NULL,
  `category` text,
  `quantiy` int DEFAULT NULL,
  `price_per_unit` int DEFAULT NULL,
  `cogs` int DEFAULT NULL,
  `total_sale` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

insert into sales2
select *
from sales1 ;

select * 
from sales2;

UPDATE sales2
SET sale_date = STR_TO_DATE(sale_date, '%d/%m/%Y');

-- Data Cleaning 

Select * 
from sales2 
where transactions_id = 'NULL' ;

SELECT * FROM sales2 
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;


delete  FROM sales2 
WHERE 
    transactions_id IS NULL
    OR
    sale_date IS NULL
    OR 
    sale_time IS NULL
    OR
    gender IS NULL
    OR
    category IS NULL
    OR
    quantiy IS NULL
    OR
    cogs IS NULL
    OR
    total_sale IS NULL;

-- Data Exploration   

-- How many sales we have?

SELECT COUNT(*) as total_sale FROM sales2;

-- How amny customers do we have


select count(distinct customer_id) as Customers from sales2 ;

-- How many Categories We have 

select distinct category from sales2;

-- Total Sales done

select sum(total_sale) from sales2 ;

-- Total sale category wise

select  category , sum(total_sale) 
from sales2
group by category ;

-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)


-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

select *
from sales2
where sale_date like '2022-11-05' ;


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

select *
from sales2
where category = 'Clothing' 
	and quantiy >= 4 
     and sale_date  like '2022-11-%' ;
     

-- .3 Write a SQL query to calculate the total sales (total_sale) for each category.
   
  select category , sum(total_sale) as Total_Sales 
  from sales2 
  group by category ;
  
  
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

select avg(age) as Average_Age 
from sales2
where category = 'Beauty' ; 
  
  
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.

select *
from sales2
where total_sale  > 1000;


-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
 
 select gender , category , count(transactions_id) as Transactions
 from sales2
 group by Category , gender 
 order by 2 ;
  
  
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT year, month, total_sales
FROM (
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        SUM(total_sale) AS total_sales,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY SUM(total_sale) DESC) AS rnk
    FROM sales2
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) t
WHERE rnk = 1;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

select customer_id as Customer , sum(total_sale) as Total_Sales
from sales2
group by Customer
order by Total_Sales desc
limit 5 ;


-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
 
 select category , count(distinct customer_id) as Unique_Cus
 from sales2
 group by category ;
 
 
 -- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

WITH hourly_sale
AS
(
SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END as shift
FROM sales2
)
SELECT 
    shift,
    COUNT(*) as total_orders    
FROM hourly_sale
GROUP BY shift ;