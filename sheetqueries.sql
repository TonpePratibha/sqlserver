create database practice;

use practice;

CREATE TABLE Employees(
EmpId int identity(1,1) Primary Key,
FirstName varchar(20) not null,
LastName varchar(20) not null,
Email varchar(20) unique,
Age int check(Age between 18 and 65),
Salary decimal(10,2) default 30000,
DepartmentId int foreign key
)

insert into dbo.Employees Values('abc','xyz','abc@gmail.com',70,50000,1)
insert into dbo.Employees Values('nnjnj','jwj','edh@gmail.com',70,40000,2)

select * from Employees
create table Department(
deptId int identity(1,1),
deptname varchar(50)
)
insert into Department Values('it');
select * from Department;
alter table Employees
add DepartmentId int;

alter table Employees
add Constraint fk_dept foreign key (DepartmentId) references Department(deptId);

update Employees 
set Salary=Salary+(Salary*0.10)
where Salary<50000

alter table Department 
add constraint pk_dept primary key(deptId);

create table Customer(
cId int unique,
FullName varchar(100),
Email varchar(50) unique,
Phone CHAR(10) CHECK (Phone LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]') NOT NULL,
DateOfBirth date
)

alter table Customer 
drop column DateOfBirth ;

alter table Customer
add addr varchar(50);

insert into Customer Values(1 ,'akshay kumar','abc@gmail.com','1234567896','pune');
insert into Customer Values(2 ,'sonu nigam','sonu@gmail.com','1234768543','mumbai');
insert into Customer Values(3 ,'priti zinta','priti@gmail.com','8899776655','solapur');
insert into Customer Values(4 ,'karan arjun','karan@gmail.com','9876543210','banglore');
insert into Customer Values(5 ,'rani','rani@gmail.com','1278567896','pune');
insert into Customer Values(6 ,'tina','tina@gmail.com','9034567896','pune');
insert into Customer Values(7 ,'gopi','gopi@gmail.com','7734567896','pune');
insert into Customer Values(8 ,'tina','kjna@gmail.com','9034567896','pune');
insert into Customer Values(9 ,'gopi','fsdre@gmail.com','7734567896','pune');
select * from Customer;

select addr ,count(addr) from Customer group by addr order by addr desc;
select * from customer where FullName like '_a%';
select * from Customer where FullName like '%_a_%' 
select * from Customer where addr='pune';
select * from Customer where addr='pune' order by email, FullName;

select * from Customer where addr='pune' order by fullname desc;

select FullName from Customer order by len(FullName)desc;

select * from Customer order by 1,2;

select distinct addr from Customer;
select distinct addr,FullName from Customer;
select * from Customer where addr='pune' and FullName='gopi';
select * from Customer where addr='pune' or FullName='gopi';

create table products(
pid int ,
pname varchar(30),
brandid int,
categoryid int,
modelyear int,
listprice decimal(10,2)

)
select * from products;
delete TOP (5)  percent from products;
delete from products where modelyear=23
update products
set prodname='icecreammm' where pid=3;

update products
set prodname='abc',
modelyear=67
where 
modelyear=11;

sp_rename 'products.pname','prodname','column'

insert into products Values(1,'biscuit',1,2,23,15);
insert into products Values(2,'lays',1,2,23,45);
insert into products Values(3,'cake',1,2,23,30);
insert into products Values(4,'chocalate',3,3,11,25);
insert into products Values(5,'icecream',6,9,11,99);

select modelyear,count(modelyear) from products group by modelyear having count(modelyear)>1;


select pname,listprice from products order by listprice,pname offset 2 rows fetch next 2 rows only;
--offset used to skip first no of rows e. first 2 rows skip
--fetch used to display no of next rows only
select top 2  pname from products order by pname
select top 2 percent pname from products order by pname;
--top used to select top n rows from table
select * from products where listprice in(15,45,23);

select * from products where listprice between 15 and 99;

select Min(listprice) from products 
select Max(listprice) from products group by listprice order by listprice ;
select modelyear,pname from products group by modelyear;

select avg(listprice) from products group by listprice 
having avg(listprice )>15

select pname,modelyear,listprice from products group by pname ,cube(modelyear,pname,listprice);

select pname,modelyear,listprice from products group by pname ,rollup(modelyear,pname,listprice);

select * from products

select pname ,modelyear from products group by grouping sets (pname,modelyear),(pname),()


create table demo(
salary float,
age int
)
insert into demo Values(1000,12),(2000,23),(8890,90)
select * from demo
truncate table demo where age=12;
delete from demo

alter table demo
alter column salary decimal(10,2);

alter table demo
alter column age varchar(10);

create table meetings(
MeetDate date ,
MeetTime time
)

CREATE TABLE taxrate (
	tax_id INT PRIMARY KEY ,
	state VARCHAR (50) NOT NULL UNIQUE,
	statetaxrate DEC (10, 2),
	avglocaltaxrate DEC (10, 2),
	combinedrate dec(10,2)
	maxlocaltaxrate DEC (10, 2),
	updatedat datetime
);

update taxe
set updated_at =GETDATE();

--merge example
create table student_source(

id int primary key,
name varchar(20));
create table student_target(

id int primary key,
name varchar(20));
alter table student_target
add constraint fk_id foreign key (id) references student_source(id);
insert into student_source Values(1,'abc'),(2,'xyz')
insert into student_target Values(1,'cdc'),(2,'ddd')

select * from student_source s inner join student_target t on s.id=t.id; 

merge student_target as t
using student_source as s
on t.id=s.id
when matched then
update set t.name=s.name
when not matched by target then
insert (id,name) Values(s.id,s.name)
when not matched by source then
delete;
select * from student_source
drop database if exists demo;

--joins
create table candidates(
id int primary key identity,
fullname varchar(100) not null

)
alter table candidates 
add constraint fk_iid foreign key (id) references emp(id);
create table emp(
id int primary key identity,
fullname varchar(100) not null
)
insert into candidates(fullname) Values('john doe'),('lily bush'),('peter drucker'),('jane doe');
insert into emp (fullname) values('john doe'),('jane doe'),('michel scott'),('jack sparrow');

select * from candidates;
select * from emp;

select * from emp e right join candidates c on e.id=c.id