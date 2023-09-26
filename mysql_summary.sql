/*                                         DBMS SUMMARY OF FULL COURSE
*/
create database new_db;  -- creating a database
use new_db;              -- using that database we have created
-- Adding a table in out database and inserting column to table
create table tb1(Sno int, name varchar(10), sal decimal(8,2) );
select * from tb1;       -- it display the table

-- insert values into table
insert into tb1 values(1,'Krishan',100),(2,'Ajay',50.5),(3,'Anam',66.6);
select * from tb1;

-- changing dtype of any column
alter table tb1 modify name char(8);
desc tb1; -- it describe the table

-- add a column
alter table tb1 add column age int; -- we can also add (after name)

-- drop column 
alter table tb1 drop age;

-- rename a table 
rename table tb1 to tb;

select * from tb;  -- calling it by new name

-- inserting null value
insert into tb values(4,'Ankur',null);
select * from tb;

-- where functin in sql
select * from tb where sno>1;  -- selecting table/column with some condition
select * from tb where sno=1;

-- order by function in sql
select * from tb order by sal;  -- order by arrange the table into ascending or descending(by default ascending)
select * from tb order by sal desc;

-- order by nd where  function together
select * from tb where sno>1 order by sal desc;


-- updateinng the inserted value in the table
update tb set name='Avi' where sno =2;  -- update the name 
set sql_safe_updates=0;

-- ------------------------------------------------------------------------
-- Using HR database 
use hr;
show tables;

select * from  employees;  -- employees is one of the table in hr database

select employee_id,salary from employees;  -- display specific column which we call

-- alias in mysql
select employee_id id,salary as sal from employees;  -- id and sal are the alias which given by user
select employee_id id,salary, salary +1000 net from employees;   -- perform arithmetic operation


-- Adding the selected data from one table to another table

create table output as 
select employee_id id,salary, salary +1000 net from employees;

select * from output;  -- display that table

-- where function and order by on hr databaase
select department_id,salary from employees where department_id in (50,80) and salary>8000;

select first_name,salary from employees order by first_name desc,salary desc;

-- limit  (specify the number of records to return)
select * from employees limit 5;  -- give 5 top 5 records
select first_name,salary from employees order by salary desc limit 5; -- give 5 top 5 records
select first_name,salary from employees order by salary desc limit 5,3;  -- give 6,7,8th record 


-- -----------------------------------------------------------

-- Distinct Function (Unique or remove duplicates)

create table tb1(sno int ,sal int);
insert into tb1 values(1,1000),(1,2000),(2,1000),(1,1000);
select * from tb1;

select distinct * from tb1;  -- It remove duplicate value

select distinct sal from tb1;  -- It remove duplicate sal

-- -------------------------------------------------------------
-- Constraints
create table cons(sid int unique, sid2 int not null, sid3 int check(sid3>13),sid4 int default 0);
insert into cons values(1,null,12,default);  -- Error - sid cann't be null and sid3 should be greater than 13
insert into cons values(1,82,14,82);
select * from cons;

-- -------------------------------------------------------------
-- Serching
create table search(name varchar(10));
insert into search values('Namrata'),('namrata'),('NAMRATA'),('abc'),('namRata'),('n');
select * from search where name like 'n%';
select * from search where name like 'n';
select * from search where name like '%n%';
select * from search where name like 'n%n';
select * from search where name like '%t_';
select * from search where binary(name) = 'NAMRATA';

-- -----------------------------------------------------------------
-- Primary and foreign key
create table prk(sno int primary key,sal int);
insert into prk values(1,10),(2,20);
create table frk(fno int,fal int,foreign key(fno) references prk(sno));
insert into frk values(1,66);
insert into frk values(2,10);
insert into frk values(2,2);
insert into frk values(3,10);  -- gives error 

delete from prk where sno=1;  
-- first we have to delete from foreign key then from primary key

-- Built in function
select length('nam r %#%$ 1311ata') len,length(1765432) len1,upper('krishan') name;

-- slicing
select substr('krishan',2);
select substr('namrata',2,3);

create table str(sname char(20));
insert into str values('Ms.grid'),('Mr.sgsn'),('Miss.hgshsh');
select * from str;
select sname,substr(sname,1,instr(sname,'.'))  from str ;
select sname,substr(sname,instr(sname,'.')+1)  from str ;

-- ----------------------------------------------------
-- trim and replace
select('  nam   rata  '),trim('  nam   rata  '),replace('  nam  rata  ',' ', '');

-- ----------------------------------------------------------------
-- time
select current_date(),now(),current_timestamp();
use hr;
select hire_date,datediff(current_date(),hire_date)/365 from employees;
select hire_date,datediff(current_date,hire_date)/365,year(current_date)-year(hire_date) from employees;

select adddate(current_date,2),subdate(current_date(),2); 
select hire_date,date_format(hire_date,'%d-%m-%Y') from employees;

create table d(da text);
insert into d values('04-03-2000');
desc d;
update d set da= str_to_date(da,'%d-%m-%Y');
select da from d;
alter table d modify da date;

-- ----------------------------------------------------------------
-- ifnull
select salary,commission_pct,ifnull(commission_pct,0) n from employees;

