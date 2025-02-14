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

--self join
select a.empid as"empid" ,a.empname as "empname",b.empid as "managerid", b.empname as"managername"
from comapany a ,comapany b where a.managerid=b.empid;


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
--cross join
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



--------------------------------------
--SAMPLE DATA----

CREATE TABLE LOCATIONS (
    LOCATION_ID INT PRIMARY KEY,
    STREET_ADDRESS VARCHAR(255),
    POSTAL_CODE VARCHAR(20),
    CITY VARCHAR(100),
    STATE_PROVINCE VARCHAR(100),
    COUNTRY_ID VARCHAR(10)
);

INSERT INTO LOCATIONS (LOCATION_ID, STREET_ADDRESS, POSTAL_CODE, CITY, STATE_PROVINCE, COUNTRY_ID) VALUES
(1000, '1297 Via Cola di Rie', '989', 'Roma', NULL, 'IT'),
(1100, '93091 Calle della Testa', '10934', 'Venice', NULL, 'IT'),
(1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP'),
(1300, '9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP'),
(1400, '2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US'),
(1500, '2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US'),
(1600, '2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US'),
(1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US'),
(1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA'),
(1900, '6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA'),
(2000, '40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN'),
(2100, '1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN'),
(2200, '12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU'),
(2300, '198 Clementi North', '540198', 'Singapore', NULL, 'SG'),
(2400, '8204 Arthur St', NULL, 'London', NULL, 'UK'),
(2500, 'Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK'),
(2600, '9702 Chester Road', '9629850293', 'Stretford', 'Manchester', 'UK'),
(2700, 'Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE'),
(2800, 'Rua Frei Caneca 1360', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR'),
(2900, '20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH'),
(3000, 'Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH'),
(3100, 'Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL'),
(3200, 'Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal', 'MX');



CREATE TABLE DEPARTMENTS (
    DEPARTMENT_ID INT PRIMARY KEY,
    DEPARTMENT_NAME VARCHAR(100),
    MANAGER_ID INT,
    LOCATION_ID INT,
    FOREIGN KEY (LOCATION_ID) REFERENCES LOCATIONS(LOCATION_ID)
);

INSERT INTO DEPARTMENTS (DEPARTMENT_ID, DEPARTMENT_NAME, MANAGER_ID, LOCATION_ID) VALUES
(10, 'Administration', 200, 1700),
(20, 'Marketing', 201, 1800),
(30, 'Purchasing', 202, 1700),
(40, 'Human Resources', 203, 2400),
(50, 'Shipping', 204, 1500),
(60, 'IT', 205, 1400),
(70, 'Public Relations', 206, 2700),
(80, 'Sales', 207, 2500),
(90, 'Executive', 208, 1700),
(100, 'Finance', 209, 1700),
(110, 'Accounting', 210, 3200);

CREATE TABLE EMPLOYEES (
    EMPLOYEE_ID INT PRIMARY KEY,
    FIRST_NAME VARCHAR(50),
    LAST_NAME VARCHAR(50),
    EMAIL VARCHAR(100),
    PHONE_NUMBER VARCHAR(20),
    HIRE_DATE DATE,
    JOB_ID VARCHAR(20),
    SALARY DECIMAL(10,2),
    MANAGER_ID INT,
    DEPARTMENT_ID INT,
    FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
);

INSERT INTO EMPLOYEES (EMPLOYEE_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, HIRE_DATE, JOB_ID, SALARY, MANAGER_ID, DEPARTMENT_ID) VALUES
(100, 'Steven', 'King', 'SKING', '515.123.4567', '1987-06-17', 'AD_PRES', 24000.00, NULL, 90),
(101, 'Neena', 'Kochhar', 'NKOCHHAR', '515.123.4568', '1989-09-21', 'AD_VP', 17000.00, 100, 90),
(102, 'Lex', 'De Haan', 'LDEHAAN', '515.123.4569', '1993-01-13', 'AD_VP', 17000.00, 100, 90),
(103, 'Alexander', 'Hunold', 'AHUNOLD', '590.423.4567', '1990-01-03', 'IT_PROG', 9000.00, 60, 60),
(104, 'Bruce', 'Ernst', 'BERNST', '590.423.4568', '1991-05-21', 'IT_PROG', 6000.00, 60, 60),
(105, 'David', 'Austin', 'DAUSTIN', '590.423.4569', '1997-06-25', 'IT_PROG', 4800.00, 60, 60),
(106, 'Valli', 'Pataballa', 'VPATABAL', '590.423.4560', '1998-02-05', 'IT_PROG', 4800.00, 60, 60),
(107, 'Diana', 'Lorentz', 'DLORENTZ', '590.423.5567', '1999-02-07', 'IT_PROG', 4200.00, 60, 60),
(108, 'Nancy', 'Greenberg', 'NGREENBE', '515.124.4569', '1994-08-17', 'FI_MGR', 12008.00, 100, 100),
(109, 'Daniel', 'Faviet', 'DFAVIET', '515.124.4169', '1995-08-16', 'FI_ACCOUNT', 9000.00, 108, 100),
(110, 'John', 'Chen', 'JCHEN', '515.124.4269', '1996-09-28', 'FI_ACCOUNT', 8200.00, 108, 100),
(111, 'Ismael', 'Sciarra', 'ISCIARRA', '515.124.4369', '1997-09-30', 'FI_ACCOUNT', 7700.00, 108, 100),
(112, 'Jose Manuel', 'Urman', 'JMURMAN', '515.124.4469', '1998-03-07', 'FI_ACCOUNT', 7800.00, 108, 100),
(113, 'Luis', 'Popp', 'LPOPP', '515.124.4569', '1999-12-07', 'FI_ACCOUNT', 6900.00, 108, 100);


---joins queries on above data


select * from EMPLOYEES;
select * from DEPARTMENTS;
select * from LOCATIONS
--1. find firstname lastname ,deptname no for each emp
select E.FIRST_NAME ,E.LAST_NAME ,D.DEPARTMENT_ID,D.DEPARTMENT_NAME 
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID;

--2. find Firstname ,lastname,deptname,city,state  
SELECT E.FIRST_NAME,E.LAST_NAME ,D.DEPARTMENT_NAME ,L.CITY,L.STATE_PROVINCE
FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID 
INNER JOIN LOCATIONS L ON D.LOCATION_ID=L.LOCATION_ID

--3 find emp work in deptid 40 or80 and retun first ,last deptnumber,dept name



SELECT E.FIRST_NAME ,E.LAST_NAME ,D.DEPARTMENT_NAME, D.DEPARTMENT_ID 
FROM  EMPLOYEES E INNER JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID =D.DEPARTMENT_ID
WHERE E.DEPARTMENT_ID IN(60,40)


--COUNT OF EMP FOR EACH DEPT
SELECT D.DEPARTMENT_NAME, COUNT(E.EMPLOYEE_ID) 
FROM  EMPLOYEES E INNER JOIN DEPARTMENTS D 
ON E.DEPARTMENT_ID=D.DEPARTMENT_ID 
GROUP BY D.DEPARTMENT_NAME


-- From the following tables, write a SQL query to find full name (first and last name),
--and salary of all employees working in any department in the city of London.
SELECT E.FIRST_NAME ,E.LAST_NAME ,E.SALARY FROM EMPLOYEES E INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID
INNER JOIN LOCATIONS L ON L.LOCATION_ID=D.LOCATION_ID WHERE L.CITY='Mexico';

SELECT 
    E.FIRST_NAME, 
    E.LAST_NAME, 
    E.SALARY 
FROM EMPLOYEES E 
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
INNER JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID 
WHERE L.CITY = 'Bombay';


SELECT * FROM EMPLOYEES E LEFT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID

SELECT * FROM EMPLOYEES E RIGHT JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID

SELECT * FROM EMPLOYEES E CROSS JOIN DEPARTMENTS D

SELECT * FROM EMPLOYEES E FULL JOIN DEPARTMENTS D
ON D.DEPARTMENT_ID=E.DEPARTMENT_ID


-- From the following tables, write a SQL query to find those employees whose first name contains the letter ‘z’.
--Return first name, last name, department, city, and state province

SELECT E.FIRST_NAME ,E.LAST_NAME ,D.DEPARTMENT_NAME, L.CITY,L.STATE_PROVINCE FROM EMPLOYEES E 
INNER JOIN DEPARTMENTS D ON E.DEPARTMENT_ID=D.DEPARTMENT_ID 
INNER JOIN LOCATIONS L ON L.LOCATION_ID=D.LOCATION_ID
WHERE E.FIRST_NAME LIKE '%m%'



-- From the following table, write a SQL query to find the employees and their managers.
--Return the first name of the employee and manager.
select * from EMPLOYEES
SELECT e.FIRST_NAME, m.FIRST_NAME from EMPLOYEES e INNER JOIN EMPLOYEES m on m.EMPLOYEE_ID=e.MANAGER_ID;

--From the following table, write a SQL query to find the employees who earn less than the employee of ID 182. 
--Return first name,last name and salary.

select FIRST_NAME,LAST_NAME ,SALARY from employees where EMPLOYEE_ID<111

SELECT * FROM EMPLOYEES
SELECT E.FIRST_NAME,M.FIRST_NAME FROM EMPLOYEES E INNER JOIN EMPLOYEES M ON  M.EMPLOYEE_ID=E.MANAGER_ID  








--corelated queries
SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM DEPARTMENTS WHERE DEPARTMENT_NAME='IT')
order by FIRST_NAME

SELECT * FROM EMPLOYEES e WHERE exists(SELECT DEPARTMENT_ID FROM DEPARTMENTS d WHERE e.DEPARTMENT_ID=d.DEPARTMENT_ID and DEPARTMENT_NAME='EXECUTIVE')
ORDER BY FIRST_NAME


SELECT * FROM EMPLOYEES WHERE SALARY <=ALL(SELECT AVG(SALARY) FROM EMPLOYEES GROUP BY EMPLOYEE_ID)

SELECT * FROM EMPLOYEES WHERE SALARY >=ALL(SELECT AVG(SALARY) FROM EMPLOYEES GROUP BY EMPLOYEE_ID)

SELECT * FROM EMPLOYEES WHERE SALARY >ANY(SELECT SALARY FROM EMPLOYEES WHERE SALARY>4000)

SELECT * 
FROM EMPLOYEES e
WHERE EXISTS (
    SELECT 1 
    FROM DEPARTMENTS d 
    WHERE d.DEPARTMENT_ID = e.DEPARTMENT_ID
    AND d.LOCATION_ID = (
        SELECT LOCATION_ID 
        FROM LOCATIONS 
        WHERE CITY = 'Seattle'
    )
);

SELECT * FROM EMPLOYEES E WHERE EXISTS(SELECT 1 FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID AND D.LOCATION_ID=(SELECT LOCATION_ID FROM LOCATIONS WHERE CITY='Tokyo'))  

--cross apply  ---works like inner join
SELECT e.*, d.*
FROM EMPLOYEES e
CROSS APPLY (
    SELECT * FROM DEPARTMENTS d WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
) d;

--outer apply works like left join
SELECT e.*, d.*
FROM EMPLOYEES e
OUTER APPLY (
    SELECT * FROM DEPARTMENTS d WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
) d;
