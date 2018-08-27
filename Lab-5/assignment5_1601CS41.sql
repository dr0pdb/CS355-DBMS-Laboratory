create database SP;
use SP
create table supplier(sno varchar(4), sname varchar(15), city varchar(15), phone bigint,  email varchar(20));
create table parts(pno varchar(4), pname varchar(15), weight int, color varchar(10));
create table sp(sno varchar(4), pno varchar(4), qty int);

alter table supplier add primary key(sno);
alter table parts add primary key(pno);
alter table sp add primary key(sno, pno);
alter table sp add foreign key (pno) references parts(pno);
alter table sp add foreign key (sno) references supplier(sno);

insert into supplier values('s101', 'Saurav', 'btp', '1234567890', 'saurav@gmail.com');
insert into supplier values('s111', 'Shashank', 'hrd', '1234564380', 'shashank@yahoo.com');
insert into supplier values('s100', 'Shaurya', 'patna', '1234564380', 'shaurya@gmail.com');
insert into supplier values('s121', 'Raj', 'udp', '1554564380', 'raj@gmail.com');
insert into supplier values('s112', 'Nikhil', 'lck', '1654576380', 'nikhil@gmail.com');
insert into supplier values('s106', 'Siddharth', 'allh', '1634576380', 'siddharth@gmail.com');
insert into supplier values('s107', 'abacs', 'abcd', '1634577880', 'abacs@gmail.com');
insert into supplier values('s108', 'abbas', 'lahore', '1634532280', 'abbas@yahoo.com');

insert into parts values('p100', 'mouse', 500, 'black');
insert into parts values('p101', 'keyb', 900, 'black');
insert into parts values('p102', 'monitor', 2000, 'blue');
insert into parts values('p103', 'cpu', 4000, 'black');
insert into parts values('p104', 'mpad', 200, 'green');
insert into parts values('p105', 'table', 6050, 'yellow');
insert into parts values('p106', 'cable', 105, 'white');
insert into parts values('p107', 'projector', 3700, 'white');

insert into sp values('s100', 'p100', 10);
insert into sp values('s101', 'p101', 10);
insert into sp values('s106', 'p102', 10);
insert into sp values('s107', 'p103', 10);
insert into sp values('s108', 'p104', 10);
insert into sp values('s111', 'p105', 10);
insert into sp values('s112', 'p106', 10);
insert into sp values('s121', 'p107', 10);

/*
	1. Display only the numbers from sno.
*/ 
select substr(sno, 2) from supplier;

/*
	2. Display the sname with exactly two ‘a’.
*/
select sname from supplier where sname like '%a%a%' and sname not like '%a%a%a%';

/*
	3. Show sno and pno combination as followings‐ if sno is ‘s123’ and pno is ‘p10’ then display ‘sp12310’.
*/
select concat(substr(sno, 1, 1), substr(pno, 1, 1), substr(sno, 2), substr(pno, 2)) from sp;

/*
	4. Display the sno where the numerical part is a palindrome
*/
select sno from supplier where substr(sno, 2) = reverse(substr(sno, 2));

/*
	5. Display the sno of a given supplier as follows‐ if sno is ‘s123’ then display it as ‘suppl123’.
*/
select concat('suppl', substr(sno, 2)) from sp;

/*
	6. Display the phone in xxxxx‐xxxxx format.
*/
select concat(substr(phone, 1, 5), '-', substr(phone, 6)) from supplier;

/*
	7. For each sno, generate a key which starts with the last digit of sno, 5th and 8th digits of its phone number and ends with a random number between 0 to 99.
*/
select concat(substr(sno, -1, 1), substr(phone, 5, 1), substr(phone, 8, 1), floor(rand() * 100)) from supplier;

/*
	8. Assume that the weight unit in parts table is in 'gm'. Now display the weight unit in 'kg' by rounding off 2 digits.
*/
select round(weight/1000, 2) from parts;

/*
	9. Retrieve the domain name of the email of the suppliers. If the email is abc@gmail.com then retrieve only ‘gmail’.
*/
select substr(email, locate('@', email)+1, locate('.', substr(email, locate('@', email)+1))-1) from supplier;

/*
	10. Display a chart that will show the pno and its weight with asterisks (*). For
		example: if the weight is any value in {0,1,2,...,9} then use ‘*’, if the weight is any value in
		{10,11,12,...,19} use ‘**’, if the weight is any value in {20,21,22,...,29 use ‘***’ and so on.
*/
select pno, repeat('*', (weight div 1000) + 1) from parts;
