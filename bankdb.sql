/* 620122735 */

/* clean up old tables;
   must drop tables with foreign keys first
   due to referential integrity constraints
 */
/*
DROP DATABASE IF EXISTS bankdb;
CREATE DATABASE bankdb;
USE bankdb;


drop table IF EXISTS depositor;
drop table IF EXISTS borrower;
drop table IF EXISTS cust_banker;
drop table IF EXISTS works_for;
drop table IF EXISTS savings_account;
drop table IF EXISTS checking_account;
drop table IF EXISTS account;
drop table IF EXISTS branch;
drop table IF EXISTS payment;
drop table IF EXISTS loan;
drop table IF EXISTS customer;
drop table IF EXISTS dependent_name cascade;
drop table IF EXISTS employee;
*/

/* derived from entities */
/*
create table account
   (account_number 	varchar(15)	not null unique,
    branch_name		varchar(15)	not null,
    balance 		decimal(10,2)	not null,
    status              varchar(15)     null,
    primary key(account_number));
*/
/* derived from ISA */
/*
create table savings_account
   (account_number 	varchar(15)	not null unique,
    interest_rate	decimal(5,2)	not null,
    primary key(account_number),
    foreign key(account_number) references account(account_number) on update cascade on delete cascade );

create table checking_account
   (account_number 	varchar(15)	not null unique,
    overdraft_amount	decimal(10,2)	not null,
    primary key(account_number),
    foreign key(account_number) references account(account_number) on update cascade on delete cascade);

create table branch
   (branch_name 	varchar(15)	not null unique,
    branch_city 	varchar(15)	not null,
    assets 		decimal(10,2)	not null,
    primary key(branch_name));

create table customer
   (customer_id 	varchar(15)	not null unique,
    customer_name 	varchar(15)	not null,
    customer_street 	varchar(12)	not null,
    customer_city 	varchar(15)	not null,
    primary key(customer_name));

 create table employee (
    employee_id 	varchar(15)	not null unique,
    employee_name       varchar(15)     not null,
    telephone_number    varchar(15)             ,
    start_date          date            not null,
    primary key(employee_id));
*/
 /* mulitvalued attribute */
 /*
 create table dependent_name ( employee_id  varchar(15) not null,
 d_name varchar(15) not null,
 primary key (employee_id, d_name),
 foreign key (employee_id) references employee(employee_id) on update cascade on delete cascade);

 create table loan
   (loan_number 	varchar(15)	not null unique,
    branch_name		varchar(15)	not null,
    amount 		decimal(10,2)	not null,
    primary key(loan_number));
 */
