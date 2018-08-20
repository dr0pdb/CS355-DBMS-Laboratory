-- DROP DATABASE SP;

CREATE DATABASE SP;

USE SP;

CREATE TABLE supplier (
	sno VARCHAR(20) PRIMARY KEY,
	sname VARCHAR(20),
	city VARCHAR(20),
	phone VARCHAR(10),
	email VARCHAR(255),
	dob DATE
);

CREATE TABLE parts (
	pno VARCHAR(20) PRIMARY KEY,
	pname VARCHAR(20),
	weight DECIMAL(10, 2),
	color VARCHAR(20),
	dom DATE
);

CREATE TABLE sp (
	pno VARCHAR(20),
	sno VARCHAR(20),
	qty INT,
	dos DATE,
	PRIMARY KEY (sno, pno),
	FOREIGN KEY (pno) REFERENCES parts(pno),
	FOREIGN KEY (sno) REFERENCES supplier(sno)
);

INSERT INTO supplier VALUES(
	's123',
	'Supplier one',
	'Patna',
	'0000000000',
	'email@example.com',
	'1990-03-04'
);

INSERT INTO supplier VALUES(
	's101',
	'Supplier two',
	'New york',
	'0000000023',
	'email2@example.com',
	'1994-03-10'
);

INSERT INTO supplier VALUES(
	's111',
	'Supplier three',
	'Mumbai',
	'1300800000',
	'email3@example.com',
	'1980-03-04'
);

INSERT INTO supplier VALUES(
	's150',
	'Supplier four',
	'Bangalore',
	'1300800330',
	'email3@example.com',
	'1985-03-04'
);

SELECT * FROM supplier;

INSERT INTO parts VALUES(
	'p101',
	'Headphones',
	'10.10',
	'RED',
	'2005-03-04'
);

INSERT INTO parts VALUES(
	'p111',
	'Screw drivers',
	'1.01',
	'SILVER',
	'2012-03-04'
);

INSERT INTO parts VALUES(
	'p123',
	'Tires',
	'15.25',
	'BLACK',
	'1995-03-04'
);

SELECT * FROM parts;

INSERT INTO sp VALUES(
	'p101',
	's101',
	10,
	'2014-03-04'
);

INSERT INTO sp VALUES(
	'p111',
	's101',
	15,
	'2004-03-04'
);

INSERT INTO sp VALUES(
	'p123',
	's101',
	5,
	'2012-03-04'
);

INSERT INTO sp VALUES(
	'p101',
	's111',
	13,
	'2016-03-04'
);


INSERT INTO sp VALUES(
	'p101',
	's123',
	8,
	'2004-03-04'
);


SELECT * FROM sp;


/*
	1, Find the name of the youngest supplier.
*/
SELECT sname FROM supplier ORDER BY dob DESC LIMIT 1;

/*
	2. Find the details of the suppliers who are more than 30 years old.
*/
SELECT * 
FROM supplier
WHERE DATE_SUB(CURDATE(), INTERVAL 30 YEAR) > dob;

/*
	3. Show the average age of the suppliers from each city.
*/
SELECT city, AVG(DATEDIFF(CURDATE(), dob) / 365.25) AS average_age
FROM supplier
GROUP BY city;


/*
	4. Find the name of the suppliers who have supplied parts in the year 2012.
*/
SELECT sname
FROM supplier
LEFT JOIN sp ON supplier.sno = sp.sno
WHERE YEAR(sp.dos) = 2012;

/*
	5. Find the name of the suppliers who have supplied parts after 1st Feb‐2015.
*/
SELECT sname
FROM supplier
LEFT JOIN sp ON supplier.sno = sp.sno
WHERE sp.dos >= '2015-02-01';

/*
	6. Find the name of the most recently supplied parts.
*/
SELECT pname
FROM parts
LEFT JOIN sp ON parts.pno = sp.pno
ORDER BY sp.dos;

/*
	7. Find the name of the suppliers who have supplied atleast two parts and one part is supplied within 30 days of supply of previous part.
*/
SELECT sname
FROM (
	SELECT DISTINCT s1.sno FROM sp s1
	JOIN sp s2 ON s1.sno = s2.sno AND s1.pno != s2.pno AND DATEDIFF(s1.dos, s2.dos) <= 30
) AS tbl
JOIN supplier on tbl.sno = supplier.sno;

/*
	8. If the warranty period is 3 months from the date of supply then show the warranty expiry date of each items supplied.
*/
SELECT sp.sno, sp.pno, parts.pname ,DATE_ADD(sp.dos, INTERVAL 3 MONTH) AS warranty_expiry_date
FROM sp
LEFT JOIN parts ON sp.pno = parts.pno;


/*
	9. If the warranty period is 3 months from the date of supply then show the part no. (supplied by ‘s123’) that are still under warranty.
*/
SELECT sp.pno
FROM sp
LEFT JOIN parts ON sp.pno = parts.pno
LEFT JOIN supplier ON supplier.sno = sp.sno
WHERE PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM NOW()), EXTRACT(YEAR_MONTH FROM sp.dos)) <= 3 AND supplier.sno = 's123';


/*
	10. Show the name of the suppliers who have supplied more than 6 months old items.
*/
SELECT supplier.sname
FROM sp
LEFT JOIN supplier ON supplier.sno = sp.sno
LEFT JOIN parts ON parts.pno = sp.pno
WHERE PERIOD_DIFF(EXTRACT(YEAR_MONTH FROM sp.dos), EXTRACT(YEAR_MONTH FROM parts.dom)) > 6;