select salary,commission_pct,ifnull(commission_pct,salary,0) n from employees;
select commission_pct,department_id,coalesce(commission_pct,department_id,0) from employees;

-- ----------------------------------------------------------------
-- if statement
select if(34>10,'T','F');
select salary,case when salary>6000 then 'T' else 'F' end from employees;

select employee_id,job_id,
case when job_id like '%mgr%' then 'manager'
else 'others' end tag from employees;

-- ----------------------------------------------------------------
-- built- in string function - LPAD/RPAD
select lpad('namrata',10,'*'),lpad('namrata',4,'*');
select rpad('namrata',10,'*'),rpad('namrata',4,'*');
select lpad(first_name,10,'*'),rpad(first_name,10,'*') from employees;

-- ----------------------------------------------------------------
-- concat
select concat('krishan',23);
select concat(first_name,'-',last_name) from employees;

-- ----------------------------------------------------------------
-- aggregate functions
select sum(salary),avg(salary),max(salary),min(salary),count(salary),count(*) from employees;

-- ----------------------------------------------------------------
-- Group by and having funtion
select department_id,sum(salary) from employees;  -- through error aggregate and non-aggregate

select department_id,sum(salary) from employees group by department_id;

select department_id,count(*) from employees
where department_id in (90,30)
group by department_id
having count(*)>1;

-- where - filter by table and can't filter aggregte function
-- having - filter from group and can filter aggregte function

-- roll up  -- tell sum of value in last
select department_id,first_name,count(employee_id) from employees
group by department_id,employee_id,first_name with rollup;


select department_id,job_id,count(employee_id) from employees
where department_id between 30 and 90
group by department_id,job_id with rollup;

-- union 
select employee_id from employees
union
select department_name from departments;

select 'Namrata',90000,101 from dual
union all
select 'pp',65433,null from dual;

-- ------------------------------------------------------------
-- join
/*  
inner
outer  -- left,right,"full"- not work in mysql
cross
self 
*/

select first_name,department_name from employees e inner join departments d on e.department_id=d.department_id;

select first_name,department_name from employees e left join departments d on e.department_id=d.department_id;

select first_name,department_name from employees e right join departments d on e.department_id=d.department_id;

select first_name,department_name from employees e join departments d ;

-- -------------------------------------------------------------------------------------
-- Subquery
select employee_id from employees where first_name='lex';
select first_name,employee_id from employees where employee_id > (select employee_id from employees where first_name='lex');

-- first_name, salary, salary>'valli'/department_id'=bruce
select first_name,salary from employees where salary > (select salary from employees where first_name='valli') and department_id = 
(select department_id from employees where first_name='bruce');

-- department name - (non empty)
select department_name from departments where department_id in (select department_id from employees);

select department_name from departments where department_id not in (select department_id from employees where department_id is not null);

select first_name,salary from employees where salary > any (select salary from employees where first_name='john'); -- >smallest
select first_name,salary from employees where salary < any (select salary from employees where first_name='john'); -- >greater
select first_name,salary from employees where salary < all (select salary from employees where first_name='john'); -- >smaller than smallest
select first_name,salary from employees where salary > all (select salary from employees where first_name='john'); -- >greater than the greatest

select first_name,salary from employees where salary > (select min(salary) from employees where first_name='john'); -- using aggregate  function
select first_name,salary from employees where salary > (select max(salary) from employees where first_name='john'); -- using aggregate  function


-- ---------------------------------------------------------------------
select * from (select salary,salary+1000 net from employees)t where net >10000;

select department_id,job_id,count(*)total,
(select count(*) from employees where department_id=90)overall from employees 
where department_id=90 group by department_id,job_id ;

-- ---------------------------------------------------------------
select * from employees where
 exists(select* from departments where department_id=90); -- subquary give 1 then outer quary run

select * from employees where
 exists(select* from departments where department_id=900); -- -- subquary give 0 then outer quary can't run

-- -----------------------------------------------------------
-- window function
/* row_number
rank
dense_rank
lag/lead
first_value/lats_value
ntile
*/

select *,row_number() over(order by salary),
rank() over(order by salary desc),
dense_rank() over(order by salary desc) from employees;

select department_id,salary, row_number() over(partition by department_id order by salary desc) col3 from employees;

-- lag/lead
select salary,lag(salary) over(),lead(salary) over() from employees;

select salary,lag(salary,2) over() from employees;

select *,abs(salary-new_col) from(
select department_id,salary,lag(salary) over(partition by department_id order by salary desc) new_col from employees)t;

select *,abs(salary-new_col) from(
select ifnull(department_id,'NA') as deptt_id,salary,lag(salary) over(partition by department_id order by salary desc) new_col from employees)t;

select * ,datediff(hire_date,new_col) diff from (
select department_id,hire_date,
lag(hire_date)over(partition by department_id order by hire_date) new_col
from employees)t;

-- first_value and last_value
select salary,first_value(salary) over(),last_value(salary) over() from employees;

-- ntile
select salary,ntile(10) over() from employees;


-- sum/avg/count/max/min
select salary ,sum(salary) over(order by salary desc) from employees;

select salary ,sum(salary) over(order by salary desc rows between unbounded preceding and current row) from employees; -- cumulative sum








































