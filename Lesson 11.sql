-- CRUD

-- Create - create database, create table
-- Read - select
-- Update - alter table, update
-- Delete - drop database, drop table, delete

create database temp;

use temp;

create table(
	column_name1 data_type constraint,
    column_name2 data_type constraint
)

-- constraint
-- not null
-- unique
-- primary key = not null + unique
-- check(Условие)
-- default

-- auto_increment

-- data_type
-- varchar(max)
-- char(fixed)
-- int
-- decimal/numeric
-- boolean

-- insert into table_name(column_name1, column_name2, ...)
-- values (value1, value2), 
-- 	(value1, value2), 
--     (value1, value2), 
--     (value1, value2);
--     
-- insert into table_name(column_name1, column_name2, ...)
-- values (value1, value2); 

-- insert into table_name(column_name1, column_name2, ...)
-- values (value1, value2); 

-- insert into table_name(column_name1, column_name2, ...)
-- values (value1, value2); 

-- select column_name1, column_name2
-- from table_name/subselect
-- where условие
-- order by сортировка
-- limit пагинация
-- join - inner join, left join, right join
-- union/union all
-- group by группировка
-- having условие

-- Условие
-- > < = >= <= != <>
-- [not] between min and max
-- [not] like '%_'
-- [not] in ('', '', '')
-- is [not] null
-- and or

-- alter table table_name
-- add column
-- drop column
-- modify column
-- change/rename

-- set sql_safe_updates = 0;

-- update table_name
-- set column_name1 = new_value
-- [where условие];

-- set sql_safe_updates = 1;


-- set sql_safe_updates = 0;

-- delete from table_name
-- where условие;

-- set sql_safe_updates = 1;

-- ЗАДАЧИ

-- 1. Создать базу данных tasks. Если уже есть удалить и потом создатыь новую.
drop database tasks;
create database tasks;

-- 2. Переключится на бд tasks.
use tasks;

-- 3. Создать таблицу с названием Employees, которая будет содержать информацию о сотрудниках компании. 
-- Таблица должна иметь следующие поля:

-- employee_id - уникальный идентификатор сотрудника (Primary Key, автозаполнение)
-- first_name - имя сотрудника (Not Null)
-- last_name - фамилия сотрудника (Not Null)
-- email - адрес электронной почты сотрудника (Unique, Not Null)
-- age - возраст сотрудника (больше или равно 18)


create table Employees(
	employee_id int primary key auto_increment,
    first_name varchar(128) not null,
    last_name varchar(128) not null,
    email varchar(128) unique not null,
    age int check(age >= 18)
);

-- 4. Заполнить таблицу данными с помощью следующих записей:

-- Сотрудник с именем "John", фамилией "Doe", адресом электронной почты "john.doe@example.com" и возрастом 30 лет.
-- Сотрудник с именем "Jane", фамилией "Smith", адресом электронной почты "jane.smith@example.com" и возрастом 25 лет.
-- Сотрудник с именем "Michael", фамилией "Johnson", адресом электронной почты "michael.johnson@example.com" и возрастом 22 года.
-- Сотрудник с именем "Emily", фамилией "Brown", адресом электронной почты "emily.brown@example.com" и возрастом 19 лет.

insert into Employees(first_name, last_name, email, age)
values ('John', 'Doe', 'john.doe@example.com', 30);

insert into Employees(first_name, last_name, email, age)
values ('Jane', 'Smith', 'jane.smith@example.com', 25);

insert into Employees(first_name, last_name, email, age)
values ('Michael', 'Johnson', 'michael.johnson@example.com', 22);

insert into Employees(first_name, last_name, email, age)
values ('Emily', 'Brown', 'emily.brown@example.com', 19);

-- 5. Найти всех сотрудников в возрасте от 20 до 30 лет.
select *
from employees
where age between 20 and 30;

-- 6. Найти сотрудников с именами "John", "Jane" и "Michael".
select * 
from employees
where first_name = 'John' or first_name = 'Jane' or first_name = 'Michael';

select * 
from employees
where first_name in ('John', 'Jane', 'Michael');

-- 7. Найти всех сотрудников, у которых адрес электронной почты заканчивается на ".com".
select *
from employees
where email like '%.com';

-- 8. Добавить столбец salary, тип int, где значение по умолчанию будет 0.
alter table employees
add salary int default 0;

-- 9. Удалить столбец email, который больше не нужен.
alter table employees
drop column email;

-- 10. Изменить тип данных столбца salary на DECIMAL(10, 2), чтобы хранить зарплату с точностью до двух знаков после запятой.
alter table employees
modify salary decimal(10, 2);

-- 11. Обновить возраст сотрудника с именем "John" на 32 года.
set sql_safe_updates = 0;

update employees
set age = 32
where first_name = 'John';

