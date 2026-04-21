# Retail Sales Analysis SQL Project

## Project Overview
  
The purpose of this project is to illustrate the SQL abilities and methods that data analysts commonly employ to examine, purify, and evaluate retail sales data. Establishing a retail sales database, conducting exploratory data analysis (EDA), and using SQL queries to address particular business questions are all part of the project. For people who want to establish a strong foundation in SQL and are just starting out in data analysis, this project is perfect.


## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.


## Project Structure

### 1. Database Setup

- **Table Creation**: A table named `sales1` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.
- **Secondary Table** : A second table 'sales2' is created to clean tha table and exploraing the data set


```sql
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM sales2
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

```sql
select *
from sales2
where category = 'Clothing' 
	and quantiy >= 4 
     and sale_date  like '2022-11-%' ;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.

```sql
  select category , sum(total_sale) as Total_Sales 
  from sales2 
  group by category ;
```

4. ** Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

```sql
select avg(age) as Average_Age 
from sales2
where category = 'Beauty' ;
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.

```sql
select *
from sales2
where total_sale  > 1000;
```

6. ** Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.

```sql
select gender , category , count(transactions_id) as Transactions
 from sales2
 group by Category , gender 
 order by 2 ;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales

```sql
select customer_id as Customer , sum(total_sale) as Total_Sales
from sales2
group by Customer
order by Total_Sales desc
limit 5 ;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.

```sql
select category , count(distinct customer_id) as Unique_Cus
 from sales2
 group by category ;
 
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

```sql
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




