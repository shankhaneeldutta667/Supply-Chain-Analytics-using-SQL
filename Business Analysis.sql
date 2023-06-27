use supply_chain;
show tables;
select * from orderitem;
-- Fetch the records to display the customer details who ordered more than 10 products in the single order
with t1 as (
select o.Id as order_id,c.Id as customer_id,c.FirstName,c.LastName,count(oi.productID) as total_products
from customer c join orders o on c.Id=o.CustomerId join orderitem oi on oi.OrderId=o.Id
group by oi.OrderId)
select t1.* from t1 where t1.total_products>10;


-- Display all the product details with the ordered quantity size as 1.
select * from product;
select * from orderitem;
select p.* from product p join orderitem oi on p.Id=oi.ProductId
where oi.Quantity=1;


-- Display the companies which supply products whose cost is above 100.
select * from supplier;
select * from product where UnitPrice>100;
select s.Id as supplier_id,s.CompanyName as supply_company,p.Id,p.UnitPrice
from supplier s join product p on s.Id=p.SupplierId where p.UnitPrice>100;


-- Create a combined list to display customers and supplier list as per the belowformat.

select * from customer;
select * from supplier;
select 'customer' as Type,concat(FirstName,' ',LastName) as ContactName,City,Country,Phone from customer
union all
select 'supplier' as Type,ContactName,City,Country,Phone from supplier;

-- Display the customer list who belongs to same city and country arrange in country wise
select * from customer;
select * from supplier;

select Country,City,group_concat(FirstName,' ',LastName) as CustomerName
from customer group by Country,City order by Country;




