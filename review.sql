create database review;
use review;

CREATE TABLE Users (
    user_id INT PRIMARY KEY IDENTITY(1,1),
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY IDENTITY(1,1),
    product_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL
);


CREATE TABLE Orders (
    order_id INT PRIMARY KEY IDENTITY(1,1),
    user_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    order_date DATE NOT NULL,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
INSERT INTO Users (username, email) VALUES
('Alice', 'alice@example.com'),
('Bob', 'bob@example.com'),
('Charlie', 'charlie@example.com');

select * from Users;

INSERT INTO Products (product_name, price) VALUES
('Laptop', 80000.00),
('Mobile', 25000.00),
('Headphones', 3000.00);

select * from Products;

INSERT INTO Orders (user_id, product_id, quantity, order_date) VALUES
(1, 1, 1, '2024-04-01'), -- Alice buys 1 Laptop
(1, 2, 2, '2024-04-02'), -- Alice buys 2 Mobiles
(2, 3, 1, '2024-04-03'), -- Bob buys 1 Headphones
(3, 2, 1, '2024-04-04'); -- Charlie buys 1 Mobile


select * from Users;

select * from Products;
select * from Orders;

--Find all orders placed by 'Alice'.

select * from Orders o inner join Users u on u.user_id=o.user_id 
inner join Products p on o.product_id =p.product_id 
where u.username='alice'

--
select * from Products;
select * from Products order by price desc