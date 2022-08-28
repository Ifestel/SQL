CREATE DATABASE IF NOT EXISTS Sales;

USE Sales;
 
CREATE TABLE Sales
(
purchase_number INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
date_of_purchase DATE NOT NULL,
customer_id INT,
item_code VARCHAR(10) NOT NULL
);

DROP TABLE Sales;
DROP TABLE customers;

-- Exercise 1

CREATE TABLE customers
(
customer_id INT,
first_name VARCHAR (255),
last_name VARCHAR (255),
email_address VARCHAR (255),
number_of_complaint INT
);
-- End

CREATE TABLE Sales (
    purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    PRIMARY KEY (purchase_number)
);

-- Excerise 2 Using Database and Tables

SELECT * FROM sales.customers;
SELECT * FROM sales.sales;

SELECT * FROM customers;
SELECT * FROM sales;
-- End

-- Additional Notes on Using Tables
-- Exercise 3
DROP TABLE sales;
-- End

--- PRIMARY KEY Constraint 
-- Exercise 4
DROP TABLE customers;

CREATE TABLE customers
(
customer_id INT,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address VARCHAR(255),
number_of_complaints INT,
PRIMARY KEY (customer_id)
);

CREATE TABLE items
(
item_code VARCHAR(255),
item VARCHAR(255),
unit_price NUMERIC(10,2),
company_id VARCHAR(255)
);

DROP TABLE companies;
CREATE TABLE companies
(
company_id VARCHAR(255),
company_name VARCHAR(255),
headquarters_pnone_number INT(12)
);
-- End

-- FOREIGN KEY Constraint
CREATE TABLE Sales (
    purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    PRIMARY KEY (purchase_number),
FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

DROP TABLE sales;
CREATE TABLE Sales (
    purchase_number INT AUTO_INCREMENT,
    date_of_purchase DATE,
    customer_id INT,
    item_code VARCHAR(10),
    PRIMARY KEY (purchase_number)
    );
    
ALTER TABLE sales
ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE;

ALTER TABLE sales
DROP FOREIGN KEY sales_ibfk_1;

-- Exercise 5
DROP TABLE sales;
DROP TABLE customers;
DROP TABLE items;
DROP TABLE companies;
-- End

-- Unique Constraint
CREATE TABLE customers
(
customer_id INT AUTO_INCREMENT,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address VARCHAR(255),
number_of_complaints INT,
PRIMARY KEY (customer_id),
UNIQUE KEY (email_address)
);

-- Exercise 6
DROP TABLE customers;
CREATE TABLE customers
(
customer_id INT,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address VARCHAR(255),
number_of_complaints INT,
PRIMARY KEY (customer_id),
UNIQUE KEY (email_address)
);

DROP TABLE customers;
CREATE TABLE customers
(
customer_id INT,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address VARCHAR(255),
number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
ADD UNIQUE KEY (email_address);

-- INDEXES

ALTER TABLE customers
DROP INDEX email_address;

-- Exercise 7
DROP TABLE customers;
CREATE TABLE customers
(
customer_id INT AUTO_INCREMENT,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address VARCHAR(255),
number_of_complaints INT,
PRIMARY KEY (customer_id)
);

-- Adding New Record To The Table
ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365datascience.com', 0);
-- End

SELECT * FROM customers;

 -- DEFAULT Constraint
DROP TABLE customers;
CREATE TABLE customers
(
customer_id INT AUTO_INCREMENT,
first_name VARCHAR(255),
last_name VARCHAR(255),
email_address VARCHAR(255),
number_of_complaints INT,
PRIMARY KEY (customer_id)
);

ALTER TABLE customers
CHANGE COLUMN number_of_complaints number_of_complaints INT DEFAULT 0;

ALTER TABLE customers
ADD COLUMN gender ENUM('M', 'F') AFTER last_name;

INSERT INTO customers (first_name, last_name, gender)
VALUES ('Peter', 'Figaro', 'M');

SELECT * FROM customers;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

-- Exercise 8
DROP TABLE companies;
CREATE TABLE companies
(
company_id VARCHAR(255),
company_name VARCHAR(255) DEFAULT 0,
headquarters_pnone_number VARCHAR (255),
UNIQUE KEY (headquarters_pnone_number) 
);
-- End

-- NOT NULL Constraint
DROP TABLE companies;
CREATE TABLE companies
(
company_id INT AUTO_INCREMENT,
headquarters_pnone_number VARCHAR (255),
company_name VARCHAR(255) NOT NULL,
PRIMARY KEY (company_id) 
);

ALTER TABLE companies
MODIFY company_name VARCHAR (255) NULL;

ALTER TABLE companies
CHANGE COLUMN company_name company_name VARCHAR (255) NOT NULL;

INSERT INTO companies (headquarters_phone_number, company_name)
VALUES ('+1 (202) 555-0196', 'Company A')
;

-- Exercise 9
ALTER TABLE companies
MODIFY headquarters_phone_number VARCHAR (255) NULL;

ALTER TABLE companies
CHANGE COLUMN headquarters_phone_number headquarters_phone_number VARCHAR (255) NOT NULL;

-- End





INSERT INTO customers (first_name, last_name, gender, email_address, number_of_complaints)
VALUES ('John', 'Mackinley', 'M', 'john.mckinley@365datascience.com', 0);

SELECT * FROM customers;

ALTER TABLE customers
ALTER COLUMN number_of_complaints DROP DEFAULT;

-- End

