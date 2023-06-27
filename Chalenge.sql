use supply_chain;

-- Q1)
select * from product where Id in (1,40,53);
select * from orderitem;

with t3 as
(
	with t1 as 
		(
			select oi.OrderId,oi.ProductId,sum(oi.UnitPrice) as product_SP 
			from orderitem oi group by oi.OrderId,oi.ProductId order by oi.OrderId
		)
		select t1.OrderId,sum(t1.product_SP) as total_SP from t1 group by t1.OrderId
),
t4 as
(    
	with t2 as 
		(
			select oi.OrderId,p.Id as ProductId,sum(p.UnitPrice) as product_CP
			from orderitem oi join product p on p.Id=oi.ProductId group by oi.OrderId,p.Id
			order by oi.OrderId
		)
		select t2.OrderId,sum(t2.product_CP) as total_CP from t2 group by t2.OrderId
)
select t3.OrderId,t4.total_CP,t3.total_SP,(t4.total_CP-t3.total_SP) as total_amount_saved
from t3 join t4 on t3.OrderId=t4.OrderId order by total_amount_saved desc;

-- Q2)

select * from orders;
select * from orderitem;
select oi.ProductId,p.ProductName,s.Companyname as supplier_name,sum(oi.Quantity) as demand 
from orderitem oi join product p on oi.ProductId=p.Id join supplier s on s.Id=p.SupplierId
group by oi.ProductId order by demand desc limit 5 offset 0;

-- Q4)

select * from supplier;
select * from product;
select * from orderitem;


create view v1 as
(
select x.supplier_id,x.supplier,sum(x.sales) as total_sales from 
(
	select s.Id as supplier_id,s.CompanyName as supplier,p.Id as product_id,
	sum((oi.UnitPrice*oi.Quantity)) as sales from orderitem oi join product p on p.Id=oi.ProductId
	join supplier s on s.Id=p.SupplierId group by supplier_id,supplier,product_id
) as x 
group by x.supplier_id,x.supplier order by total_sales desc 
);

select * from v1;
select * from (
select s.Country as supply_country,v1.* ,
dense_rank() over(partition by s.Country order by v1.total_sales desc) as rnk
from supplier s join v1 on s.Id=v1.supplier_id
) as z where rnk<3 order by supply_country asc,total_sales desc;



