create database lab7;
use lab7;

create table STUDENT(ID INT, firstname varchar(15), lastname varchar(15), department varchar(20));
insert into STUDENT values(41, "Saurav", "Tiwary", "CSE");
insert into STUDENT values(26, "Shaurya", "Gupta", "CSE");
insert into STUDENT values(47, "Umesh", "Kumar", "EE");

select * from STUDENT;

delimiter //

create function full_name (lastname varchar(15), firstname varchar(15))
returns varchar(32) 
begin 
	return concat(lastname, ", ", firstname);
end; //

delimiter ;

/*
	1-a.
*/
SELECT full_name(lastname, firstname) from STUDENT;

/*
	1-b.
*/
SELECT firstname, lastname, full_name(lastname, firstname), id from STUDENT where department = "CSE";




/*
	2-a.
*/
delimiter //

create function root_calculation(a int, b int, c int)
returns varchar(20)
begin
	declare root1 float(6, 2);
	declare root2 float(6, 2);
	set root1 = ((-b + sqrt(b*b - 4*a*c))/(2*a));
	set root2 = ((-b - sqrt(b*b - 4*a*c))/(2*a));
	return concat(root1 , "_", root2);
end; //

delimiter ;

/*
	2-b.
*/
select root_calculation(1, 2, 2);

/*
	2-c.
*/
delimiter //

create function root_calculations(a int, b int, c int)
returns varchar(20)
begin
	declare root1 float(6, 2);
	declare root2 float(6, 2);
	declare d int;
	declare result varchar(20);
	set d = b*b - 4*a*c;
	if d < 0 then set result = 'Imaginary Roots'; 
	else set root1 = ((-b + sqrt(d))/(2*a)); set root2 = ((-b - sqrt(d))/(2*a)); set result = concat(root1 , "_", root2);
	end if;
	return result;
end; //

delimiter ;

select root_calculations(1, 2, 2);
