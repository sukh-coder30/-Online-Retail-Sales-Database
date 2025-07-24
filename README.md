# -Online-Retail-Sales-Database
# Project Document: eCommerce Database (ecommerceDB)
 # Project Title:
eCommerceDB – Online Retail Sales Database
# Objective:
The objective of this project is to design and implement a relational database schema for an eCommerce platform that manages customers, products, categories, orders, payments, and sales reports in a normalized and efficient manner.
 Tools Used:
•	DBMS: MySQL
•	Language: SQL
•	Tool: MySQL Workbench / phpMyAdmin / CLI
 # Entity Relationship Overview:
1. Customers
•	Stores customer information.
2. Categories
•	Stores product category information.
3. Product
•	Stores product details and links to category.
4. Orders
•	Captures customer orders.
5. OrderItems
•	Maps products to orders with quantities and prices.
6. Payments
•	Tracks payments made for orders.

# Database Schema (DDL)
-- Create Database
CREATE DATABASE ecommerceDB;
USE ecommerceDB;

-- Customers Table
CREATE TABLE customers (
    cust_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_name VARCHAR(100) NOT NULL,
    Email VARCHAR(50) UNIQUE,
    Phone VARCHAR(50),
    Address TEXT
);

-- Categories Table
CREATE TABLE categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    category_name VARCHAR(50) NOT NULL
);

-- Product Table
CREATE TABLE product (
    product_id INT AUTO_INCREMENT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    Description TEXT,
    price DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES categories(category_id)
);

-- Orders Table
CREATE TABLE orders (
    order_id INT AUTO_INCREMENT PRIMARY KEY,
    cust_id INT,
    Total_amount DECIMAL(10,2),
    status VARCHAR(30),
    FOREIGN KEY (cust_id) REFERENCES customers(cust_id)
);

-- Order Items Table
CREATE TABLE orderitems (
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product(product_id)
);

Payment Table
CREATE TABLE payment (
    pay_id INT AUTO_INCREMENT PRIMARY KEY,
    order_id INT,
    pay_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    Amount DECIMAL(10,2),
    Paymentmethod VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);