-- 12. Изменить фамилию сотрудника с именем "Emily" на "Jameson".
update employees
set last_name = 'Jameson'
where first_name = 'Emily';

-- 13. Обновить имя и фамилию сотрудника с именем "Jane" и фамилией "Smith" на "Jessica" и "Williams" соответственно.
update employees
set first_name = 'Jessica', last_name = 'Williams'
where first_name = 'Jane' and last_name = 'Smith';

set sql_safe_updates = 1;

-- case
-- 	when условие then значение
--     when условие then значение
--     else значение
-- end

-- 14. Создать столбец status (int)
alter table employees
add status int;

-- 15. Изменить тип данных столбца на varchar(128)
alter table employees
modify status varchar(128);

-- 16. Обновить столбец status для сотрудников в зависимости от их возраста. 
-- Если возраст сотрудника меньше 25, установить статус "Junior", иначе установить статус "Senior".

set sql_safe_updates = 0;

update employees
set status = case 
					when age < 25 then 'Junior'
                    else 'Senior'
			end;

select * from employees;

set sql_safe_updates = 1;


drop database shop;
CREATE DATABASE shop;

USE shop;

CREATE TABLE SELLERS(
       SELL_ID    INTEGER, 
       SNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       COMM    NUMERIC(2, 2),
	   BOSS_ID  INTEGER
);
                                            
CREATE TABLE CUSTOMERS(
       CUST_ID    INTEGER, 
       CNAME   VARCHAR(20), 
       CITY    VARCHAR(20), 
       RATING  INTEGER
);

CREATE TABLE ORDERS(
       ORDER_ID  INTEGER, 
       AMT     NUMERIC(7,2), 
       ODATE   DATE, 
       CUST_ID    INTEGER,
       SELL_ID    INTEGER 
);

INSERT INTO SELLERS VALUES(201,'Oleg','Moskva',0.12,202);
INSERT INTO SELLERS VALUES(202,'Lev','Sochi',0.13,204);
INSERT INTO SELLERS VALUES(203,'Arsenij','Vladimir',0.10,204);
INSERT INTO SELLERS VALUES(204,'Ekaterina','Moskva',0.11,205);
INSERT INTO SELLERS VALUES(205,'Leonid ','Kazan',0.15,NULL);


INSERT INTO CUSTOMERS VALUES(301,'Andrej','Moskva',100);
INSERT INTO CUSTOMERS VALUES(302,'Mihail','Tula',200);
INSERT INTO CUSTOMERS VALUES(303,'Ivan','Sochi',200);
INSERT INTO CUSTOMERS VALUES(304,'Dmitrij','Yaroslavl',300);
INSERT INTO CUSTOMERS VALUES(305,'Ruslan','Moskva',100);
INSERT INTO CUSTOMERS VALUES(306,'Artyom','Tula',100);
INSERT INTO CUSTOMERS VALUES(307,'Yuliya','Sochi',300);


INSERT INTO ORDERS VALUES(101,18.69,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(102,5900.1,'2022-03-10',307,204);
INSERT INTO ORDERS VALUES(103,767.19,'2022-03-10',301,201);
INSERT INTO ORDERS VALUES(104,5160.45,'2022-03-10',303,202);
INSERT INTO ORDERS VALUES(105,1098.16,'2022-03-10',308,207);
INSERT INTO ORDERS VALUES(106,75.75,'2022-04-10',304,202); 
INSERT INTO ORDERS VALUES(107,4723,'2022-05-10',306,201);
INSERT INTO ORDERS VALUES(108,1713.23,'2022-04-10',302,203);
INSERT INTO ORDERS VALUES(109,1309.95,'2022-06-10',304,203);
INSERT INTO ORDERS VALUES(110,9891.88,'2022-06-10',306,201);

use shop;

-- Получить информацию о заказах, включая имена продавцов и их города. ORDER_ID, AMT, ODATE, SNAME, CITY
select t1.ORDER_ID, t1.AMT, t1.ODATE, t2.SNAME, t2.CITY
from orders t1
join sellers t2
on t1.sell_id = t2.sell_id;

-- Вывести имя покупателя(CNAME), даты его заказа(ODATE) и имя продавца товара(SNAME).
select t1.CNAME, t2.ODATE, t3.SNAME
from customers t1
join orders t2
on t1.cust_id = t2.cust_id
join sellers t3
on t2.sell_id = t3.sell_id;

-- Вывести кол/во продавцов.
select count(sell_id) as sellers_count
from sellers;

-- Найти общее количество продавцов в каждом городе. Вывести город и кол/во.
select city, count(sell_id) as sellers_count
from sellers
group by city;

-- Получить среднюю комиссию для продавцов в каждом городе.
select city, avg(comm) as comm_avg
from sellers
group by city;
