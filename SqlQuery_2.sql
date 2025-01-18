
--DAY 1 (27.12.2024):
use BikeStores;
select * from customers;
--DQL = SELECT
--Order of Execution: FROM >> WHERE >> GROUP BY >> HAVING >> SELECT >> ORDER BY:

--Write a SQL query to retrieve the customer information for customers who live in 'New York' from the 'customers' table. :
select 
	t1.customer_id AS [Customer ID],
	t1.first_name AS [First Name],
	t1.last_name AS [Last Name],
	t1.phone AS [Phone],
	t1.city AS [City],
	t1.street AS [Street],
	t1.zip_code AS [Zip Name],
	t1.city AS City
From customers as t1 Where t1.city='New York';

--Write a SQL query to retrieve all the details of the customer whose customer_id is 518 from the customers table.:
select 
	t1.customer_id AS [Customer ID],
	t1.first_name AS [First Name],
	t1.last_name AS [Last Name],
	t1.phone AS [Phone],
	t1.city AS [City],
	t1.street AS [Street],
	t1.zip_code AS [Zip Name],
	t1.city AS City
From customers as t1 Where t1.customer_id=518;

--write a SQL Query to count total customers (Aggregate Functions):
select count(*) as [Total Customers] from customers

--Write a SQL query to count the total number of email addresses and phone numbers available in the customers table.:
select 
	count(t1.email) As [Total Email] ,
	count(t1.phone) As [Total Phone] 
from customers as t1;

--Write a SQL query to retrieve the details of customers from the customers table who do not have a phone number listed.:
select 
	t1.customer_id AS [Customer ID],
	t1.first_name AS [First Name],
	t1.last_name AS [Last Name],
	t1.phone AS [Phone],
	t1.city AS [City],
	t1.street AS [Street],
	t1.zip_code AS [Zip Name],
	t1.city AS City
From customers as t1 Where t1.phone is NULL;


--Write a SQL query to count the number of customers in the customers table who have a phone number listed (i.e., phone is not null).:
select count(phone) from customers where phone is not null;


--List of orders on 2017-03-15:
select * from orders as T1 where T1.order_date='2017-03-15'


--Retrieve Customers who belongs to State - NY,CA,TX (Solution 1):
select * from customers as T1 where T1.state in ('NY','CA','TX')


--Retrieve Customers who belongs to State - NY,CA,TX (Solution 2):
select * from customers as T1 where T1.state ='ny' or T1.state='ca' or T1.state='tx'


--Retrieve Customers who does not belong to NY (Solution 1):
select * from customers as T1 where T1.state!='NY'


--Retrieve Customers who does not belong to NY (Solution 2):
select * from customers as T1 where T1.state not in ('NY')


--Retrieve Customers who does not belong to NY (Solution 3):
select * from customers as T1 where T1.state <> 'NY'


--Retrieve Customers who does not belong to NY (Solution 4):
select * from customers as T1 where Not (T1.state= 'NY')

--Retrieve Customers who does not belong to NY and CA (Solution 1):
select * from customers as T1 where T1.state not in ('NY','CA')

--Retrieve Customers who does not belong to NY and CA (Solution 2):
select * from customers as T1 where T1.state !='NY' and T1.state!='CA'

--Retrieve Customers who does not belong to NY and CA (Solution 3):
select * from customers as T1 where	NOT(T1.state = 'NY') and NOT(T1.state= 'CA')

