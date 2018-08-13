CREATE DATABASE DBLAB;

USE DBLAB;

CREATE TABLE Product (
	productId int NOT NULL,
	productName varchar(50),
	categoryName varchar(50),
	packageDesc varchar(50),
	price decimal(9,2),
	PRIMARY KEY (ProductId)
);

CREATE TABLE Customer (
	customerId int NOT NULL PRIMARY KEY,
	password VARCHAR(20) NOT NULL,
	cname VARCHAR(50) NOT NULL,
	street VARCHAR(50),
	city VARCHAR(20),
	state VARCHAR(2),
	zipcode VARCHAR(10),
	phone VARCHAR(10),
	email VARCHAR(30) NOT NULL
);

CREATE TABLE Orders (
	orderId int NOT NULL AUTO_INCREMENT PRIMARY KEY,
	customerId int,
	totalAmount decimal(9,2),
	CONSTRAINT FK_Orders_Customer FOREIGN KEY (customerId) REFERENCES
	Customer(customerId)
);

CREATE TABLE OrderedProduct (
	orderId int NOT NULL,
	productId int NOT NULL,
	quantity int,
	price decimal(9,2),
	PRIMARY KEY (OrderId, ProductId),
	CONSTRAINT FK_OrderedProduct_Order FOREIGN KEY (OrderId) REFERENCES
	Orders(OrderId),
	CONSTRAINT FK_OrderedProduct_Product FOREIGN KEY (ProductId) REFERENCES
	Product (ProductId)
);

INSERT INTO Product VALUES (1,'Laptop','Accessories', 'A laptop', 10.03);
INSERT INTO Product VALUES (2,'Mobile Phone','Accessories', 'A phone', 1.13);
INSERT INTO Product VALUES (3,'CS101','Books', 'A CS101 book', 0.05);
INSERT INTO Product VALUES (4,'CS355','Books', 'A CS355 book', 1.00);


INSERT INTO Customer VALUES (1, 'pass1','Customer one', 'street one', 'city one', 's1', 'z1', 'phone one', 'email@email.com');
INSERT INTO Customer VALUES (2, 'pass2','Customer two', 'street two', 'city two', 's2', 'z2', 'phone two', 'email2@email.com');
INSERT INTO Customer VALUES (3, 'pass3','Customer three', 'street three', 'city three', 's3', 'z3', 'phone_thr', 'email3@email.com');
INSERT INTO Customer VALUES (4, 'pass4','Customer four', 'street four', 'city four', 's4', 'z4', 'phonefour', 'email4@email.com');

INSERT INTO Orders VALUES (1, 1, 0);
INSERT INTO Orders VALUES (2, 2, 0);
INSERT INTO Orders VALUES (3, 3, 0);
INSERT INTO Orders VALUES (4, 4, 0);

/*
	1. Create a trigger that updates Orders.totalAmount whenever there is any change to the OrderedProduct table.
*/
CREATE TRIGGER after_ordered_product_insert AFTER INSERT ON OrderedProduct
	FOR EACH ROW 
	UPDATE Orders
	SET totalAmount = totalAmount + NEW.quantity * NEW.price
	WHERE orderId = NEW.orderId;

CREATE TRIGGER after_ordered_product_update AFTER UPDATE ON OrderedProduct
	FOR EACH ROW 
	UPDATE Orders
	SET totalAmount = totalAmount + NEW.quantity * NEW.price - OLD.quantity * OLD.price
	WHERE orderId = NEW.orderId;

CREATE TRIGGER before_ordered_product_delete BEFORE DELETE ON OrderedProduct
	FOR EACH ROW 
	UPDATE Orders
	SET totalAmount = totalAmount - OLD.quantity * OLD.price
	WHERE orderId = OLD.orderId;

INSERT INTO OrderedProduct VALUES(1, 1, 3, 10.03);

SELECT * FROM Orders;

INSERT INTO OrderedProduct VALUES(2, 2, 2, 1.13);

SELECT * FROM Orders;

UPDATE OrderedProduct
	SET quantity = 3
	WHERE OrderId = 2 AND ProductId = 2;
	
SELECT * FROM Orders;
	
DELETE FROM OrderedProduct
	WHERE OrderId = 2 AND ProductId = 2;

SELECT * FROM Orders;


/*
	2. Create a trigger that deletes all Orders and OrderedProduct records for a customer if that customer is deleted from the database.
*/
CREATE TRIGGER before_customer_delete BEFORE DELETE ON Customer
	FOR EACH ROW 
    DELETE FROM Orders
	WHERE customerId = OLD.customerId;

SELECT * FROM Orders;

CREATE TRIGGER before_order_delete BEFORE DELETE ON Orders
	FOR EACH ROW
	DELETE FROM OrderedProduct
	WHERE orderId = OLD.orderId;
	
SELECT * FROM OrderedProduct;
