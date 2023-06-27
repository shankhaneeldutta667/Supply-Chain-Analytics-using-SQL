### PART A:::
create schema supply_chain;
use supply_chain;
-- 1.	Read the data from all tables.
select * from customer;
select * from orderitem;
select * from orders;
select * from product;
select * from supplier;

-- 2.	Find the country wise count of customers.
select * from customer;
select Country,count(Id) as no_of_customers from customer group by Country order by Country;

-- 3.	Display the products which are not discontinued.
select * from product;
select Id,ProductName from product where IsDiscontinued=0;

-- 4.	Display the list of companies along with the product name that they are supplying.
select * from supplier;
select * from product;
select s.Id as supplier_id,s.CompanyName as supplier_name,p.Id as product_id,p.ProductName as product_name
from supplier s left join product p on s.Id=p.SupplierId order by s.Id;

-- 5.	Display customer's information who stays in 'Mexico'
select * from customer where Country='Mexico';

-- 6.	Display the price of costliest item that is ordered by the customer along with the customer details.
SELECT * FROM PRODUCT;
SELECT *
FROM ORDERITEM;
SELECT * FROM ORDERS;

select c.Id as customer_id,c.FirstName,c.LastName,c.City,c.Country,o.TotalAmount
from customer c join orders o on c.Id=o.CustomerId order by o.TotalAmount desc limit 1 offset 0;

-- 7.	Display supplier id who owns highest number of products.
select * from supplier;
select * from product;
select s.Id as supplier_id,s.CompanyName as supplier_name,
count(p.Id) as no_of_products from supplier s join product p on s.Id=p.SupplierId
group by s.Id,s.CompanyName order by no_of_products desc;

-- 8.	Display month wise and year wise count of the orders placed.
select year(OrderDate) as Year_of_Order, month(OrderDate) as Month_of_Order, count(Id) as number_of_orders
from orders group by year(OrderDate),month(OrderDate) order by Year_of_Order,Month_of_Order;

-- 9.	Which country has maximum suppliers.
select * from supplier;
select Country,count(Id) as no_of_suppliers from supplier
group by Country order by no_of_suppliers desc limit 1 offset 0;

-- 10. Which customers did not place any order.
select * from orders;
select Id as customer_id,FirstName,LastName from customer 
where Id not in (select CustomerId from orders) order by customer_id;