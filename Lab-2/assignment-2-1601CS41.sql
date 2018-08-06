/*
 Creation of database.
*/
CREATE DATABASE DBLAB;


/*
 Creation of tables.
*/
CREATE TABLE Paper_details (paper_id VARCHAR(20), paper_title VARCHAR(50), paper_type ENUM('conference', 'journal'), publication DATE);
CREATE TABLE Paper_author (paper_id VARCHAR(20), author_id VARCHAR(20));
CREATE TABLE Author_details (author_id VARCHAR(20), author_type ENUM('student', 'faculty'));
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
INSERT INTO Paper_author VALUES ('11', '11');


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
INSERT INTO Author_details VALUES ('11', 'student');


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
INSERT INTO Student_details VALUES ('11', 'sixth', 'IIT Patna', 'department-four', '1907-05-26', 'Cybersecurity');


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
INSERT INTO Faculty_details VALUES ('11', 'sixth', 'IISC Bangalore', 'CSE', '1970-05-26', 'AI');
INSERT INTO Faculty_details VALUES ('102', 'seventh', 'IISC Bangalore', 'CSE', '1970-05-26', 'AI');


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
INSERT INTO Supervisor VALUES ('102', '11');


/*
	Adding primary key constraints.
*/
ALTER TABLE Paper_details ADD PRIMARY KEY(paper_id);
ALTER TABLE Author_details ADD PRIMARY KEY(author_id);
ALTER TABLE Student_details ADD PRIMARY KEY(student_id);
ALTER TABLE Faculty_details ADD PRIMARY KEY(faculty_id, research_area);
ALTER TABLE Supervisor ADD PRIMARY KEY(faculty_id, student_id);


/*
	Foreign key constraints.  
*/
ALTER TABLE Paper_author ADD FOREIGN KEY (paper_id) REFERENCES Paper_details(paper_id);
ALTER TABLE Paper_author ADD FOREIGN KEY (author_id) REFERENCES Author_details(author_id);
ALTER TABLE Supervisor ADD FOREIGN KEY (faculty_id) REFERENCES Faculty_details(faculty_id);
ALTER TABLE Supervisor ADD FOREIGN KEY (student_id) REFERENCES Student_details(student_id);


/*
	1. Display the faculty details for those faculties who have not supervised any student.
*/
SELECT * FROM Faculty_details LEFT JOIN Supervisor on Faculty_details.faculty_id = Supervisor.faculty_id WHERE student_id IS NULL;


/*
	2. List the details of students who are from IIT Patna and also have published paper.
*/
SELECT * FROM Student_details LEFT JOIN Author_details on Student_details.student_id = Author_details.author_id WHERE student_institute='IIT Patna' AND author_type='student';


/*
	3. List of all the papers published by a student with id = "1501CS60"
*/
SELECT *
FROM ((Paper_details pd
INNER JOIN Paper_author pa ON pa.paper_id = pd.paper_id)
INNER JOIN Author_details ad ON ad.author_id = pa.author_id)
WHERE pa.author_id = '1501CS60' AND ad.author_type = 'student';


/*
	4. List of all the students who have published conference paper under the guidance of faculty with id=102
*/
SELECT *
FROM ((Student_details sd
INNER JOIN Supervisor su ON su.student_id = sd.student_id)
INNER JOIN Faculty_details fd ON fd.faculty_id = su.faculty_id)
WHERE su.faculty_id = '102';


/*
	5. List the titles of the papers which are authored by a single author.
*/
SELECT pd.paper_title
FROM Paper_details pd
INNER JOIN Paper_author pa ON pa.paper_id = pd.paper_id
GROUP BY pd.paper_id, pa.author_id
having COUNT(pa.author_id)=1;

/*
	6. List the faculty_id and the corresponding number of papers published by that faculty.
*/
SELECT author_id, count(paper_id) FROM Paper_author WHERE author_id IN (SELECT author_id FROM Author_details WHERE author_type='faculty') GROUP BY author_id;


/*
	7. Display the author_id with maximum number of papers.
*/
SELECT author_id FROM Paper_author GROUP BY author_id ORDER BY count(paper_id) DESC LIMIT 1;

/*
	8. Display the details of all the students who have no publication.
*/
SELECT * FROM Student_details WHERE student_id NOT IN (SELECT author_id FROM Author_details WHERE author_type='student');

/*
	9. List the students who are guided by two faculties.
*/
SELECT * FROM Student_details WHERE student_id IN (SELECT student_id FROM Supervisor GROUP BY student_id having COUNT(student_id)=2);


/*
	10. Count the number of papers published by the faculties of research area "Big Data".
*/
SELECT COUNT(*) FROM Paper_author WHERE author_id IN (SELECT author_id FROM Author_details WHERE author_type='faculty') AND author_id IN (SELECT author_id FROM Faculty_details WHERE research_area='Big Data'); 


/*
	11. Display the research areas of the faculties in descending order based on the total number of papers published.
*/
SELECT Faculty_details.research_area FROM Faculty_details 
INNER JOIN (SELECT author_id, count(paper_id) as n FROM Paper_author GROUP BY author_id) Paper_author ON Faculty_details.faculty_id = Paper_author.author_id ORDER BY Paper_author.n DESC; 

/*
	12. Display the faculty details who has guided maximum number of student.
*/ 
SELECT * FROM Faculty_details WHERE faculty_id = (SELECT faculty_id FROM Supervisor GROUP BY faculty_id ORDER BY count(student_id) DESC LIMIT 1);