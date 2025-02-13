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
select * from emp e left join candidates c on e.id=c.id
select * from emp e full join candidates c on e.id=c.id
select * from emp e inner join candidates c on e.id=c.id

sp_rename 'candidates.fullname', 'candidatename','column'
sp_rename 'emp.fullname','empname','column'



--self join
create table comapany(
empid int primary key,
empname varchar(20),
managerid int, 
city varchar(20)
)

alter table comapany
add constraint fk_empid foreign key (managerid) references comapany(empid);
alter table comapany 
drop fk_empid

insert into comapany Values(1,'anil',6,'delhi');
insert into comapany Values(2,'sunil',2,'delhi');
insert into comapany Values(3,'mahesh',4,'delhi');
insert into comapany Values(4,'suresh',3,'delhi');
insert into comapany Values(5,'amit',1,'delhi');
insert into comapany Values(6,'kumar',8,'delhi');
insert into comapany Values(7,'arjun',7,'delhi');
insert into comapany Values(8,'rajesh',5,'delhi');

select a.empid as"empid" ,a.empname as "empname",b.empid as "managerid", b.empname as"managername" from comapany a ,comapany b where a.managerid=b.empid;


create table empdetails (

empid int primary key,
empage int,
empaddress varchar(20)

)
alter table empdetails
add constraint fk_emddid foreign key(empid) references comapany(empid)

insert into empdetails Values ( 1,19,'pune');
insert into empdetails Values ( 2,21,'mumbai');
insert into empdetails Values ( 3,23,'banglore');
insert into empdetails Values ( 8,56,'pune');
insert into empdetails Values ( 9,44,'pune');

select c.empid,c.empname,ed.empage,ed.empaddress from comapany c cross join empdetails ed 


--joins with 3 tables

create table customers(
customer_id int primary key,
name varchar(20),
city varchar(20)

);
create table orders(
order_id int primary key,
customer_id int,
amount decimal(10,2),
foreign key (customer_id) references customers(customer_id)
)
create table payments(
payment_id int primary key,
order_id int,
status varchar(20),
foreign key (order_id) references orders(order_id)
)

insert into customers Values(1,'alice','newyork');
insert into customers Values(2,'Bob','chicago');
insert into customers Values(3,'Charlie','boston');
insert into customers Values(4,'ninja','boston');

insert into orders Values(101,1,500);
insert into orders Values(102,2,300);
insert into orders Values(103,3,700);

insert into payments Values(201,101,'paid');
insert into payments Values(202,102,'pending');
insert into payments Values(203,103,'failed');

select * from customers
select * from orders
select * from payments

SELECT c.customer_id, c.name, o.order_id, o.amount 
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id;

select c.customer_id,c.name,o.order_id,o.amount from customers c
inner join orders o on c.customer_id=o.customer_id;

SELECT A.customer_id AS customer_1, A.name AS customer_name_1,
       B.customer_id AS customer_2, B.name AS customer_name_2
FROM customers A
JOIN customers B ON A.city = B.city AND A.customer_id <> B.customer_id;

SELECT c.name, o.order_id, o.amount, p.status
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
LEFT JOIN payments p ON o.order_id = p.order_id;