/* weak entity */
/*
create table payment
   (loan_number 	varchar(15)	not null,
    payment_number	varchar(15)	not null,
    payment_date        date            not null,
    payment_amount 	decimal(10,2)	not null,
    primary key(loan_number, payment_number),
    foreign key(loan_number)references loan(loan_number) on update cascade on delete restrict);
*/
/* derived from relationships */
/*
create table depositor
   (customer_id 	varchar(15)	not null,
    account_number 	varchar(15)	not null,
    access_date         date            not null,
    primary key(customer_id, account_number),
    foreign key(account_number) references account(account_number) on update cascade on delete restrict,
    foreign key(customer_id) references customer(customer_id) on update cascade on delete restrict);

create table borrower
   (customer_id 	varchar(15)	not null,
    loan_number 	varchar(15)	not null,
    primary key(customer_id, loan_number),
    foreign key(customer_id) references customer(customer_id) on update cascade on delete restrict,
    foreign key(loan_number) references loan(loan_number) on update cascade on delete restrict);

create table cust_banker
   (customer_id 	varchar(15)	not null,
    employee_id  	varchar(15)	not null,
    CBtype              varchar(30)     not null,
    primary key(customer_id, employee_id),
    foreign key(customer_id) references customer(customer_id) on update cascade on delete cascade,
    foreign key(employee_id) references employee(employee_id)on update cascade on delete restrict);

create table works_for
   (worker_employee_id 	varchar(15)	not null,
    manage_employee_id 	varchar(15)	not null,
    primary key(worker_employee_id),
    foreign key(worker_employee_id) references employee(employee_id) on update cascade on delete cascade,
    foreign key(manage_employee_id) references employee(employee_id)on update cascade on delete restrict);
*/
    /* populate relations */
   /* 
insert into customer	values ('CUS-00001',        'Jones',	'Main',		'Harrison');
insert into customer	values ('CUS-00002',        'Smith',	'Main',		'Rye');
insert into customer	values ('CUS-00003',        'Hayes',	'Main',		'Harrison');
insert into customer	values ('CUS-00004',        'Curry',	'North',	'Rye');
insert into customer	values ('CUS-00005',        'Lindsay',	'Park',		'Pittsfield');
insert into customer	values ('CUS-00006',        'Turner',	'Putnam',	'Stamford');
insert into customer	values ('CUS-00007',        'Williams',	'Nassau',	'Princeton');
insert into customer	values ('CUS-00008',        'Adams',	'Spring',	'Pittsfield');
insert into customer	values ('CUS-00009',        'Johnson',	'Alma',		'Palo Alto');
insert into customer	values ('CUS-00010',        'Glenn',	'Sand Hill',	'Woodside');
insert into customer	values ('CUS-00011',        'Brooks',	'Senator',	'Brooklyn');
insert into customer	values ('CUS-00012',        'Green',	'Walnut',	'Stamford');
insert into customer	values ('CUS-00013',        'Jackson',	'University',	'Salt Lake');
insert into customer	values ('CUS-00014',        'Majeris',	'First',	'Rye');
insert into customer	values ('CUS-00015',        'McBride',	'Safety',	'Rye');


insert into employee    values ('EM-001',        'Wayne Black',           '876-938-0100',  '2001/01/23');
insert into employee    values ('EM-002',        'Bob Cat',               '876-958-0623',  '1987/08/05');
insert into employee    values ('EM-003',        'Helen Mary',            '876-838-8936',  '1999/05/26');
insert into employee    values ('EM-004',        'Mary Sue',              '954-888-1523',  '2007/04/01');
insert into employee    values ('EM-005',        'Larry Brown',           '876-353-7855',  '1989/12/24');
insert into employee    values ('EM-006',        'Larry Jones',           '876-224-4536',  '2000/09/18');
insert into employee    values ('EM-007',        'Martha Stewart',        '876-463-7858',  '2001/08/13');
insert into employee    values ('EM-008',        'Sigmund Baker',         '876-221-7581',  '2001/02/11');
insert into employee    values ('EM-009',        'Maia Simone',           '876-999-0507',  '2007/04/09');
insert into employee    values ('EM-010',        'Angella Sweet',         '876-751-9632',  '1990/03/12');
insert into employee    values ('EM-011',        'Mary Sue',           '876-563-4237',  '1990/07/31');
insert into employee    values ('EM-012',        'Mary-Ann Jones',        '876-102-7863',  '1997/06/30');

insert into works_for values ('EM-001','EM-010');
insert into works_for values ('EM-002','EM-001');
insert into works_for values ('EM-003','EM-001');
insert into works_for values ('EM-004','EM-012');
insert into works_for values ('EM-005','EM-008');
insert into works_for values ('EM-006','EM-012');
insert into works_for values ('EM-007','EM-008');
insert into works_for values ('EM-008','EM-012');
insert into works_for values ('EM-009','EM-012');
insert into works_for values ('EM-010','EM-008');
insert into works_for values ('EM-011','EM-001');
insert into works_for values ('EM-012','EM-008');

insert into cust_banker values('CUS-00001','EM-011','Loan Manager/Personal Banker');
insert into cust_banker values('CUS-00002','EM-006','Loan Manager/Personal Banker');
insert into cust_banker values('CUS-00003','EM-012','Loan Manager/Personal Banker');
insert into cust_banker values('CUS-00004','EM-001','Personal Banker');
insert into cust_banker values('CUS-00005','EM-003','Personal Banker');
insert into cust_banker values('CUS-00006','EM-011','Personal Banker');
insert into cust_banker values('CUS-00007','EM-005','Loan Manager');
insert into cust_banker values('CUS-00008','EM-005','Loan Manager');
insert into cust_banker values('CUS-00009','EM-002','Personal Banker');
insert into cust_banker values('CUS-00010','EM-011','Personal Banker');
insert into cust_banker values('CUS-00011','EM-007','Personal Banker');
insert into cust_banker values('CUS-00012','EM-004','Personal Banker');
insert into cust_banker values('CUS-00013','EM-011','Loan Manager');
insert into cust_banker values('CUS-00014','EM-012','Loan Manager/Personal Banker');
insert into cust_banker values('CUS-00015','EM-011','Loan Manager');

insert into dependent_name     values ('EM-003', 'Mark Mary');
insert into dependent_name     values ('EM-003', 'Mary Mary');
insert into dependent_name     values ('EM-003', 'Hayes');
insert into dependent_name     values ('EM-009', 'Sanjay Simone');
insert into dependent_name     values ('EM-009', 'Bob Simone');
insert into dependent_name     values ('EM-009', 'Bob Brown');
insert into dependent_name     values ('EM-009', 'Cory Simone');
insert into dependent_name     values ('EM-008', 'George George');
insert into dependent_name     values ('EM-012', 'Kim Rankin');

insert into branch	values ('Downtown',	'Brooklyn',	 900000);
insert into branch	values ('Redwood',	'Palo Alto',	2100000);
insert into branch	values ('Perryridge',	'Horseneck',	1700000);
insert into branch	values ('Mianus',	'Horseneck',	 400200);
insert into branch	values ('Round Hill',	'Horseneck',	8000000);
insert into branch	values ('Pownal',	'Bennington',	 400000);
insert into branch	values ('North Town',	'Rye',		3700000);
insert into branch	values ('Brighton',	'Brooklyn',	7000000);
insert into branch	values ('Central',	'Rye',		 400280);

insert into account	values ('A-101',	'Downtown',	50000, '');
insert into account	values ('A-215',	'Mianus',	700, '');
insert into account	values ('A-102',	'Mianus',	415, '');
insert into account	values ('A-305',	'Round Hill',	350, '');
insert into account	values ('A-201',	'Perryridge',	9002, '');
insert into account	values ('A-222',	'Redwood',	7050, '');
insert into account	values ('A-217',	'Brighton',	750, '');
insert into account	values ('A-333',	'Central',	850, '');
insert into account	values ('A-444',	'North Town',	6525, '');
insert into account	values ('A-555',	'Downtown',	10000, '');

insert into savings_account values('A-101', 0.2);
insert into savings_account values('A-222', 0.5);
insert into savings_account values('A-102',0.1);

insert into checking_account values('A-201', 5000);
insert into checking_account values('A-555', 5000);
insert into checking_account values('A-444', 5000);

insert into depositor values ('CUS-00009',  'A-101', '2006/10/1');
insert into depositor values ('CUS-00002',  'A-215', '2005/09/23');
insert into depositor values ('CUS-00003',  'A-102', '2007/04/08');
insert into depositor values ('CUS-00003',  'A-101', '2005/01/06');
insert into depositor values ('CUS-00006',  'A-305', '2004/05/12');
insert into depositor values ('CUS-00009',  'A-201', '2006/02/17');
insert into depositor values ('CUS-00001',  'A-217', '2001/07/17');
insert into depositor values ('CUS-00006',  'A-222', '1990/10/01');
insert into depositor values ('CUS-00014',  'A-333', '1989/03/07');
insert into depositor values ('CUS-00002',  'A-444', '2007/04/30');
insert into depositor values ('CUS-00003',  'A-444', '2007/04/30');

insert into loan	values ('L-17',	'Downtown',	1000);
insert into loan	values ('L-23',	'Redwood',	2000);
insert into loan	values ('L-15',	'Mainus',	1500);
insert into loan	values ('L-14',	'Downtown',	1500);
insert into loan	values ('L-93',	'Mianus',	500);
insert into loan	values ('L-11',	'Round Hill',	900);
insert into loan	values ('L-16',	'Perryridge',	1300);
insert into loan	values ('L-20',	'North Town',	7500);
insert into loan	values ('L-21',	'Central',	570);

insert into payment values ('L-17', '001', '2007/01/01', 150.67);
insert into payment values ('L-17', '002', '2007/02/01', 150.23);
insert into payment values ('L-17', '003', '2007/03/01', 150.78);
insert into payment values ('L-23', '001', '2005/03/28', 400.02);
insert into payment values ('L-23', '002', '2005/04/28', 600.89);
insert into payment values ('L-23', '003', '2005/05/28', 50.90);
insert into payment values ('L-23', '004', '2005/05/28', 25.76);
insert into payment values ('L-15', '001', '2005/05/28', 135.26);

insert into borrower values ('CUS-00001',	'L-17');
insert into borrower values ('CUS-00002',	'L-23');
insert into borrower values ('CUS-00003',	'L-15');
insert into borrower values ('CUS-00013',	'L-14');
insert into borrower values ('CUS-00004',	'L-93');
insert into borrower values ('CUS-00002',	'L-11');
insert into borrower values ('CUS-00007',       'L-17');
insert into borrower values ('CUS-00008',	'L-16');
insert into borrower values ('CUS-00015',	'L-20');
insert into borrower values ('CUS-00002',	'L-21');
*/




