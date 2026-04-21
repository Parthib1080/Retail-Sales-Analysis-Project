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


'''sql
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

'''sql


### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

'''sql
SELECT COUNT(*) FROM sales2;
SELECT COUNT(DISTINCT customer_id) FROM sales2;
SELECT DISTINCT category FROM sales2;

SELECT * FROM sales2
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM sales2
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

'''sql



The following SQL queries were developed to answer specific business questions:

