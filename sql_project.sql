----SQL Retail Sales Analysis----

----Create Table-----

CREATE TABLE retail_sales
			(
				transactions_id INT PRIMARY KEY,
				sale_date DATE,
				sale_time TIME,
				customer_id	INT,
				gender VARCHAR(15),
				age	INT,
				category VARCHAR(15),	
				quantiy	INT,
				price_per_unit FLOAT,
				cogs FLOAT,
				total_sale FLOAT
			)

select * from retail_sales limit 100

select count(*) from retail_sales 

select * from retail_sales

----DATA CLEANING----

select * from retail_sales 
where 
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null

---

delete from retail_sales
where
	transactions_id is null
	or
	sale_date is null
	or
	sale_time is null
	or
	customer_id is null
	or
	gender is null
	or
	age is null
	or
	category is null
	or
	quantiy is null
	or
	price_per_unit is null
	or
	cogs is null
	or
	total_sale is null


----DATA EXPLORATION----

-----How many sales we have

select count(*) total_sale from retail_sales


-----How many unique customers we have

select count(distinct customer_id) from retail_sales


------How many category we have 

select count(category) from retail_sales


------category we have


select category from retail_sales


------How many distinct category we have

select distinct category from retail_sales


-----Data Analysis & Business Key Problems & Answers


----Q1 SQL Query to retrieve all columns for sales made on 2022-11-05

select * 
from 
retail_sales
where sale_date = '2022-11-05';


-----Q2 SQL Query to retrieve all transactions where category is 'clothing' and the quantity sold is more than or equal to 4 
-----in the month of Nov-2022

select * 
from retail_sales
where 
	category  = 'Clothing'
	and 
	to_char(sale_date, 'yyyy-mm') = '2022-11'
	and 
	quantiy >= 4;

----Q3 SQL query to calculate the total sales for each category

select 
	category,
	sum(total_sale) as net_sale,
	count (*) as total_orders
	from retail_sales
	group by 1

------Q4 SQL query to find the average age of customers who purchased items from the 'beauty' category 

select 
	round(avg(age),2) as avg_age
from retail_sales
where
	category = 'Beauty'

-----Q5 SQL query to find all transactions where the total sale is greater than 1000 

select * from retail_sales
where total_sale > 1000;

-----Q6 SQL query to find total number of transactions made by each gender by each category

select 
	category,
	gender,
count(*) as total_trans
from retail_sales
group by 
	category,
	gender
order by 1;

-----Q7 SQL Query to calculate average age for each month Find out best selling month in each year 

select
	year,
	month,
	avg_sale
from
(
	select 
		extract(year from sale_date) as year,
		extract(month from sale_date) as month,
		avg(total_sale) as avg_sale,
		rank() over(partition by extract(year from sale_date) order by avg(total_sale) desc)
		from retail_sales
		group by 1, 2
) as t1 
where rank = 1
--order by 1, 3 desc

---- Q8 SQL query to find the top customers based on the highest toal sales

select 
	customer_id,
	sum(total_sale) as total_sales
from retail_sales 
group by 1
order by 2  desc 
limit 5

------Q9 SQL query to find unique customers who purchased items from each category

select 
	category,
	count(distinct customer_id) as unique_customer
from retail_sales
group by category


---- Q10 SQL query to create each shift and number of orders (Example morning < 10, Afternoon between 12 & 17, evening  > 17 )

with hourly_sale
as
(
select *,
	case 
		when extract(hour from sale_time) < 12 then 'Morning'
		when extract(hour from sale_time) between 12 and 17 then 'Afternoon'
		else 'Evening'
	end as shift
from retail_sales
)
select 	
	shift,
	count(*) as total_orders 
from hourly_sale
group by shift









	