/* Step 4 */
/*
SELECT DISTINCT customer.customer_name, depositor.account_number  
FROM depositor JOIN customer 
ON customer.customer_id = depositor.customer_id
WHERE depositor.access_date >= '2001-01-01' AND  depositor.access_date <= '2006-12-31';
*/

/* Step 4 Result 

+---------------+----------------+
| customer_name | account_number |
+---------------+----------------+
| Johnson       | A-101          |
| Smith         | A-215          |
| Hayes         | A-101          |
| Turner        | A-305          |
| Johnson       | A-201          |
| Jones         | A-217          |
+---------------+----------------+
6 rows in set (0.00 sec)

*/

/*Step 5*/
/*
DELIMITER //
CREATE PROCEDURE GetCustAcct(IN custName varchar(15))

BEGIN
SELECT DISTINCT depositor.account_number  
FROM depositor JOIN customer 
ON customer.customer_id = depositor.customer_id
WHERE depositor.access_date >= '2001-01-01' AND  depositor.access_date <= '2006-12-31' AND customer.customer_name=custName;

END //
DELIMITER ;
*/
/* Step 5 Results 

mysql> CALL GetCustAcct('Johnson');
+----------------+
| account_number |
+----------------+
| A-101          |
| A-201          |
+----------------+
2 rows in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> CALL GetCustAcct('Smith');
+----------------+
| account_number |
+----------------+
| A-215          |
+----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> CALL GetCustAcct('Hayes');
+----------------+
| account_number |
+----------------+
| A-101          |
+----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)

mysql> CALL GetCustAcct('Turner');
+----------------+
| account_number |
+----------------+
| A-305          |
+----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.01 sec)

mysql> CALL GetCustAcct('Jones');
+----------------+
| account_number |
+----------------+
| A-217          |
+----------------+
1 row in set (0.00 sec)

Query OK, 0 rows affected (0.00 sec)
*/

