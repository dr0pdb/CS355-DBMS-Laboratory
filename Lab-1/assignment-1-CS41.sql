/*
 Creation of database.
*/
CREATE DATABASE DBLAB;


/*
 Creation of tables.
*/
CREATE TABLE Paper_details (paper_id VARCHAR(20), paper_title VARCHAR(50), paper_type ENUM('conference', 'journal'), publication DATE);
CREATE TABLE Paper_author (paper_id VARCHAR(20), author_id VARCHAR(20));
c.CREATE TABLE Author_details (author_id VARCHAR(20), author_type ENUM('student', 'faculty'));
CREATE TABLE Student_details(student_id VARCHAR(20), student_name VARCHAR(20), student_institute VARCHAR(30), department VARCHAR(30), DOB DATE, research_area VARCHAR(30));
CREATE TABLE Faculty_details(faculty_id VARCHAR(20), faculty_name VARCHAR(30), faculty_institute VARCHAR(30), department VARCHAR(30), DOB DATE, research_area VARCHAR(30));
CREATE TABLE Supervisor(faculty_id VARCHAR(20), student_id VARCHAR(20));


/*
 Population of database.
*/
INSERT INTO Paper_details VALUES ('1','Paper-one','conference', '1997-12-09');
INSERT INTO Paper_details VALUES ('2','Paper-two','conference', '2004-12-09');
INSERT INTO Paper_details VALUES ('3','Paper-three','conference', '2007-04-01');
INSERT INTO Paper_details VALUES ('4','Paper-four','conference', '2015-10-05');
INSERT INTO Paper_details VALUES ('5','Paper-five','conference', '1777-11-08');
INSERT INTO Paper_details VALUES ('6','Paper-sixth','journal', '1991-01-05');
INSERT INTO Paper_details VALUES ('7','Paper-seven','journal', '1998-11-13');
INSERT INTO Paper_details VALUES ('8','Paper-eight','journal', '2009-08-17');
INSERT INTO Paper_details VALUES ('9','Paper-nine','journal', '2007-04-22');
INSERT INTO Paper_details VALUES ('10','Paper-ten','journal', '1777-05-26');


INSERT INTO Paper_author VALUES ('1', '1');
INSERT INTO Paper_author VALUES ('2', '3');
INSERT INTO Paper_author VALUES ('3', '2');
INSERT INTO Paper_author VALUES ('4', '6');
INSERT INTO Paper_author VALUES ('5', '5');
INSERT INTO Paper_author VALUES ('6', '4');
INSERT INTO Paper_author VALUES ('7', '7');
INSERT INTO Paper_author VALUES ('8', '8');
INSERT INTO Paper_author VALUES ('9', '9');
INSERT INTO Paper_author VALUES ('10', '10');


INSERT INTO Author_details VALUES ('1', 'student');
INSERT INTO Author_details VALUES ('2', 'student');
INSERT INTO Author_details VALUES ('3', 'student');
INSERT INTO Author_details VALUES ('4', 'student');
INSERT INTO Author_details VALUES ('5', 'student');
INSERT INTO Author_details VALUES ('6', 'faculty');
INSERT INTO Author_details VALUES ('7', 'faculty');
INSERT INTO Author_details VALUES ('8', 'faculty');
INSERT INTO Author_details VALUES ('9', 'faculty');
INSERT INTO Author_details VALUES ('10', 'faculty');


INSERT INTO Student_details VALUES ('1', 'name-kumar', 'Institute-one', 'department-one', '1977-05-26', 'Big Data');
INSERT INTO Student_details VALUES ('2', 'second-kumar', 'Institute-two', 'department-two', '1990-05-26', 'Big Data');
INSERT INTO Student_details VALUES ('3', 'third-kumar', 'Institute-three', 'department-three', '1987-05-26', 'Big Data');
INSERT INTO Student_details VALUES ('4', 'fourth-kumar', 'Institute-four', 'department-four', '1907-05-26', 'Big Data');
INSERT INTO Student_details VALUES ('5', 'fifth-kumar', 'Institute-five', 'department-five', '1970-05-26', 'AI');
INSERT INTO Student_details VALUES ('6', 'name', 'Institute-one', 'department-one', '1977-05-26', 'Algorithms');
INSERT INTO Student_details VALUES ('7', 'second', 'Institute-two', 'department-two', '1990-05-26', 'Data structures');
INSERT INTO Student_details VALUES ('8', 'third', 'Institute-three', 'department-three', '1987-05-26', 'AI');
INSERT INTO Student_details VALUES ('9', 'fourth', 'Institute-four', 'department-four', '1907-05-26', 'Cybersecurity');
INSERT INTO Student_details VALUES ('10', 'fifth', 'Institute-five', 'department-five', '1970-05-26', 'AI');


