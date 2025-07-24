/*Online Retail Sales Database Design*/
create database ecomdb;
use ecomdb;
create table customers(
customer_id int auto_increment primary key,
cust_name varchar(200),
email varchar(200) unique,
phone varchar(200),
address text);

insert into customers(cust_name, email, phone, address) 
values('Sukhveer Kaur', 'sukhveer@example.com', '9876543210', 'Mohali'),
('John Doe', 'john@example.com', '9123456789', 'Delhi'),
('Nitya', 'nitya@example.com', '9153656789', 'Delhi'),
('Ayush', 'ayush@example.com', '9123456779', 'Mohali');

select * from customers;

create table products(
product_id int auto_increment primary key,
pro_name varchar(100),
description text,
price decimal(10,2),
stock_quantity int);

INSERT INTO Products (pro_name, description, price, stock_quantity) VALUES
('Laptop', 'Intel i5, 8GB RAM', 55000.00, 20),
('Mouse', 'Wireless Mouse', 700.00, 100),
('Mobile', 'Iphone', 80000.00, 80),
('Watch', 'Apple', 20000.00, 80);

select * from products;

create table orders(
order_id int auto_increment primary key,
customer_id int,
order_date date,
status varchar(50),
foreign key(customer_id) references customers(customer_id));

select * from customers;

INSERT INTO Orders (customer_id, order_date, status) VALUES
(5, '2025-07-08', 'Shipped'),
(6, '2025-07-09', 'Processing'),
(7, '2025-07-08', 'Shipped'),
(8, '2025-07-09', 'Processing');

select * from orders;

create table order_item(
order_item_id int auto_increment primary key,
order_id int,
product_id int,
quantity int,
unit_price decimal(10,2),
foreign key(order_id) references orders(order_id),
foreign key(product_id) references products(product_id));

INSERT INTO Order_Item (order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 55000.00),
(2, 2, 2, 700.00),
(3, 3, 1, 700.00),
(4, 4, 1, 80000.00);

select * from order_item;

/* Total Sales Report*/

select 
customers.cust_name,
orders.order_id,
orders.order_date,
sum(order_item.quantity * order_item.unit_price) as total
from orders
join customers on customers.customer_id=orders.customer_id
join order_item on orders.order_id=order_item.order_id
group by customers.cust_name, orders.order_id, orders.order_date;

/* Total Revenue*/
create view product_sales as 
select
products.pro_name,
sum(order_item.quantity) as total_sold,
sum(order_item.quantity * order_item.unit_price) as revenue
from order_item
join products on order_item.product_id=products.product_id
group by products.pro_name;

select * from product_sales;