/*worker table*/
/*
create table worker(
    workerid int auto_increment not null,
    workername varchar(20),
    city varchar(20),
    salary decimal(8,2),
    primary key(workerid)
);
*/

/*results*/

/*
+------------------+
| Tables_in_bankdb |
+------------------+
| account          |
| borrower         |
| branch           |
| checking_account |
| cust_banker      |
| customer         |
| dependent_name   |
| depositor        |
| employee         |
| loan             |
| payment          |
| savings_account  |
| worker           |
| works_for        |
+------------------+
14 rows in set (0.00 sec)

+------------+--------------+------+-----+---------+----------------+
| Field      | Type         | Null | Key | Default | Extra          |
+------------+--------------+------+-----+---------+----------------+
| workerid   | int          | NO   | PRI | NULL    | auto_increment |
| workername | varchar(20)  | YES  |     | NULL    |                |
| city       | varchar(20)  | YES  |     | NULL    |                |
| salary     | decimal(8,2) | YES  |     | NULL    |                |
+------------+--------------+------+-----+---------+----------------+
*/

/*worker population */
/*
insert into worker(workername,city,salary) values('Paul','Delhi',10000);
insert into worker(workername,city,salary) values('John','Faarin',20000);
insert into worker(workername,city,salary) values('Rodney','York',15000);
insert into worker(workername,city,salary) values('Mark','Queens',35000);
insert into worker(workername,city,salary) values('Wayne','Hills',5000);
*/
/*worker population result
+----------+------------+--------+----------+
| workerid | workername | city   | salary   |
+----------+------------+--------+----------+
|        1 | Paul       | Delhi  | 10000.00 |
|        2 | John       | Faarin | 20000.00 |
|        3 | Rodney     | York   | 15000.00 |
|        4 | Mark       | Queens | 35000.00 |
|        5 | Wayne      | Hills  |  5000.00 |de
+----------+------------+--------+----------+
*/
/*worker_log table*/
/*
create table worker_log(
workername varchar(20),
log_time Time
);
*/
/*results
+------------------+
| Tables_in_bankdb |
+------------------+
| account          |
| borrower         |
| branch           |
| checking_account |
| cust_banker      |
| customer         |
| dependent_name   |
| depositor        |
| employee         |
| loan             |
| payment          |
| savings_account  |
| worker           |
| worker_log       |
| works_for        |
+------------------+

+------------+-------------+------+-----+---------+-------+
| Field      | Type        | Null | Key | Default | Extra |
+------------+-------------+------+-----+---------+-------+
| workername | varchar(20) | YES  |     | NULL    |       |
| log_time   | time        | YES  |     | NULL    |       |
+------------+-------------+------+-----+---------+-------+
2 rows in set (0.00 sec)
*/
/*
Delimiter $$
   CREATE TRIGGER Work_Trigger
   AFTER insert ON worker
   FOR EACH ROW
   BEGIN
   insert into worker_log(workername,log_time) values
   (new.workername,curtime());
   END $$

delimiter ;
*/
/*
insert into worker(workername,city,salary) values('Adam','Mars',8000);
*/

