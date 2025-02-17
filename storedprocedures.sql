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