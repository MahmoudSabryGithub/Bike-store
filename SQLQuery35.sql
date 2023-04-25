
create view OrdersData as 
(
select ord.order_id,ord.order_date,cst.first_name+' '+cst.last_name as'Customer name',cst.state
,cst.street,cst.city,sum(itm.quantity) as 'Total items',
sum(itm.list_price*(1-itm.discount)*itm.quantity) as 'Order price'
from 
[sales].[orders] ord join [sales].[customers] cst 
on ord.customer_id=cst.customer_id
join [sales].[stores] sto
on sto.store_id=ord.store_id
join [sales].[order_items] itm
on itm.order_id=ord.order_id
group by ord.order_id,ord.order_date,cst.first_name+' '+cst.last_name ,cst.state
,cst.street,cst.city
)
go
----------------------------------------------------------

select * from [dbo].[OrdersData]
go 

----------------------------------------------------------

create view OrderTotalProducts as 
(
select ord.order_id,ord.order_date,cst.first_name+' '+cst.last_name as'Customer name',cst.state
,cst.street,cst.city,pro.product_name ,cat.category_name as 'Product category'
,bra.brand_name as 'Brand name',sum(itm.quantity) as 'Total items',
sum(itm.list_price*(1-itm.discount)*itm.quantity) as 'Revenue'
from 
[sales].[orders] ord join [sales].[customers] cst 
on ord.customer_id=cst.customer_id
join [sales].[stores] sto
on sto.store_id=ord.store_id
join [sales].[order_items] itm
on itm.order_id=ord.order_id
join [production].[products] pro
on pro.product_id=itm.product_id
join [production].[brands] bra 
on bra.brand_id=pro.brand_id
join [production].[categories] cat 
on cat.category_id=pro.category_id
group by ord.order_id,ord.order_date,cst.first_name+' '+cst.last_name ,cst.state
,cst.street,cst.city,pro.product_name,cat.category_name,bra.brand_name
)
go 

----------------------------------------------------------

select * from OrderTotalProducts