INSERT INTO Faculty_details VALUES ('1', 'name-kumar', 'Institute-one', 'department-one', '1977-05-26', 'Big Data');
INSERT INTO Faculty_details VALUES ('2', 'second-kumar', 'Institute-two', 'department-two', '1990-05-26', 'Big Data');
INSERT INTO Faculty_details VALUES ('3', 'third-kumar', 'Institute-three', 'department-three', '1987-05-26', 'Big Data');
INSERT INTO Faculty_details VALUES ('4', 'fourth-kumar', 'Institute-four', 'department-four', '1907-05-26', 'Big Data');
INSERT INTO Faculty_details VALUES ('5', 'fifth-kumar', 'Institute-five', 'department-five', '1970-05-26', 'AI');
INSERT INTO Faculty_details VALUES ('6', 'name', 'IIT Patna', 'department-one', '1977-05-26', 'Algorithms');
INSERT INTO Faculty_details VALUES ('7', 'second', 'Institute-two', 'department-two', '1990-05-26', 'Data structures');
INSERT INTO Faculty_details VALUES ('8', 'third', 'IIT Patna', 'department-three', '1987-05-26', 'AI');
INSERT INTO Faculty_details VALUES ('9', 'fourth', 'Institute-four', 'department-four', '1907-05-26', 'Cybersecurity');
INSERT INTO Faculty_details VALUES ('10', 'fifth', 'Institute-five', 'department-five', '1970-05-26', 'AI');


INSERT INTO Supervisor VALUES ('1', '1');
INSERT INTO Supervisor VALUES ('2', '2');
INSERT INTO Supervisor VALUES ('3', '3');
INSERT INTO Supervisor VALUES ('4', '5');
INSERT INTO Supervisor VALUES ('5', '4');
INSERT INTO Supervisor VALUES ('6', '6');
INSERT INTO Supervisor VALUES ('8', '7');
INSERT INTO Supervisor VALUES ('7', '8');
INSERT INTO Supervisor VALUES ('9', '9');
INSERT INTO Supervisor VALUES ('10', '10');


/*
	1. Adding primary key constraints.
*/
ALTER TABLE Paper_details ADD PRIMARY KEY(paper_id);
ALTER TABLE Author_details ADD PRIMARY KEY(author_id);
ALTER TABLE Student_details ADD PRIMARY KEY(student_id);
ALTER TABLE Faculty_details ADD PRIMARY KEY(faculty_id, research_area);
ALTER TABLE Paper_author ADD PRIMARY KEY(paper_id, author_id);
ALTER TABLE Supervisor ADD PRIMARY KEY(faculty_id, student_id);


/*
	2. Foreign key constraints.  
*/
ALTER TABLE Paper_author ADD FOREIGN KEY (paper_id) REFERENCES Paper_details(paper_id);
ALTER TABLE Paper_author ADD FOREIGN KEY (author_id) REFERENCES Author_details(author_id);
ALTER TABLE Supervisor ADD FOREIGN KEY (faculty_id) REFERENCES Faculty_details(faculty_id);
ALTER TABLE Supervisor ADD FOREIGN KEY (student_id) REFERENCES Student_details(student_id);


/*
	3. List the title of all conference papers.
*/
SELECT paper_title FROM Paper_details WHERE paper_type='conference'; 


/*
	4. Find the students whose research_area is “Big Data”.
*/
SELECT * FROM Student_details WHERE research_area='Big Data'; 


/*
	5. Find the total number of journal papers in the database.
*/
SELECT Count(*) FROM Paper_details WHERE paper_type='journal';


/*
	6. List the students whose DOB is between 1/4/1990 and 31/3/2000
*/
SELECT * FROM Student_details WHERE DOB >= '1990-04-01' AND DOB <= '2000-03-31'; 


/*
	7. List the faculties of IIT Patna and whose research area are “AI”
*/

SELECT * FROM Faculty_details WHERE research_area='AI' AND faculty_institute='IIT Patna';

/*
	8. List the faculties who work in both “AI” and “Big Data”
*/

SELECT * FROM Faculty_details WHERE research_area='AI' AND research_area='Big Data';

/*
	9. List the students whose name end with “Kumar”
*/
SELECT * FROM Student_details WHERE student_name like '%Kumar';

/*
	10. Show for each faculty, how many students are supervised under him/her.
*/
SELECT student_id FROM Supervisor WHERE faculty_id=1;
SELECT student_id FROM Supervisor WHERE faculty_id=2; 
SELECT student_id FROM Supervisor WHERE faculty_id=3; 
SELECT student_id FROM Supervisor WHERE faculty_id=4; 
SELECT student_id FROM Supervisor WHERE faculty_id=5; 
SELECT student_id FROM Supervisor WHERE faculty_id=6; 
SELECT student_id FROM Supervisor WHERE faculty_id=7; 
SELECT student_id FROM Supervisor WHERE faculty_id=8; 
SELECT student_id FROM Supervisor WHERE faculty_id=9; 
SELECT student_id FROM Supervisor WHERE faculty_id=10; 

/*
	11. List the paper_ids which have multiple authors.
*/
SELECT paper_id FROM Paper_author GROUP BY author_id HAVING COUNT(*) > 1;