--Retrieve Customers who does not belong to NY and CA (Solution 4):
select * from customers as T1 where T1.state IN (Select Distinct state from customers where state NOT IN('ny','CA')

-- Total Customers in Each State:
select T1.state,count(*) AS [Total] from customers as T1 group by T1.state


-- Total Customers in Each State and city (Solution 1):
select T1.state,T1.city,count(*) AS [Total] from customers as T1 group by T1.state,T1.city Order by T1.state;


-- Total Customers in Each State and city (Solution 2):
select T1.state,T1.city,count(*) AS [Total] from customers as T1 group by T1.state,T1.city Order by 1;


-- Total Customers in Each State and city (Solution 3):
select T1.state,T1.city,count(*) AS [Total] from customers as T1 
group by T1.state,T1.city 
Order by 3 desc;


--DAY 2 (28.12.2024)

--Order of Execution : FROM >> WHERE >> GROUP BY >> HAVING >> SELECT >> ORDER BY:

select T1.state,T1.city,count(*) AS [Total] from customers as T1 
group by T1.state,T1.city 
Order by  [Total] ;


--Having Clause
select T1.state,count(*) AS [Total] from customers as T1 
group by T1.state 
Having count(*)>100

/*
--Sub Query: Query Residing inside another query
	1.Subquery should be in Paranthesis()
	2.Subquery should execute independently
	3.Subquery can be used in WHERE, FROM, SELECT
		From-Alice Name
		Select -Subquery Must return single value
*/

--Scenerio: List of customers's Who placed orders (Solution 1)

select * from customers 
select * from orders

select customer_id,first_name 
from customers
Where customer_id in (select Distinct customer_id from orders)


--Customers and their count of Orders
select customer_id,count(*) as Customer from orders group by customer_id

exec sp_help customers


--Insert a value to check whether it is returing customers who did not placed orders
insert into customers (first_name,last_name,email)values('Sethu','Saravanan','sethumad.4')


--Scenerio: List of customers's Who have not placed orders
select customer_id,first_name 
from customers
Where customer_id not in (select Distinct customer_id from orders)

/*
--Joins
1.Inner Join (need of common column name)
2.Outer Join
	i)	Left Join --- (All Records From Left Table Compare it to right table)
	ii)	Right Join
	iii) Full Outer Join
3.Self Join
4.Cross Join (No need of common column name)

*/

--Inner Join 
--Scenerio: List of customers's Who placed orders (solution 2)

select  
	c.customer_id AS [Customer ID],
	c.first_name+' '+c.last_name AS Customer,
	o.order_id As [Order ID],
	o.order_date AS [order date],
	o.staff_id as[Staff ID],
	s.first_name+' '+s.last_name As[Staff Name],
	o.store_id As [Store ID],
	st.store_name AS[Store Name]
from customers as c
Inner Join orders as o on c.customer_id=o.customer_id
Inner Join staffs as s on o.staff_id=s.staff_id
Inner Join stores as st on o.store_id = st.store_id


select * from staffs
select * from stores
select * from orders


select  t1.*,t2.* from Staffs as t1
Inner Join stores as t2 on t1.store_id=t2.customer_id

/*
-- Outer Join
-- Scenario: List of customers, both those who placed orders and those who did not. 
	For customers who did not place any orders, the Order ID will be NULL.
*/
--Outer Join
SELECT 
    c.customer_id AS [Customer ID],
    c.first_name + ' ' + c.last_name AS Customer,
    o.order_id AS [Order ID]
FROM customers AS c
LEFT JOIN orders AS o ON c.customer_id = o.customer_id;


--Right Join
SELECT 
    c.customer_id AS [Customer ID],
    c.first_name + ' ' + c.last_name AS Customer,
    o.order_id AS [Order ID]
FROM orders AS o
Right JOIN customers AS c  ON c.customer_id = o.customer_id;

--Full Outer Join

SELECT 
    c.customer_id AS [Customer ID],
    c.first_name + ' ' + c.last_name AS Customer,
    o.order_id AS [Order ID]
FROM orders AS o
FULL OUTER JOIN customers AS c  ON c.customer_id = o.customer_id;

--Self Join Joining Same table again (Achieving it with Left join)

select * from staffs

Select 
	emp.staff_id AS [Employee ID],
	emp.first_name+' '+emp.last_name AS [Employee],
	mgr.first_name+' '+mgr.first_name As [Manager]
From staffs AS emp
Left Outer Join staffs AS mgr On emp.manager_id=mgr.manager_id


--Self Join Joining Same table again (Achieving it with Right join)
Select 
	emp.staff_id AS [Employee ID],
	emp.first_name+' '+emp.last_name AS [Employee],
	mgr.first_name+' '+mgr.first_name As [Manager]
From staffs AS mgr
Right Outer Join staffs AS emp On emp.manager_id=mgr.manager_id


--Cross Join -- Cartision product
--1 records in first table is mapped to all records in second tab

select * from products
select * from brands

select * from products as p,brands 
where p.product_id=1 

--Task 1
create table Bikeproduct( PID Int,P_Name varchar(50));
insert into Bikeproduct(PID, P_Name)
VALUES
(1, 'Mountain Explorer'),
(2, 'Roadmaster X'),
(3, 'Speedster 3000'),
(4, 'Cruiser Deluxe'),
(5, 'Trailblazer Pro'),
(6, 'Turbo Racer'),
(7, 'Urban Glide'),
(8, 'Velocity 500'),
(9, 'Cyclone XT'),
(10, 'Enduro Elite');
Select * from Bikeproduct

create table Price(PID INt,P_Price money);
insert into Price(PID, P_Price)
VALUES
(2, 25000),
(4, 30000),
(7,25000),
(9,40000),
(11,50000)
select * from Price
--Inner Join
select  
	c.PID As [Product ID],
	c.P_Name As [Product Name],
	o.P_Price AS[Product Price]
from Bikeproduct as c
Inner Join Price as o on c.PID=o.PID

--Left Outer Join
select  
	c.PID As [Product ID],
	c.P_Name As [Product Name],
	o.P_Price AS[Product Price]
from Bikeproduct as c
Left Outer Join Price as o on c.PID=o.PID

--Right Outer Join
select  
	c.PID As [Product ID],
	c.P_Name As [Product Name],
	o.P_Price AS[Product Price]
from Bikeproduct as c
Right Outer Join Price as o on c.PID=o.PID

--Full Outer Join
SELECT 
   *
FROM Bikeproduct as c
FULL OUTER JOIN Price as o on c.PID=o.PID;


--create a duplicate table with existing table and same values
select * into Test_product from (select * from Bikeproduct) AS t1



--Task 2
/* 
Customer wise order value
output:Customer ID, Customer Name,Order ID, Order value
Tables :Customer,Orders,Order_items
*/
select * from customers
select * from orders;
select * from order_items;
select * from brands;
select * from products;

select 
	oi.order_id as [Order ID],
	c.first_name+' '+c.last_name As [Name],
	sum(oi.list_price * oi.quantity) As [order value]
from order_items as oi
Inner join orders as o ON oi.order_id=o.order_id
Inner join Customers as c ON o.customer_id=c.customer_id
group by oi.order_id ,
		c.first_name+' '+c.last_name
--Having sum(oi.list_price * oi.quantity) >10000
order by 1;

--Task 2
/* 
 BRAND WISE ORDER Vaalue
 outputL BRANDID,BRANDNAME,ORDERVALUE
*/
--SOLUTION 1
select * from order_items;
select * from brands;
select * from products;

select 
	b.brand_id as[Brand ID],
	b.brand_name as[Brand Name],
	sum(oi.list_price * oi.quantity) as [order Value]
from brands as b
left join Products AS p ON b.brand_id=p.brand_id
Inner join order_items AS oi ON p.Product_ID = oi.Product_ID 
Group by b.brand_id,
		b.brand_name
order by 3 desc ;

select * from brands
select * from order_items
select * from Products


--Day 3 20.12.2024
--Solution 2

Select 
	b.brand_ID AS [Brand ID]
	,b.brand_name AS [Brand NAme]
	,r2.[Order Value]
from Brands as b
Left join
(select 
	p.brand_id AS [Brand ID],
	sum(oi.list_price * oi.quantity) AS [Order Value]
from order_items as oi
Inner join Products AS P on oi.product_id=P.product_id
Group by p.brand_id) AS r2 on b.brand_ID = r2.[Brand ID]
Order By 3 DESC;




-- Task 3 year order value
-- output : Orderyear, Order Value
 
SELECT * FROM orders;
SELECT * FROM order_items;
 
SELECT 
    YEAR(o.order_date) AS [Order Year],

    SUM(oi.quantity * oi.list_price) AS [Order Value]
FROM orders AS o
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY YEAR(o.order_date)
ORDER BY [Order Year];
 
 SELECT
	 YEAR(o.order_date) AS [Order Year]
	,Format(o.order_date,'MMMMM') AS [Order month]
	,SUM(oi.quantity * oi.list_price) AS [Order Value]
FROM orders as o
INNER JOIN order_items AS oi ON o.order_id = oi.order_id
GROUP BY  YEAR(o.order_date), 
			FORMAT(o.order_date, 'MMMMM'),
			MONTH(o.order_date)
	
ORDER BY 1,MONTH(o.order_date);

--Format Returns text 
--Year,Month,Day returns as Integer 
/*
dd-Date
MM-Month
yyyy-Year
hh-Hour
mm-minutes
ss-seconds
*/

select Format(GETDATE(),'dd/MM/yyyy hh-mm-ss')

select 
	Year (GETDATE()) AS Year,
	Month (GETDATE()) AS Month,
	Day (GETDATE()) AS Day

--Identify the duplicates AND Delete ( Solution-1)

CREATE TABLE duplicate (
    PID INT,
    Pname VARCHAR(50)
);

INSERT INTO duplicate (PID, Pname)
VALUES
(1, 'Mountain Explorer'),
(2, 'Roadmaster X'),
(3, 'Speedster 3000'),
(4, 'Cruiser Deluxe'),
(5, 'Trailblazer Pro'),
(6, 'Turbo Racer'),
(7, 'Urban Glide'),
(8, 'Velocity 500'),
(9, 'Cyclone XT'),
(10, 'Enduro Elite'),
(1, 'Mountain Explorer'),  
(3, 'Speedster 3000'),     
(6, 'Turbo Racer'),        
(7, 'Urban Glide');      

select * from duplicate 

SELECT *, COUNT(*) AS DuplicateCount
FROM duplicate
GROUP BY PID, Pname
HAVING COUNT(*) > 1
Order by 2;

select * FROM duplicate
WHERE PID NOT IN (
    SELECT MIN(PID)
    FROM duplicate
    GROUP BY Pname
);

--NOT WORKINGGG



/*
--to copy structure another table (No data)
Select * into New_table_name from ( select * from Old_table_name)
Where 1=2;
*/

/* CTE - COMMON TABLE EXPRESSION OR TEMPORARY RESULT SET


WINDOWS FUNCTIONS -- ROW_NUMBER() -- function is part of window functions. It assigns a unique sequential 
									integer to rows within a partition of a result set, starting from 1 for the first row in each partition. 
						OVER() --   allowing you to perform calculations across a set of rows related to the current row, without having to aggregate
									the results (like with GROUP BY)
					PARTITION BY--   PARTITION BY clause is used in conjunction with window functions to divide the result set into groups or partitions
*/

--SOLUTION 2 
with cte_duplicates AS (
		SELECT PID,Pname, 
		-COUNT(*) AS DuplicateCount
		ROW_NUMBER() OVER (PARTITION BY Pname Order by Pname) AS Xrollnumber
		FROM duplicate)

delete from cte_duplicates
where Xrollnumber >1;

SELECT * 
FROM duplicate
ORDER BY PID ASC;   



--DENSE_RANK() - function is a window function in SQL that assigns a unique rank to each row within a partition 
				--of the result set, with no gaps between ranks. 

--To Find the second top price
with cte_secondduplicates2 AS (
		SELECT *,
		dense_rank() OVER (Order by list_price desc) AS DENSERANKXrollnumber
		from products
)
select * from  cte_secondduplicates2
where  DENSERANKXrollnumber=6


--To Find the third top price

with cte_duplicates2 AS (
		SELECT SELECT PRODUCT_ID AS product FROM
		from products
)
select * from  cte_duplicates2
where  DENSERANKXrollnumber=4

--TOP 10 customers by sales

select * from customers
select * from orders
select * from order_items

with cte_sales as(
	select
		 oi.order_id
		,sum(oi.list_price * oi.quantity) as sales
	from order_items as oi
	group by oi.order_id)
,cte_customerSales as (
select 
	 c.customer_id as [Customer ID]
	,c.first_name +' ' +c.last_name as customer
	,s.Sales as Sales
	,Dense_Rank() over(order by s.sales desc) as xDenseRank
 
from customers as c
inner join orders as o on c.customer_id = o.customer_id
inner join cte_sales as s on o.order_id = s.order_id)
 
select * from cte_customerSales
where xDenseRank <= 10;


 
 --BOTTOM 10 

with cte_sales as(
	select
		 oi.order_id
		,sum(oi.list_price * oi.quantity) as sales
	from order_items as oi
	group by oi.order_id)
,cte_customerSales as (
select 
	 c.customer_id as [Customer ID]
	,c.first_name +' ' +c.last_name as customer
	,s.Sales as Sales
	,Dense_Rank() over(order by s.sales asc) as xDenseRank
 
from customers as c
inner join orders as o on c.customer_id = o.customer_id
inner join cte_sales as s on o.order_id = s.order_id)
 
select * from cte_customerSales
where xDenseRank <= 10;


 -- Compare current sales with previous sales and next month sales 

 --lag()-function is used to access data from a previous row in the same result set.
 --lead()-function is used to access data from a next row in the same result set.


with cte_yearsales as(
select 
 year(o.order_date) as [year]
,format(o.order_date,'MMM') as [month]
,sum(oi.list_price * oi.quantity) as [order values]
,LAG(sum(oi.list_price * oi.quantity) ) over (order by year(o.order_date),MONTH(o.order_date) asc) as previous_sales
,LEAD(sum(oi.list_price * oi.quantity) ) over (order by year(o.order_date),MONTH(o.order_date) asc) as next_sales
from orders as o
inner join order_items as oi
on o.order_id = oi.order_id
group by year(o.order_date),format(o.order_date,'MMM'), MONTH(o.order_date)
)
select * from cte_yearsales
 

 --CAST()- function is used to convert one data type to another.

 Create table Trans(
		id int,
		amount money,
		trans_date DATETIME);

insert into Trans(id,amount,trans_date)
values
(1,1000,'2024-03-11 10:30:45'),
(2,2000,'2024-03-11 11:00:00'),
(3,500,'2024-03-11 12:15:10'),
(4,1500,'2024-03-12 12:20:15'),
(5,5400,'2024-03-12 13:00:00'),
(6,3500,'2024-03-12 14:25:40'),
(7,1750,CURRENT_TIMESTAMP),
(8,890,'2024-03-21 16:30:00'),
(9,725,'2024-03-21 13:38:45'),
(10,1040,'2024-03-22 12:15:08'),
(11,500,'2024-03-22 14:05:10'),
(12,2600,'2024-03-22 14:05:20');

select * from Trans
order  by  trans_date desc

 SELECT distinct
	FIRST_VALUE(id) OVER (PARTITION BY CAST(trans_date AS DATE) ORDER BY trans_date desc) AS ID	,
    FIRST_VALUE(trans_date) OVER (PARTITION BY CAST(trans_date AS DATE) ORDER BY trans_date desc) AS FirstTransDate,
	FIRST_VALUE(amount) OVER (PARTITION BY CAST(trans_date AS DATE) ORDER BY trans_date desc) AS Amount
   FROM Trans

 --DAY 4 (21/12/2024)
  /* 
Arithmetic Operators    +,-,*,%,/

Comparison Operators    =,!=,<>,>,<,>=,<=,Between,Not Between (Also include lower value and Higher Value and Same for Between and Not Between
							 and also we can't the interchange the lower value and Higher Value)

Logical Operators		AND, OR, NOT

Like Operators          LIKE ,NOT LIKE (To check Pattern) Eg: Company_name Like 'A%' (It will show all company name starting with letter A)

NULL Operators			NULL, NOT NULL (NULL - Doesn't Occupy any memory or Unknown Value)
						cannot compare null Like this ='NULL',!='NULL' Instead of using that use IS NULL or IS NOT NULL

IN,NOT IN Operators     IN,NOT IN (to Compare multiple Values instead of using id=1 or id =2 use IN(1,2)


Keyword in MYSQL        Distinct, Top


DROP -- USED TO DELETE DATABASE OBJECT LIKE SP,TABLES,FUNCTION 

SET OPERATORS(Used to Combine More than one record set into single record set)   UNION UNION ALL, INTERESCT, EXCEPT
should contain same datatype and same  no of columns
			 Order by clause should be at the last

Union -----  Combines Records and Elimate duplicates
Union all ----- Combines records
Intersect ----- Retrives only common records between record sets
Except ------ recordset A delta Recordset B

*/

--WITHOUT USING UNION
SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
SELECT 101 AS CID, 'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
SELECT 102 AS CID, 'Priya' AS Customer, '908034568' AS Phone, 'Hyderabad' AS City
SELECT 103 AS CID, 'Suresh' AS Customer, '908034569' AS Phone, 'Mumbai' AS City
SELECT 104 AS CID, 'Anjali' AS Customer, '908034570' AS Phone, 'Delhi' AS City,

--USING UNION AND ORDER BY
SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
Union
SELECT 101 AS CID, 'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
Union
SELECT 102 AS CID, 'Priya' AS Customer, '908034568' AS Phone, 'Hyderabad' AS City
Union
SELECT 103 AS CID, 'Suresh' AS Customer, '908034569' AS Phone, 'Mumbai' AS City
Union
SELECT 104 AS CID, 'Anjali' AS Customer, '908034570' AS Phone, 'Delhi' AS City
Order by CID desc;

--USING UNION AND ORDER BY (Adding Duplicates Row)
SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
Union
SELECT 101 AS CID, 'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
Union
SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
Union
SELECT 103 AS CID, 'Suresh' AS Customer, '908034569' AS Phone, 'Mumbai' AS City
Union
SELECT 104 AS CID, 'Anjali' AS Customer, '908034570' AS Phone, 'Delhi' AS City
Order by CID desc;

--USING UNION ALL AND ORDER BY (Adding Duplicates Row)
SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
Union all
SELECT 101 AS CID, 'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
Union all
SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
Union all
SELECT 103 AS CID, 'Suresh' AS Customer, '908034569' AS Phone, 'Mumbai' AS City
Union all
SELECT 104 AS CID, 'Anjali' AS Customer, '908034570' AS Phone, 'Delhi' AS City
Order by CID desc;

---USing Union ALl and order BY
SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
Union all
SELECT 101 AS CID, 'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
Union all
SELECT 102 AS CID, 'Priya' AS Customer, '908034568' AS Phone, 'Hyderabad' AS City
Union all
SELECT 103 AS CID, 'Suresh' AS Customer, '908034569' AS Phone, 'Mumbai' AS City
Union all
SELECT 104 AS CID, 'Anjali' AS Customer, '908034570' AS Phone, 'Delhi' AS City
Order by CID desc;

---Using Intersect and order BY

SELECT 101 AS CID,'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
intersect(
	SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
	Union
	SELECT 101 AS CID, 'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
	Union
	SELECT 102 AS CID, 'Priya' AS Customer, '908034568' AS Phone, 'Hyderabad' AS City
	Union
	SELECT 103 AS CID, 'Suresh' AS Customer, '908034569' AS Phone, 'Mumbai' AS City
	Union
	SELECT 104 AS CID, 'Anjali' AS Customer, '908034570' AS Phone, 'Delhi' AS City
	)
	Order by CID desc;

--Using Expect and order BY
(
	SELECT 100 AS CID, 'Babu' AS Customer, '908034566' AS Phone, 'Chennai' AS City
	Union
	SELECT 101 AS CID, 'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
	Union
	SELECT 102 AS CID, 'Priya' AS Customer, '908034568' AS Phone, 'Hyderabad' AS City
	Union
	SELECT 103 AS CID, 'Suresh' AS Customer, '908034569' AS Phone, 'Mumbai' AS City
	Union
	SELECT 104 AS CID, 'Anjali' AS Customer, '908034570' AS Phone, 'Delhi' AS City
)
except
SELECT 101 AS CID,'Ravi' AS Customer, '908034567' AS Phone, 'Bangalore' AS City
Order by CID desc;

/* 
VIEWS - VIRTUAL TABLE

TO create a view

Create or Alter view (view_name)
AS(........)

*/

--Write a query to retrieve the product details including the product ID, product name, model year,
--list price, brand name, and category name for all products in the VW_ProductBrandCategories view."

select * from products
select * from categories
select * from brands

CREATE OR ALTER VIEW VW_ProductBrandCategories AS
SELECT 
    p.product_id AS [PRODUCT ID],
    p.product_name AS [PRODUCT NAME],
    p.model_year AS [MODEL YEAR],
    p.list_price AS [LIST PRICE],
	b.brand_id As [Brand ID],
    b.brand_name AS Brand,
    p.category_id AS [Category ID],
    c.category_name AS Category
FROM products AS p
LEFT OUTER JOIN brands AS b ON p.brand_id = b.brand_id
LEFT OUTER JOIN categories AS c ON p.category_id = c.category_id;

select 
	[PRODUCT ID],
	[PRODUCT NAME],
	[MODEL YEAR],
	[LIST PRICE],
	Brand,
	Category
from VW_ProductBrandCategories
order by Category
 
 --Retrive top 10 and last 10 list of product's with their CAtegory Name and brandName Based on listprice
 --Tables:Products,Brands,Categories
 select * from products
 --TOP 10 products
 Create or alter view vw_TopProductss
 as
 select
    p.product_id AS [PRODUCT ID],
    p.product_name AS [PRODUCT NAME],
    p.model_year AS [MODEL YEAR],
    p.list_price AS [LIST PRICE],
	b.brand_id As [Brand ID],
    b.brand_name AS Brand,
    p.category_id AS [Category ID],
    c.category_name AS Category,
	DENSE_RANK() Over (order by p.list_price desc) AS XDenseRank 
FROM products AS p
LEFT OUTER JOIN brands AS b ON p.brand_id = b.brand_id
LEFT OUTER JOIN categories AS c ON p.category_id = c.category_id;

select * from vw_TopProductss
where XDenseRank<=10

--Bottom 10
 Create or alter view vw_BottomProductss
 as
 select
    p.product_id AS [PRODUCT ID],
    p.product_name AS [PRODUCT NAME],
    p.model_year AS [MODEL YEAR],
    p.list_price AS [LIST PRICE],
	b.brand_id As [Brand ID],
    b.brand_name AS Brand,
    p.category_id AS [Category ID],
    c.category_name AS Category,
	DENSE_RANK() Over (order by p.list_price asc) AS XDenseRank 
FROM products AS p
LEFT OUTER JOIN brands AS b ON p.brand_id = b.brand_id
LEFT OUTER JOIN categories AS c ON p.category_id = c.category_id;

select * from vw_BottomProductss
where XDenseRank<=10


--Product performance 2016
select * from order_items
select * from products

create or alter view vw_performance
as
select 
		p.product_id As [Product ID],
		p.product_name as [Product Name],
		sum(oi.list_price*oi.quantity) AS [Total],
		p.model_year as [Model year]

from order_items as oi 
Right Outer Join  products as p on oi.product_id=p.product_id 
group by p.product_id,
		 p.product_name,
		 p.model_year,
		 oi.order_id

with cte_top5 as(
select 
	[Product ID],
	[Product Name],
	sum([Total])as [Order value],
	DENSE_RANK() over(order by sum([Total]) desc) as xrank
from vw_performance
where [Model year] =2016
group by  [Product ID],
		  [Product Name])

select * from cte_top5
where xrank <=5

/*
	T-SQL - Transact SQl
	Stored Procedure - SP
	Advantanges :
		---> Code reusabilty
		---> Automation
		---> Precompiled ( We can save Complie time using Sp)
		---> DML (insert,Update,Delete)
*/

-- STORED PROCEDURE BASIC
Create or alter Procedure sp_view_customer
as 
begin 
	Select * from customers
end
exec sp_view_customer


--Parameters User defined Varibles
--@- Local varibles
--@@-System Defined Varibles

DECLARE @FirstName as Varchar(100)
set @FirstName='Sethumadhavan'
print 'First Name:' + @FirstName
select @FirstName as [Firstname]

--Task Assign two integer and add two values

DECLARE @FirstNum as int,
		@SecondNum as int,
		@result as int
set @FirstNum=5
set @SecondNum=5
set @result=@FirstNum+@SecondNum
print 'Result:' + cast(@result as varchar)
select @result as result

--Task Assign two integer and Sub two values

DECLARE @FirstNum as int,
		@SecondNum as int,
		@result as int
set @FirstNum=5
set @SecondNum=5
set @result=@FirstNum-@SecondNum
print 'Result:' + cast(@result as varchar)
select @result as result


--Task Assign two integer and multiple two values

DECLARE @FirstNum as int,
		@SecondNum as int,
		@result as int
set @FirstNum=5
set @SecondNum=5
set @result=@FirstNum*@SecondNum
print 'Result:' + cast(@result as varchar)
select @result as result

--Task Assign two integer and divide two values

DECLARE @FirstNum as int,
		@SecondNum as int,
		@result as int
set @FirstNum=5
set @SecondNum=5
set @result=@FirstNum/@SecondNum
print 'Result:' + cast(@result as varchar)
select @result as result

--Task Assign two integer and Modulas two values

DECLARE @FirstNum as int,
		@SecondNum as int,
		@result as int
set @FirstNum=5
set @SecondNum=5
set @result=@FirstNum%@SecondNum
print 'Result:' + cast(@result as varchar)
select @result as result





exec sp_help customers
--Insert Values into customers table using stored Procedure

Create or alter PROCEDURE INSERT_VALUES_CUSTOMERS(
		@FNAME AS VARCHAR(100),
		@LNAME AS VARCHAR(100),
		@PHONE AS VARCHAR(50) = NULL,
		@EMAIL AS VARCHAR(100)
)
AS 
BEGIN
	BEGIN TRY
	Insert into customers(first_name,last_name,phone,email) 
	Select @FNAME,@LNAME,@PHONE,@EMAIL
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	print 'New Customer: '+ cast(SCOPE_IDENTITY() as Varchar(50))
	END TRY

	BEGIN CATCH
		Select 'Error Occured during Insert'
	END CATCH
END;
	


DECLARE @FNAME AS VARCHAR(100) ='sri',
		@LNAME AS VARCHAR(100)='selvaraj',
		@PHONE AS VARCHAR(50) = '908080000',
		@EMAIL AS VARCHAR(100)='sri'

EXEC INSERT_VALUES_CUSTOMERS @FNAME,@LNAME,@PHONE,@EMAIL

select * from customers order by 1 desc 

--Insert valuues into products using stored procedure (In single Procedure)

Create or alter procedure INSERT_INTO_BRANDS(
		@BRANDNAME AS VARCHAR(100),
		@CATEGORYNAME AS VARCHAR(100),
		@PRODUCTNAME AS VARCHAR(100),
		@MODELYEAR AS Smallint,
		@LISTPRICE AS DECIMAL(9,2)
)
AS 
BEGIN
		Declare @Brandresult AS Varchar(50)='NULL',
				@Categoryresult AS VARCHAR(50)='NULL'

	BEGIN TRY

	Insert into brands(brand_name) 
	Select @BRANDNAME
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	set @Brandresult=SCOPE_IDENTITY()
	print 'New Brand: '+ cast(@Brandresult as Varchar(50))

	insert into categories(category_name)
	select @CATEGORYNAME
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	set @Categoryresult=SCOPE_IDENTITY()
	print 'New Category: '+ cast(@Categoryresult as Varchar(50))

	insert into products(product_name,brand_id,category_id,model_year,list_price)
	select @PRODUCTNAME,@Brandresult,@Categoryresult,@MODELYEAR,@LISTPRICE
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	print 'New Product: '+ cast(SCOPE_IDENTITY() as Varchar(50))

	END TRY

	BEGIN CATCH
		Select 'Error Occured during Insert'
	END CATCH
END;

DECLARE	@BRANDNAME AS VARCHAR(100)='APSARA',
		@CATEGORYNAME AS VARCHAR(100)='PENCIL',
		@PRODUCTNAME AS VARCHAR(100)='APSARA PENCIL',
		@MODELYEAR AS Smallint=2017,
		@LISTPRICE AS DECIMAL(9,2)=20000

EXEC INSERT_INTO_BRANDS @BRANDNAME,@CATEGORYNAME,@PRODUCTNAME,@MODELYEAR,@LISTPRICE

select * from products order by 1 desc





--Insert valuues into products using stored procedure (Using Multiple Procedure)


--STORED PROCEDURE TO INSERT VALUES IN BRANDS
Create or alter procedure INSERTBRANDS(
		@BRANDNAME AS VARCHAR(100),
		@YBRANDID AS INT OUT
)
AS 
BEGIN
	
	BEGIN TRY

	Insert into brands(brand_name) 
	Select @BRANDNAME
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	set @YBRANDID=SCOPE_IDENTITY()
	print 'New Brand: '+ cast( @YBRANDID as Varchar(50))

	END TRY

	BEGIN CATCH
		Select 'Error Occured during Insert into Brand'
	END CATCH
END;


DECLARE @BID AS INT
exec INSERTBRANDS ' YAHAMA',@YBRANDID=@BID OUT
PRINT @BID

SELECT * FROM brands
SELECT * FROM categories


--STORED PROCEDURE TO INSERT VALUES IN CATEGORIES
Create or alter procedure INSERTCATEGORIES(
		@CATEGORYNAME AS VARCHAR(100),
		@YCATEGORYID AS INT OUT
)
AS 
BEGIN
	
	BEGIN TRY

	Insert into categories(category_name) 
	Select @CATEGORYNAME
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	set @YCATEGORYID=SCOPE_IDENTITY()
	print 'New Category: '+ cast( @YCATEGORYID as Varchar(50))

	END TRY

	BEGIN CATCH
		Select 'Error Occured during Insert into Brand'
	END CATCH
END;

DECLARE @CID AS INT
exec INSERTCATEGORIES 'ELECTRONICS',@YCATEGORYID=@CID OUT
PRINT @CID

--STORED PROCEDURE TO INSERT VALUES IN PRODUCTS

Create or alter procedure INSERTPRODUCTS(
	@BRAND_NAME AS VARCHAR(50),
	@CATEGORY_NAME AS VARCHAR(50),
	@PRODUCTNAME AS VARCHAR(100),
	@MODELYEAR AS Smallint,
	@LISTPRICE AS DECIMAL(9,2)

)
AS 
BEGIN
	declare @BID as int,
			@CID as int
			
	BEGIN TRY
	exec INSERTBRANDS @BRAND_NAME,@YBRANDID=@BID OUT
	exec INSERTCATEGORIES @CATEGORY_NAME,@YCATEGORYID=@CID OUT


	insert into products(product_name,brand_id,category_id,model_year,list_price)
	select @PRODUCTNAME,@BID,@CID,@MODELYEAR,@LISTPRICE
	PRINT cast(@@ROWCOUNT AS Varchar(50))+'Rows are affected'
	print 'New Product: '+ cast(SCOPE_IDENTITY() as Varchar(50))

	END TRY

	BEGIN CATCH
		Select 'Error Occured during Insert into Brand'
	END CATCH
END;



exec INSERTPRODUCTS 'APACHE','BIKE','Two wheeler',2018,290000;

select * from brands order by 1 desc;
select * from categories order by 1 desc;
select * from products order by 1 desc;


/*
--02.01.2024

Trigger - Special kind of Stored procedure
		  only Fires or executed during  DML(Insert,Delete,Update) command

*/


CREATE TABLE Students(
		StudentID TINYINT
		,S_Name VARCHAR (100) NOT NULL
		,Mobile CHAR(10) UNIQUE
		,Gender CHAR CHECK(Gender IN('M','F'))
		,City  VARCHAR(100) NOT NULL
		,Created DATETIME DEFAULT GETDATE()
		,Updated DATETIME
		,CONSTRAINT pk_StudentID PRIMARY KEY(StudentID)

);
 
INSERT INTO Students(StudentID,S_Name,Mobile,City,Gender)

SELECT 1,'Jagan','9638152741','Chennai','M'
UNION
SELECT 2,'Vidhya','8521456789','Bangalore','F'
UNION
SELECT 3,'Naren','8794562136','Mumbai','M'
UNION
SELECT 4,'Geetha','6549871237','Delhi','F';
SELECT * FROM Students


--- Copying Structure of Table without record values

SELECT * INTO ADT_Students FROM Students
WHERE 1=2

SELECT * FROM ADT_Students
 
---Adding Column 'operation'(Upd,Del,Ins)
 
ALTER TABLE ADT_Students
ADD Operation CHAR(3);
 
 
ALTER TABLE ADT_Students
ADD adt_Created DATETIME DEFAULT GETDATE()
		,adt_Updated DATETIME
 
 --Creating the trigger for 'AFTER DELETE	' on 'students' (It will insert values into ADT_Students after you delete any records from Students)

CREATE TRIGGER Trg_Students
ON Students 
AFTER DELETE 
AS 
BEGIN

		INSERT INTO ADT_Students
					(StudentID,S_Name,Mobile,City,Gender,Created,Operation)
		SELECT

			  d.StudentID
			  ,d.S_Name
			  ,d.Mobile
			  ,d.City
			  ,d.Gender
			  ,d.Created
			  ,'Del'
			FROM DELETED AS d
END;
 
DELETE FROM Students
WHERE StudentID=3

------ Creating the trigger for 'AFTER UPDATE' on 'students' (It will insert values into ADT_Students after you UPDATE any records from Students)

CREATE TRIGGER UPD_Students
ON Students 
AFTER Update
AS 
BEGIN

		INSERT INTO ADT_Students
					(StudentID,S_Name,Mobile,City,Gender,Created,Operation)
		SELECT

			  d.StudentID
			  ,d.S_Name
			  ,d.Mobile
			  ,d.City
			  ,d.Gender
			  ,d.Created
			  ,'UPD'
			FROM DELETED AS d
END;
 
update students 
SET S_Name='Sethu'
where StudentID=1
 
 ----Creating the trigger for 'AFTER INSERT' on 'students'  (It will insert values into ADT_Students after you UPDATE any records from Students)

CREATE TRIGGER INS_Students
ON Students 
AFTER INSERT 
AS 
BEGIN

		INSERT INTO ADT_Students
					(StudentID,S_Name,Mobile,City,Gender,Created,Operation)
		SELECT

			  d.StudentID
			  ,d.S_Name
			  ,d.Mobile
			  ,d.City
			  ,d.Gender
			  ,d.Created
			  ,'INS'
			FROM inserted AS d
END;

 
INSERT INTO Students(StudentID,S_Name,Mobile,City,Gender)
SELECT 6,'JESSI','54887848','Chennai','F'




=---------
 

CREATE or alter TRIGGER ALL_Students
ON Students 
AFTER Update,Insert,delete
AS 
BEGIN

		INSERT INTO ADT_Students
					(StudentID,S_Name,Mobile,City,Gender,Created,Operation)
		SELECT

			  d.StudentID
			  ,d.S_Name
			  ,d.Mobile
			  ,d.City
			  ,d.Gender
			  ,d.Created
			  ,'DEL'
			FROM DELETED AS d
UNION 
		SELECT
			   c.StudentID
			  ,c.S_Name
			  ,c.Mobile
			  ,c.City
			  ,c.Gender
			  ,c.Created
			  ,'UPD'
			FROM DELETED AS c
UNION 
		SELECT

			  i.StudentID
			  ,i.S_Name
			  ,i.Mobile
			  ,i.City
			  ,i.Gender
			  ,i.Created
			  ,'INS'
			FROM inserted As i	
END;
 

update students  
SET S_Name='SUDHAN'
where StudentID=7
 
 delete from Students
 where StudentID=6

select * from Students
select * from ADT_Students

CREATE OR ALTER TRIGGER trg_Ins_Upd_del_Students
ON students
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
	INSERT INTO ADT_Students(StudentID, S_Name, Mobile, City, Gender, Created, Operation)
	SELECT 
		 isnull(d.StudentID,i.StudentID) as StudentID
		,isnull(d.s_name,i.s_name) as StudentName
		,isnull(d.mobile,i.mobile) as mobile
		,isnull(d.city,i.city) as city
		,isnull(d.Gender,i.gender) as gender
		,isnull(d.Created,i.created) as created
		,case when d.StudentId is null then 'Ins'
		when i.StudentID is null then 'Del'
		when i.StudentId=d.StudentID then 'Upd'
		end as Operations
		from inserted as i
		full outer join deleted as d
		on i.StudentId=d.StudentID
end;
 
select isnull('ABC','ABC');
select isnull('ABC','abc');
select isnull('ABC','XYZ');
select isnull('ABC',NULL);
select isnull(NULL,'ABC');
select isnull(NULL,NULL);


-----CREATE A INSERT,UPDATE,DELETE TRIGGER FOR CUSTOMERS TABLE

SELECT * FROM customers order by 1 desc

create table ADT_Customers(customer_id int,first_name varchar(50),last_name varchar(50),phone varchar(50),email varchar(50)
							,street varchar(50)
							,city varchar(50)
							,state varchar(50)
							,zip_code varchar(50)
							,Operation varchar(50))


select * from ADT_Customers

CREATE OR ALTER TRIGGER THREE_TRIGGERS_CUSTOMERS
ON customers
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
	INSERT INTO ADT_Customers(customer_id,first_name,last_name,phone,email,street,city,state,zip_code,Operation)
	SELECT 
		 isnull(d.customer_id,i.customer_id) as [Customer ID]
		,isnull(d.first_name,i.first_name) as [First Name]
		,isnull(d.last_name,i.last_name) as [Last Name]
		,isnull(d.phone,i.phone) as Phone
		,isnull(d.email,i.email) as email
		,isnull(d.street,i.street) as street
		,isnull(d.city,i.city) as city
		,isnull(d.state,i.state) as state
		,isnull(d.zip_code,i.zip_code) as zip_code
		,case when d.customer_id is null then 'Ins'
		when i.customer_id is null then 'Del'
		when i.customer_id=d.customer_id then 'Upd'
		end as Operations
		from inserted as i
		full outer join deleted as d
		on i.customer_id=d.customer_id
	SET IDENTITY_INSERT customers ON; 
end;

exec sp_help customers

SET IDENTITY_INSERT customers ON;

INSERT INTO customers(customer_id, first_name, last_name, phone, email, street, city, state, zip_code)
VALUES (1452, 'John', 'Doe', '555-1234', 'johndoe@example.com', '123 Elm St', 'Somewhere', 'CA', '90210');

SET IDENTITY_INSERT customers OFF; 

select * from ADT_Customers

-----CREATE A INSERT,UPDATE,DELETE TRIGGER FOR Product TABLE
create table ADT_Products(product_id int,
							product_name varchar(50),
							brand_id int,
							category_id int,
							model_year varchar(50),
							list_price decimal(10,2),
						    Operation Varchar(50))
 
 
CREATE OR ALTER TRIGGER Products_table
ON products
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
	INSERT INTO ADT_Products(product_id,product_name, brand_id, category_id, model_year,list_price,Operation)
	SELECT 
		 isnull(d.product_id,i.product_id) as product_id
		,isnull(d.product_name,i.product_name) as product_name
		,isnull(d.brand_id,i.brand_id) as brand_id
		,isnull(d.category_id,i.category_id) as category_id
		,isnull(d.model_year,i.model_year) as model_year
		,isnull(d.list_price,i.list_price) as list_price
		,case when d.product_id is null then 'Ins'
		when i.product_id is null then 'Del'
		when i.product_id=d.product_id then 'Upd'
		end as Operations
		from inserted as i
		full outer join deleted as d
		on i.product_id=d.product_id
end;
SET IDENTITY_INSERT products ON;

insert into products (product_id,product_name, brand_id, category_id, model_year,list_price)
select 324,'Makeup',3,4,2019,100000
select * from products order by 1 desc

select * from ADT_Products
 
 select * from ADT_Customers

-----CREATE A INSERT,UPDATE,DELETE TRIGGER FOR BRAND TABLE
select * from brands order by 1 desc


Create table ADT_Brands(brand_id int,
						brand_name varchar(50),
						Operation varchar(50))
 
CREATE OR ALTER TRIGGER Brands_table
ON brands
AFTER DELETE, UPDATE, INSERT
AS
BEGIN
	INSERT INTO ADT_Brands(brand_id,brand_name,Operation)
	SELECT 
		 isnull(d.brand_id,i.brand_id) as brand_id
		,isnull(d.brand_name,i.brand_name) as brand_name
		,case when d.brand_id is null then 'Ins'
		when i.brand_id is null then 'Del'
		when i.brand_id=d.brand_id then 'Upd'
		end as Operations
		from inserted as i
		full outer join deleted as d
		on i.brand_id=d.brand_id
end;


set IDENTITY_INSERT brands off
set IDENTITY_INSERT brands on

INSERT INTO brands(brand_id,brand_name)
SELECT 16,'Electronics'

set IDENTITY_INSERT brands off

select * from brands order by 1 desc

select * from ADT_Brands

 

 ----EXPRESSIONS --CASE
create table emp(
		emp_id int primary key
		,First_Name varchar(50) not null
		,Last_Name varchar(50) not null
		,Hire_Date date not null
		,Email_id varchar(50)
		,Phone_No varchar(50)
		,Job_Id varchar(50)
		,Salary DECIMAL(7,2)
		);
 
insert into emp (emp_id, First_Name,Last_Name,Hire_Date,Email_id,Job_Id,Salary) values
(100,'steven', 'king','1987-06-17','steven.king@gmail.com','AD_Pres',90000.00),
(101,'N', 'kochar','1989-09-21','n.kochar@gmail.com','AD_VP',17000.00),
(102,'Lex', 'DeHaan','1993-01-13','Lex.DeHaan@gmail.com','AD_VP',25000.00),
(103,'Alexender', 'Hunold','1990-01-03','Alexender.Hunold@gmail.com','IT_PROG',9000.00),
(104,'Bruce', 'Ernst','1991-05-21','Bruce.Ernst@gmail.com','IT_PROG',6000.00),
(105,'David', 'Austin','1997-06-25','David.Austin@gmail.com','IT_PROG',4800.00);
 
select * from emp
 
alter table emp add Gender char;
 
select * from emp where emp_id in(100,101,102,103,104,105)
 
-- simple case expression
 
select *,
case Job_Id
	when 'AD_Pres' then (salary * 0.1) + salary
	when 'IT_PROG' then (salary * 0.2) + salary
	else salary
end as Revised_salary
from emp;
 
-- searched case expression
 
select *,
case 
	when Job_Id = 'AD_Pres' then (salary * 0.1) + salary
	when emp_id = 104 then (salary * 0.2) + salary
	else salary
end as Revised_salary
from emp;
 

 --03.01.2025

 /*
	Order Status
	1 - Inprogress
	2 - Pending
	3 - Completed
	3 - Delivered	
*/

select distinct
	order_status,
	count(Order_status) As TOTAL,
	case order_status
	when 1 then 'Inprogress'
	when 2 then 'Pending'
	when 3 then 'Completed'
	when 4 then 'Delivered'
	END AS ORDERSTATUS
from orders
group by order_status
order by 1 asc

 ---------------OR---------------

select distinct
	o.order_status,
	case order_status
		 when 1 then 'IN Progress'
		 when 2 then 'Pending'
		 when 3 then 'Completed'
		 when 4 then 'Delivered'
	end as order_status,
	count(*) over(partition by order_status order by o.order_status) as [Number of order_status]
from orders as o




--Order Status & Order Value (After Discount)
--OUTPUT: Order no,Order Status,Total amount,Discount Amount,Order value


 select * from orders
 select * from order_items

WITH cte_OrderStatusValue AS (
    SELECT oi.order_id AS [ORDER ID],
           CASE o.order_status
               WHEN 1 THEN 'IN Progress'
               WHEN 2 THEN 'Pending'
               WHEN 3 THEN 'Completed'
               WHEN 4 THEN 'Delivered'
           END AS [Order Status],
		   o.order_status AS [STATUS] ,
           SUM(oi.list_price * oi.quantity) AS [Total Amount],
           SUM(oi.list_price * oi.quantity * oi.discount) AS [Discount Amount]
    FROM order_items AS oi
    INNER JOIN orders AS o 
        ON oi.order_id = o.order_id
    GROUP BY oi.order_id, o.order_status
)

SELECT		
    [Order Status],  
    SUM([Total Amount] - [Discount Amount]) AS [After Discount]
FROM cte_OrderStatusValue
GROUP BY  [Order Status]
order by 1

--COALESCE
select coalesce(null,null,'Java','SQL','Python') AS Course
select * from customers where phone is null;

--if the first value is null it will take second value
select first_name,phone,coalesce(phone,'n/a') As Phone_1 from customers

/*
--FUNCTIONS

	1.Must return a value
	2.Can be used inside the stored procedure and also select
	3.Stored procedures Cannot be used inside the functions 
	4.Stored procedures cannot be used in select statement

Types of functions
1.Pre Defined Functions -SUM(),min(),max()
2.User defined Functions

Types of User defined functions
1.Scalar - return only one value       
2.Tabluar-Return in table format
*/

--calculate the age of a person based on their date of birth.

Create or alter Function UDF_AGE(@dob AS DATE)
returns int
as 
Begin
	Declare @iAge as INT
	set @iAge =DATEDIFF(DD,@dob,GETDATE())
	return @iAge
end;

SELECT dbo.UDF_AGE('2002-01-03');
SELECT * FROM customers

-- ADD firstname and lastname using function
--Trim function is used to reduce spaces at the LEFT SIDE and RIGHT SIDE of the string
Create or alter Function UDF_NAME(@FIRSTNAME AS VARCHAR(50),@LASTNAME AS VARCHAR(50))
returns VARCHAR(50)
as 
Begin
	Declare @NAME as VARCHAR(50)
	set @NAME = TRIM(@FIRSTNAME)+' '+TRIM(@LASTNAME)
	return @NAME
end; 

 

select *, 
	   dbo.UDF_NAME(first_name,last_name) AS FULLNAME
	   from customers


SELECT LEN(TRIM('HELLO WORLD')), LEN('HELLO WORLD');

-- ADD firstname and lastname and give it as random domain name ID using function 
Create or alter Function UDF_EMAIL(
@ID AS int,
@FIRSTNAME AS VARCHAR(50),
@LASTNAME AS VARCHAR(50))
returns VARCHAR(100)
as 
Begin
	Declare @NAME as VARCHAR(100)
	Declare @RANDOM_DOMAIN as VARCHAR(50)
	 SET @RANDOM_DOMAIN = 
        CASE 
            WHEN @ID % 4 = 0 THEN '@gmail.com'
            WHEN @ID % 4 = 1 THEN '@yahoo.com'
            WHEN @ID % 4 = 2 THEN '@outlook.com'
            ELSE 'hotmail.com'
        END;
	set @NAME = lower(TRIM(@FIRSTNAME)+TRIM(@LASTNAME))+@RANDOM_DOMAIN
	return @NAME
end;

select *, 
	   dbo.UDF_EMAIL(customer_id,first_name,last_name) AS Gmail
	   from customers


select * from customers

--seperate first name and domain name
DECLARE @email AS VARCHAR(100)
SET @email = 'SAVIOR.RITHICK@GMAIL.com';

SELECT 
    LEFT(@email, CHARINDEX('.', @email) - 1) AS FirstPart,
    SUBSTRING(@email, CHARINDEX('.', @email) + 1, CHARINDEX('@', @email) - CHARINDEX('.', @email)-1) AS SecondPart,
    RIGHT(@email, LEN(@email) - CHARINDEX('@', @email)) AS Domain


--TABLE VARIABLE

DECLARE @FULLNAME AS TABLE(fNAME VARCHAR(50),LNAME VARCHAR(50))

Insert into @FULLNAME
Select 'Sethu','Madhavan'

select * from @FULLNAME

CREATE OR ALTER FUNCTION UDF_SEPEMAIL (
    @email AS VARCHAR(50)
)
RETURNS @FirstLastDomain TABLE (
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    domain VARCHAR(50)
)
AS
BEGIN
    DECLARE 
        @lenemail AS INT,
        @pos1 AS INT,   
        @pos2 AS INT,   
        @f_Name AS VARCHAR(100),
        @l_Name AS VARCHAR(100),
        @domain AS VARCHAR(100)
    SET @lenemail = LEN(@email)
    SET @pos1 = CHARINDEX('.', @email)
    SET @pos2 = CHARINDEX('@', @email)   
    SET @f_Name = LEFT(@email, @pos1 - 1)
    SET @l_Name = SUBSTRING(@email, @pos1 + 1, @pos2 - @pos1 - 1);
	SET @domain = SUBSTRING(@email, @pos2 + 1, @lenemail - @pos2)
    INSERT INTO @FirstLastDomain (firstname, lastname, domain)
    VALUES (@f_Name, @l_Name, @domain);
    RETURN
END

DECLARE @email AS VARCHAR(100)
SET @email = 'SAVIOR.RITHICK@GMAIL.com';
select * from dbo.UDF_SEPEMAIL(@email)

select * from customers
order by 1 desc 


/*
CROSS APPLY is useful when you need to join a row from a table with a result set produced by a table-valued function, 
which can return a varying number of rows. It allows you to dynamically apply the function to each row of your main 
table and extract the values.
*/

SELECT c.email,t.firstname,t.lastname,t.domain FROM customers as c
CROSS APPLY dbo.UDF_SEPEMAIL(email) as t



DECLARE @COURSE AS VARCHAR(100)
set @COURSE='JAVA,Python,C#,SQL'
SELECT value
FROM STRING_SPLIT('JAVA,Python,C#,SQL', ',');



CREATE OR ALTER FUNCTION UDF_DELIMITER (
    @STRING AS VARCHAR(100),
	@DELIMTER AS VARCHAR(1)
)
RETURNS @FirstLastDomain TABLE (
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    domain VARCHAR(50)
)
AS
BEGIN
    DECLARE 
        @lenemail AS INT,
        @pos1 AS INT,   
        @pos2 AS INT,   
        @f_Name AS VARCHAR(100),
        @l_Name AS VARCHAR(100),
        @domain AS VARCHAR(100)
    SET @lenemail = LEN(@email)
    SET @pos1 = CHARINDEX('.', @email)
    SET @pos2 = CHARINDEX('@', @email)   
    SET @f_Name = LEFT(@email, @pos1 - 1)
    SET @l_Name = SUBSTRING(@email, @pos1 + 1, @pos2 - @pos1 - 1);
	SET @domain = SUBSTRING(@email, @pos2 + 1, @lenemail - @pos2)
    INSERT INTO @FirstLastDomain (firstname, lastname, domain)
    VALUES (@f_Name, @l_Name, @domain);
    RETURN
END


CREATE OR ALTER FUNCTION udf_SplitString (
    @string NVARCHAR(MAX),
    @delimiter NCHAR(1)
) 
RETURNS @table TABLE (value NVARCHAR(MAX))
AS
BEGIN
    DECLARE @start INT = 1,
            @end INT,
            @substring NVARCHAR(MAX);
    WHILE @start <= LEN(@string)
    BEGIN
        SET @end = CHARINDEX(@delimiter, @string, @start);
        IF @end = 0 
        BEGIN
            SET @end = LEN(@string) + 1;
        END
        SET @substring = SUBSTRING(@string, @start, @end - @start);
        INSERT INTO @table (value) VALUES (@substring);
        SET @start = @end + 1;
    END
    RETURN;
END;

/*

--DYNAMIC SQL
*/

USE BikeStores

declare @select AS VARCHAR(100),
		@table AS VARCHAR(100),
		@where AS VARCHAR(100),
		@sql AS VARCHAR(100)

Set @select='Select * from'
Set @table='customers'
Set @sql=@select+' '+@table
print @sql

--METHOD 1
EXEC (@sql)

--METHOD 2
EXEC sp_sqlexec @sql

declare @select AS VARCHAR(100),
		@table AS VARCHAR(100),
		@where AS VARCHAR(100),
		@sql AS VARCHAR(100),
		@condition AS Varchar(100),
		@condition2 AS Varchar(100),
		@Value AS varchar(50)

Set @select='Select * from'
Set @table='customers'
set @condition='where'
Set @condition2 ='customer_id='
Set @Value='40'
Set @sql=@select+' '+@table+' '+@condition+' '+@condition2+' '+@Value
print @sql

EXEC (@sql)


--how many customers in a state using dynamic SQL

DECLARE @select AS VARCHAR(100),
        @state AS VARCHAR(100),
        @countstate AS VARCHAR(100),
        @from AS VARCHAR(50),
        @tablename AS VARCHAR(100),
        @groupby AS VARCHAR(100),
        @gstate AS VARCHAR(100),
        @sql AS VARCHAR(MAX)  -- Use VARCHAR(MAX) to allow for longer SQL queries

-- Initialize variables
SET @select = 'SELECT '
SET @state = 'state, '
SET @countstate = 'COUNT(*) AS state_count '
SET @from = 'FROM '
SET @tablename = 'customers'
SET @groupby = 'GROUP BY '
SET @gstate = 'state'

-- Construct the dynamic SQL query
SET @sql = @select + @state + @countstate + @from + @tablename + ' ' + @groupby + @gstate

-- Print the dynamic SQL for debugging purposes
PRINT @sql

-- Execute the dynamic SQL query
EXEC(@sql)

--customers belong to NEWYORK
DECLARE @SELECT AS VARCHAR(100)
		,@GROUPBY AS VARCHAR(100)
		,@SQL AS VARCHAR(200)
		,@Table AS VARCHAR(100)
		,@WHERE AS VARCHAR(200)
		,@CITY AS VARCHAR(100)
SET @SELECT = 'SELECT * FROM ';
SET @Table = 'customers ';
SET @WHERE = 'WHERE city = ';
SET @CITY = '''NEW YORK''';
 
 
SET @SQL = @SELECT + @TABLE + @WHERE + @CITY;
 
PRINT @SQL;
 
EXEC sp_sqlexec @SQL;


--list of customers and their order date from 1-ARp-2017 and 15-May-2017

select * from customers
select * from orders

select c.*,o.* from customers as c
inner join orders as o 
ON c.customer_id=o.customer_id
where o.order_date between '2017-04-01' and '2017-05-15'
order by o.order_date



DECLARE @SELECT AS VARCHAR(100),
        @FIRSTNAME AS VARCHAR(100),
        @LASTNAME AS VARCHAR(100),
        @FROM AS VARCHAR(100),
        @TABLE1 AS VARCHAR(50),
        @ALIAS1 AS VARCHAR(100),
        @ALIAS1NAME AS VARCHAR(10),
        @JOINS AS VARCHAR(50),
        @TABLE2 AS VARCHAR(100),
        @ALIASNAME2 AS VARCHAR(10),
        @ON AS VARCHAR(10),
        @COLUMNNAME1 AS VARCHAR(100),
        @COLUMN AS VARCHAR(100),
        @WHERE AS VARCHAR(100),
        @CONDITION AS VARCHAR(100),
        @BETWEEN AS VARCHAR(100),
        @START AS VARCHAR(100),
        @AND AS VARCHAR(50),
        @END AS VARCHAR(100),
        @Orderby AS VARCHAR(50),
        @SQL AS VARCHAR(MAX)


SET @SELECT = 'SELECT '
SET @FIRSTNAME = 'first_name '
SET @LASTNAME = 'last_name '
SET @FROM = 'FROM '
SET @TABLE1 = 'customers '
SET @ALIAS1 = 'AS '
SET @ALIAS1NAME = 'c '
SET @JOINS = 'INNER JOIN '
SET @TABLE2 = 'orders '
SET @ALIASNAME2 = 'o '
SET @ON = 'ON '
SET @COLUMNNAME1 = 'customer_id ' 
SET @COLUMN = 'order_date ' 
SET @WHERE = 'WHERE '
SET @CONDITION = 'BETWEEN '
SET @START = '''2017-04-01 '''
SET @AND = 'AND '
SET @END = '''2017-05-15 '''
SET @Orderby = 'ORDER BY '

SET @SQL = @SELECT + @ALIAS1NAME + '.' + @FIRSTNAME + ', ' + @ALIAS1NAME + '.' + @LASTNAME + ', ' +
           @ALIASNAME2 + '.' + @COLUMN + ' ' +  
           @FROM + ' ' + @TABLE1 + ' ' + @ALIAS1 + @ALIAS1NAME + ' ' + 
           @JOINS + ' ' + @TABLE2 + ' ' + @ALIAS1 + @ALIASNAME2 + ' ' + 
           @ON + ' ' + @ALIAS1NAME + '.' + @COLUMNNAME1 + ' = ' + @ALIASNAME2 + '.' + @COLUMNNAME1 + ' ' + 
           @WHERE + ' ' + @ALIASNAME2 + '.' + @COLUMN + ' ' + @CONDITION + ' ' + @START + ' ' + @AND + ' ' + @END + ' ' + 
           @Orderby + ' ' + @ALIASNAME2 + '.' + @COLUMN

PRINT(@SQL)


EXEC(@SQL)



select * from order_items
select * from orders

--ORDER BY VALUE

select oi.order_id,sum(oi.quantity*oi.list_price) as  total_price from order_items as oi
Inner join orders as o
ON o.order_id = oi.order_id
group by oi.order_id

declare @sql as varchar(max)
set @sql= ('select 
	oi.order_id as [Order ID],
	c.first_name+c.last_name As [Name],
	sum(oi.list_price * oi.quantity) As [order value]
from order_items as oi
Inner join orders as o ON oi.order_id=o.order_id
Inner join Customers as c ON o.customer_id=c.customer_id

group by oi.order_id ,
		c.first_name+c.last_name
order by [order value] desc')

exec (@sql)

/*
---INDEXING---

1) CLUSTERED INDEX	(WHEN YOU CREATE A PRIMARY KEY AUTOMATICALLY CLUSTERED INDEX IS CREATED)
2) NON-CLUSTERED INDEX (WHEN YOU CREATE WITHOUT A PRIMARY KEY AUTOMATICALLY CLUSTERED INDEX IS CREATED)(UNIQUE AND NOT NULL)

*/

	select * from customers

--Create a non clustered INDEX
CREATE NONCLUSTERED INDEX IDX_FNAME on customers(first_name)

select * from customers
where first_name='Sethu'

exec sp_help customers --You can see the create non clustered index with the help of this command

drop index IDX_FNAME on customers

--TASK

--SOLUTION 1
SELECT * 
FROM customers 
WHERE first_name LIKE '[a-b]%'

--SOLUTION 2
SELECT * 
FROM customers 
WHERE first_name LIKE '[a,b,j]%'

--SOLUTION 1
SELECT * 
FROM customers 
WHERE first_name NOT LIKE '[a-p]%'
order by first_name asc

--SOLUTION 2
SELECT * 
FROM customers 
WHERE first_name  LIKE '[^a-p]%'
order by first_name asc

--SOLUTION 1
SELECT * 
FROM customers 
WHERE city like '_____nd' 

--SOLUTION 1
SELECT * 
FROM customers 
WHERE first_name like 'A_____' 

--SOLUTION 1

SELECT * 
FROM customers 
WHERE email like '%@gmail.com%' 

--SOLUTION 1
select customer_id from orders
group by customer_id
--SOLUTION 2
select distinct customer_id from orders

select *,
convert( Varchar(50),order_date,106)as Orderdate from orders

SELECT *, FORMAT(order_date, 'ddd') AS day
FROM orders;


--SOLUTION 1
SELECT *, FORMAT(order_date, 'yyyy') AS day
FROM orders;
--SOLUTION 2
SELECT *, DATEPART(year, order_date) AS year
FROM orders;
--SOLUTION 3
SELECT *, year(order_date) AS day
FROM orders;

 SELECT DATEDIFF(DAY, '2024-12-01', '2025-01-04');


