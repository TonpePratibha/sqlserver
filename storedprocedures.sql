--stored procedures
create database storedproceduress
use storedproceduress
create table products(
pid int ,
pname varchar(30),
brandid int,
categoryid int,
modelyear int,
listprice decimal(10,2)

)

insert into products Values(1,'biscuit',1,2,23,15);
insert into products Values(2,'lays',1,2,23,45);
insert into products Values(3,'cake',1,2,23,30);
insert into products Values(4,'chocalate',3,3,11,25);
insert into products Values(5,'icecream',6,9,11,99);

CREATE PROCEDURE uspProductList
as
begin
select pname,
listprice
from products
order by 
pname;
end;

---execute procedure
exec uspProductList;

--alter

alter procedure uspproductList
as
begin
select pname,listprice from products
order by listprice
end;

drop procedure uspproductList;

create  procedure uspFindproducts(@min_listprice as decimal)
as
begin 
select
pname,listprice from products 
where
listprice>=@min_listprice
order by
listprice
end;

exec uspFindproducts 25;


create procedure Findproducts(@min_listprice as decimal ,@max_listprice as decimal)
as
begin
select 
pname,listprice from products
where 
listprice>=@min_listprice and
listprice<=@max_listprice

order by
listprice
end
execute Findproducts 24, 45;
execute Findproducts @min_listprice=25, @max_listprice=45;



create procedure Findproductsbyname(@min_listprice as decimal,@max_listprice as decimal,@name varchar(20))
as
begin
select pname,listprice
from products where
listprice >=@min_listprice and
listprice>=@max_listprice and
pname like '%'+@name+ '%';
end


exec Findproductsbyname @min_listprice =25,
@max_listprice =45, @name='ce'

create procedure newprocedure(@min_listprice as decimal=0, @max_listprice as decimal =9999,@name as varchar(20)) 
as
begin 
select pname,listprice 
from products
where 
listprice>=@min_listprice and
listprice<=@max_listprice and
pname like '%' +@name+ '%'
order by pname;
end


create procedure newprocedurenull(@min_listprice as decimal=0, @max_listprice as decimal =null,@name as varchar(20)) 
as
begin 
select pname,listprice 
from products
where 
listprice>=@min_listprice and
(@max_listprice is null or listprice<=@max_listprice)
and
pname like '%' +@name+ '%'
order by pname;
end

exec newprocedurenull @name='a';






create procedure productsyear
as
begin
select modelyear from products 
end

exec productsyear


--if els estored procedure
create procedure ifelseexample(@piid  as int)
as
begin
if exists(select pid from products where pid=@piid and pname='biscuit')
print 
'product found';
else
print 'product not found'
end;


alter procedure ifelseexample(@piid  as int)
as
begin
if exists(select pid from products where pid=@piid and pname='biscuit')
print 
'product found';
else
print 'product not found'
end;

exec ifelseexample @piid=1;

--try catch


create procedure insertata(@pid int, @pname varchar(20),@brandid int,@categoryid int,@modelyear varchar(20),@listprice decimal)
as 
begin 
begin try
insert into products(pid,pname,brandid,categoryid,modelyear,listprice) Values(@pid,@pname,@brandid,@categoryid,@modelyear,@listprice);
end try
begin catch
print 
    'error msg'+error_message();
	end catch
	end

	exec insertata @pid=8,@pname='cream',@brandid=4,@categoryid=4,@modelyear=24,@listprice=100;

	select * from products;


	--variables used to store  single values 
create procedure getprodList(@model_year int)
as
begin 
--declare variabel
declare @product_list as varchar(max)
set @product_list='';
select
@product_list =@product_list +pname+ CHAR(10) ---concatiation
from products
where modelyear=@model_year
order by pname;
print @product_list;

end

exec getprodList 23

select * from products;


--output parameters
create procedure outputprameter(
@model_year int, 
@product_count int output
)
as
begin
select 
pname,listprice 
from products
where modelyear=@model_year

select @product_count=@@ROWCOUNT--to get rows count
end;

--to get the count dta fro procedure
declare @count int;
exec outputprameter @model_year=23,
@product_count=@count output;

select @count as 'no of products'

--functions
--scalar function
--returns single value
create function getlistprice(@pid int)
returns decimal(10,2)
as
begin
declare @listprice decimal(10,2);

select @listprice=listprice from products where pid=@pid;

return @listprice;
end;


select dbo.getlistprice(4);

create function totalofallproducts()
returns decimal(10,2)
as
begin
declare @Totallistprice decimal(10,2)
select @Totallistprice =sum(listprice) from products ;
return  @Totallistprice
end






alter function totalofallproducts()
returns decimal(10,2)
as
begin
declare @Totallistprice decimal(10,2)
select @Totallistprice =sum(listprice) from products ;
return  @Totallistprice
end
select dbo.totalofallproducts();


create function getByname(@pid int)
returns table
as
return(
select pname from products where pid=@pid
)

select * from dbo.getByname(4)


create function getname(@pid int)
returns varchar(20)
as
begin
declare @name varchar(20);
select @name=pname from products where pid=@pid
return @name;
end;

select dbo.getname(4);


create function totalofallproductstable()
returns table
as
return(
select sum(listprice) from products group by listprice
);
end;


--table valued function
--dbo is a schema name  while executing function need to write schema name
--returns table
create function getallproducts(@pid int)
returns table
as
return(
select * from products where pid=@pid
);

select * from dbo.getallproducts(4);


drop function dbo.getallproducts;





-views

create view productsdetails
as
select * from products;
---to run a view
select * from productsdetails

