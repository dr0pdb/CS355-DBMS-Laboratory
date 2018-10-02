DROP DATABASE IF EXISTS lab9;

CREATE DATABASE lab9;

USE lab9;

CREATE TABLE Customer(
	customer_id INT PRIMARY KEY,
	customer_name VARCHAR(20),
	city VARCHAR(20),
	pincode VARCHAR(20),
	state VARCHAR(20),
	balance_due FLOAT(12, 3)
);

CREATE TABLE Product(
	product_code VARCHAR(20) PRIMARY KEY,
	product_name VARCHAR(20),
	qty_available INT,
	cost_price int,
	selling_price FLOAT(12,3)
);

CREATE TABLE Orders(
	order_number INT PRIMARY KEY,
	order_date DATE,
	customer_id int,
	product_code VARCHAR(20), 
	quantity int,
	foreign key (customer_id) references Customer(customer_id),
	foreign key (product_code) references Product(product_code)
);

/*
	1A.
*/
SHOW INDEXES FROM Customer;

CREATE UNIQUE INDEX customer_index
ON Customer(customer_id);

SHOW INDEXES FROM Customer;


/*
	1B.
*/
SHOW INDEXES FROM Orders;

CREATE UNIQUE INDEX order_index
ON Orders(order_number, customer_id, product_code);

SHOW INDEXES FROM Orders;


CREATE TABLE employees( 
	employee_id DECIMAL(6, 0),
	first_name VARCHAR(20),
	last_name VARCHAR(25) NOT NULL,
	email VARCHAR(25) NOT NULL,
	phone_number VARCHAR(20),
	hire_date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
	job_id VARCHAR(10) NOT NULL,
	salary DECIMAL(8,2) NOT NULL,
	commission_pct DECIMAL(2,2),
	manager_id DECIMAL(6,0),
	department_id DECIMAL(4, 0),
	dn VARCHAR(300),
	CONSTRAINT emp_salary_min_demo CHECK (salary > 0),
	CONSTRAINT emp_email_uk_demo UNIQUE (email),
	income DECIMAL(8,2) AS (salary + (salary*commission_pct))
);

SHOW INDEXES FROM employees;

CREATE INDEX income_ix
ON employees(income);

SHOW INDEXES FROM employees;

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct)
	VALUES (1, 'saurav', 'tiwary', 'one.cs16@iitp.ac.in', '2018-01-01 00:00:00', '1', 10000.5, 0.2);

INSERT INTO employees (employee_id, first_name, last_name, email, hire_date, job_id, salary, commission_pct)
	VALUES (2, 'random', 'user', 'two.cs16@iitp.ac.in', '2016-01-01 00:00:00', '2', 16000.5, 0.2);

/*
	2.
*/
SELECT first_name, last_name
FROM employees
WHERE income > 15000;