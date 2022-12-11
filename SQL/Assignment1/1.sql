-- Assignment 1:
drop database banking;

-- 1. Create Schema

-- Create new database called 'banking' and use it
CREATE DATABASE banking;
USE banking;


-- a) Design all tables with appropriate keys and constraints.
-- Create table 'branch' with 'branch_name' as primary key
CREATE TABLE branch(branch_name VARCHAR(50) PRIMARY KEY, 
					branch_city VARCHAR(50), 
                    asset_value BIGINT NOT NULL);

-- Create table for 'customer' with 'customer_name' as primary key, assiming no two or more customers can have same value
CREATE TABLE customer(customer_name VARCHAR(50) PRIMARY KEY, 
					  customer_street VARCHAR(50), 
                      customer_city VARCHAR(50) NOT NULL);

-- Create 'account' table with account_number as primary key, 
-- customer name is refereced from customer table, branch name is referenced from branch table as foreign key, 
-- default balance for new accounts is 0
CREATE TABLE account(account_number INT PRIMARY KEY, 
					 customer_name VARCHAR(50) NOT NULL, 
                     branch_name VARCHAR(50), 
                     balance DOUBLE DEFAULT 0, 
					 FOREIGN KEY fk_cust_name(customer_name) REFERENCES customer(customer_name), 
					 FOREIGN KEY fk_branch_nmae(branch_name) REFERENCES branch(branch_name));

-- Insert data into the tables
INSERT INTO branch VALUES 
			('Chi-1', 'Chicago', 10000), 
            ('Chi-2', 'Chicago', 20000),
            ('Atl-1', 'Atlanta', 25000),
            ('Atl-2', 'Atlanta', 23000),
			('Was-1', 'Washington', 35000),
            ('Was-2', 'Washington', 36000),
            ('Nyc-1', 'New York', 45000),
            ('Nyc-2', 'New York', 46000);

-- Insert data into the tables
INSERT INTO customer VALUES 
			('John', 'Street 1', 'New York'), 
            ('Nick', 'Atl street 2', 'Atlanta'),
            ('Harry', 'First street', 'Chicago'),
            ('Ron', 'North street', 'Washington'),
			('David', 'Second street', 'Chicago'),
            ('Natasha', 'Green lane', 'Atlanta');
            
-- Insert data into account table
INSERT INTO account VALUES
			(1, 'John', 'Nyc-1', 1400),
            (2, 'Nick', 'Atl-2', 1800),
            (3, 'Harry', 'Chi-1', 1000),
            (4, 'Ron', 'Was-1', 500),
            (5, 'David', 'Chi-2', 1500),
            (6, 'Natasha', 'Atl-1', 1100);

-- Query inserted data
SELECT * FROM branch; SELECT * FROM account; SELECT * FROM customer;

-- b) Find the names of all branches located in “Chicago”
SELECT branch_name FROM branch WHERE branch_city='Chicago';

-- c) Add new customer in branch “Atlanta”, Consider appropriate values for other attributes.
INSERT INTO customer VALUES ('Tony', 'Silver street', 'Atlanta');
INSERT INTO account VALUES (7, 'Tony', 'Atl-2', 1200);
SELECT * FROM account;

-- d) Find all the account numbers having balance greater than $1000
SELECT * FROM account WHERE balance > 1000;

use banking;
-- e) Create a view to retrieve all the customers in “Atlanta” city with balance less than balance of customer “John”. (subquery)
CREATE VIEW bal_less_than_john_atlanta AS 
	SELECT * FROM account WHERE 
		balance < (SELECT balance FROM account WHERE customer_name='John') AND 
		branch_name IN (SELECT branch_name FROM branch WHERE branch_city='Atlanta');

SELECT * FROM bal_less_than_john_atlanta;

-- f) Modify the relations so that the default branch city will be “Washington”.
ALTER TABLE branch ALTER branch_city SET DEFAULT 'Washington';

-- g) Get the list of all customers only if the asset value for that branch is $35000 (EXISTS clause).
SELECT * FROM customer WHERE EXISTS (SELECT asset_value FROM branch WHERE asset_value = 35000)