create view productsname(pname,listprice)
as
select pname,listprice from products where pid=1;

select * from productsname;
--to drop view
drop view if exists productsdetails;
--rename view
exec sp_rename @objname='productsname', @newname='pnames'

exec sp_rename @objname='productsname', @newname='pnames'

select * from pnames;
--alter view 
alter view pnames 
as
select pname,listprice from products where listprice>15;

select * from pnames;


--partitioned views means vew of multiple tables

--indexed views 

create view productsdata 

as
select pid from products where pid=3;

create clustered index 
productindex 
on
products(pid);

select * from productsdata;

--cursor
-----
declare    --declare varible
@pname varchar(20),
@listprice decimal;

declare cursor_product cursor    --declare cursor
for
select pname,listprice from products;

open cursor_product ;

fetch next from cursor_product into
@pname ,@listprice;

while @@FETCH_STATUS=0
begin
print @pname+Cast(@listprice as varchar);
fetch next from cursor_product into
@pname,
@listprice;
end;
close cursor_product;
deallocate cursor_product;


-------
declare @productname varchar(20),
@list_price decimal(10,2),
@Modelyear varchar(20);

declare printallcursor cursor
for select 
pname,listprice,modelyear
from products;

open printallcursor;

fetch next from printallcursor into
@productname ,@list_price,@Modelyear;

while @@FETCH_STATUS=0
begin
print @product_name +cast(@list_price as varchar);

fetch next from printallcursor into
@productname ,@list_price,@Modelyear;
end;
close printallcursor;
deallocate printallcursor;

------
declare @pname varchar(20);

declare getnamecursor cursor
for 
select pname from products;

open getnamecursor

fetch next from getnamecursor into
@pname

while @@fetch_status=0
begin
print @pname

fetch next from getnamecursor into @pname

end
close getnamecursor;
deallocate getnamecursor;


--triggers


--first need to create audit table
create table product_audit
(
audit_id int identity(1,1) primary key,
pid INT,
pname VARCHAR(20),
    brandid INT,
    categoryid INT,
    modelyear INT,
    listprice DECIMAL(10, 2),
    updated_at DATETIME,
    operation NVARCHAR(10)

)

create trigger products_audit_trigger
on products
after insert ,delete
as
begin
set nocount on;
insert into product_audit(
pid ,
pname ,
brandid ,
categoryid,
modelyear,
listprice ,
updated_at,
operation
)
select
i.pid,
i.pname,
brandid ,
categoryid,
modelyear,
i.listprice,
GETDATE(),
'INS'
from 
inserted i

union all

select 
d.pid,
d.pname,
brandid ,
categoryid,
modelyear,
d.listprice,
GETDATE(),
'DEL'
from
deleted d;
end


INSERT INTO products(
     pid,
    pname,
	brandid,
	categoryid,
	modelyear,
	listprice
)
VALUES (
9,
    'Test product',
    1,
    1,
    18,
    599
);

insert into products Values(9,'chips',1,2,23,50);

select * from product_audit;

delete from products where pid=9;

select * from products;

create 

CREATE TRIGGER products_insert_audit
ON products
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO products_audit (pid, pname, listprice, updated_at, operation)
    SELECT i.pid, i.pname, i.listprice, GETDATE(), 'INS'
    FROM inserted i;  -- `i` represents the new inserted row
END;


CREATE TRIGGER products_delete_audit
ON products
AFTER DELETE
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO products_audit (pid, pname, listprice, updated_at, operation)
    SELECT d.pid, d.pname, d.listprice, GETDATE(), 'DEL'
    FROM deleted d;  -- `d` represents the deleted row
END;


create trigger products_update_trigger
on products
after update
as
begin
insert into product_audit
(pid,
pname,
brandid,
categoryid,
listprice,
updated_at,
operation)
select 
i.pid,
i.pname,
i.listprice,
getdate(),
'upd'
from inserted i
inner join deleted d 
on i.pid=d.pid
end

update products
set pname='cookies' , listprice=100
where pid =5;
select * from products;

select * from product_audit;

---instedof trigger
create trigger insteadof_insert
on products
instead of insert
as
begin
insert into product_audit
( pid,pname,brandid,categoryid,modelyear,
listprice,updated_at,operation

)
select
pid,pname,brandid,categoryid,modelyear,listprice,GETDATE(),'ins' 
from inserted i 

insert into products(pid,pname,brandid,categoryid,modelyear,
listprice) 
select 
pid,pname,brandid,categoryid,modelyear,
listprice
from inserted 
where listprice>0;

end

insert into products values(9,'updated',2,3,34,50);
select * from product_audit
select * from products;



create trigger instedof_delete
on products
instead of delete
as
begin
insert into product_audit(
pid,pname,brandid,categoryid,modelyear,listprice,updated_at,operation
)
select 
pid,pname,brandid,categoryid,modelyear,listprice ,getdate(),'del'
from deleted d

update p
set p.status ='inactive'
from products p
inner join deleted d
on p.pid=d.pid;
end

alter table products 
add status varchar(20) default 'active';
update products set status='active'

delete from products where pid=1;

select * from product_audit
select * from products;




create trigger insteadof_update
on products 
instead of update
as
begin

insert into product_audit(
pid,pname,brandid,categoryid,modelyear,listprice,updated_at,operation
)
select 
pid,pname,brandid,categoryid,modelyear,listprice,getdate(),'upd'
from deleted i

update p
set p.listprice=i.listprice
from inserted i
inner join products p on i.pid=p.pid where i.listprice>0;
end

update products 
set listprice=90
where pid=4;

select * from product_audit
select * from products;


--ddl triggers