/*Step 6

The NEW keyword refers to the new and incoming information that is going to a specific table based on the if the value is under conditions INSERT, UPDATE, DELETE. 

The OLD keyword would refer to the information before its has been altered. The data would be in its current or previous state before the changes are applied.
*/


/*Step 7*/
/* Creating the bonus table.*/

/*
create table bonus(
   customer_id varchar(15),
   cust_bonus decimal(8,2)
);
*/


/* Creating the trigger. This trigger gives the new customers $1000 bonus when they are created.*/
/*
Delimiter $$
   CREATE TRIGGER bonus_Trigger
   AFTER insert ON customer
   FOR EACH ROW
   BEGIN
   insert into bonus(customer_id, cust_bonus) values
   (new.customer_id,1000.00);
   END $$

delimiter ;
*/


/*Creating the new customers*/
/*
insert into customer	values ('CUS-00016','Akio',	'Trinity',	'Seven');
insert into customer	values ('CUS-00017','Arata',	'Brooklyn',	'Tropics');
insert into customer	values ('CUS-00018','Lillith',	'Archivia',	'Mage');
insert into customer	values ('CUS-00019','Maki',	'Zenin',	'Kaisen');
*/

/* Results for the customer and bonus table
+-------------+---------------+-----------------+---------------+
| customer_id | customer_name | customer_street | customer_city |
+-------------+---------------+-----------------+---------------+
| CUS-00001   | Jones         | Main            | Harrison      |
| CUS-00002   | Smith         | Main            | Rye           |
| CUS-00003   | Hayes         | Main            | Harrison      |
| CUS-00004   | Curry         | North           | Rye           |
| CUS-00005   | Lindsay       | Park            | Pittsfield    |
| CUS-00006   | Turner        | Putnam          | Stamford      |
| CUS-00007   | Williams      | Nassau          | Princeton     |
| CUS-00008   | Adams         | Spring          | Pittsfield    |
| CUS-00009   | Johnson       | Alma            | Palo Alto     |
| CUS-00010   | Glenn         | Sand Hill       | Woodside      |
| CUS-00011   | Brooks        | Senator         | Brooklyn      |
| CUS-00012   | Green         | Walnut          | Stamford      |
| CUS-00013   | Jackson       | University      | Salt Lake     |
| CUS-00014   | Majeris       | First           | Rye           |
| CUS-00015   | McBride       | Safety          | Rye           |
| CUS-00016   | Akio          | Trinity         | Seven         |
| CUS-00017   | Arata         | Brooklyn        | Tropics       |
| CUS-00018   | Lillith       | Archivia        | Mage          |
| CUS-00019   | Maki          | Zenin           | Kaisen        |
+-------------+---------------+-----------------+---------------+

+-------------+------------+
| customer_id | cust_bonus |
+-------------+------------+
| CUS-00016   |    1000.00 |
| CUS-00017   |    1000.00 |
| CUS-00018   |    1000.00 |
| CUS-00019   |    1000.00 |
+-------------+------------+
*/


/*Step 8

To drop a trigger you would write DROP TRIGGER TRIGGERNAME where TRIGGERNAME is the name of the trigger you want to drop.

*/