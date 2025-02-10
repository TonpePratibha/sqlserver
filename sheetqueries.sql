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

select * from Customer where addr='pune';
select * from Customer where addr='pune' order by email, FullName;

select * from Customer order by fullname;


create table demo(
salary float,
age int
)

alter table demo
alter column salary decimal(10,2);

alter table demo
alter column age varchar(10);

create table meetings(
MeetDate date ,
MeetTime time
)

update Employees 
set Salary=Salary+(Salary*0.10)
where Salary<50000
