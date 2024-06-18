-- case
-- 	when ... then..
--     when ... then ..
--     
--     else ...
-- end

-- coalesce(val1, val2, val3)

use gt200224;

create table users1(
	id int primary key auto_increment,
    first_name varchar(128) not null,
    last_name varchar(128) not null,
    phone varchar(128),
    email varchar(128)
);

insert into users1(first_name, last_name, phone, email)
value ('Tom', 'Smith', '+123445553', null),
	  ('John', 'Brown', null, 'john1@gmail.com'),
      ('Lily', 'Watson', null, null),
      ('Bob', 'Jameson', '+12333323', 'bob5@gmail.com');
      
select * from users1;
		
-- Создать новое поле contact, заполнить:
-- - phone(если указан),
-- - email(если не указан phone)
-- - 'не определено' (если не указаны phone и email)
        
        
alter table users1
add column contact varchar(128);  

set sql_safe_updates = 0;

update users1
set contact = case
					when phone is not null then phone
                    when email is not null then email
                    else 'не определено'
			  end;
              
update users1
set contact = coalesce(phone, email, 'не определено');

-- Функции для работ с числами
-- int/integer, numeric/decimal

-- round: округляет число. В качестве первого параметра передается число. Второй параметр указывает на длину. 
-- Если длина представляет положительное число, то оно указывает, до какой цифры после запятой идет округление

select round(123.34); -- 123
select round(123.6); -- 124
select round(123.23435654, 2); -- 123.23
select round(123.23635654, 2); -- 123.24

-- CEILING: возвращает наименьшее целое число, которое больше или равно текущему значению.
select ceiling(123.34); -- 124
select ceiling(123.7); -- 124

-- FLOOR: возвращает наибольшее целое число, которое меньше или равно текущему значению.
select floor(123.34); -- 123
select floor(123.7); -- 123

-- TRUNCATE: оставляет в дробной части определенное количество символов
select truncate(123.23435654, 2); -- 123.23
select truncate(123.23635654, 2); -- 123.23

-- ABS: возвращает абсолютное значение числа.
select abs(-123); -- 123

-- POWER: возводит число в определенную степень.
select power(5, 2); -- 25

-- SQRT: получает квадратный корень числа.
select sqrt(225); -- 15

-- RAND: генерирует случайное число с плавающей точкой в диапазоне от 0 до 1.
select round(rand()*10); -- (0 - 10)
select rand()*10;


-- alter table phones
-- add final_price numeric(6, 2);

-- set sql_safe_updates = 0;

-- update phones
-- set final_price = coalesce(starting_price + starting_price * tax / 100, starting_price, 0);

-- Вывести final_price округленное в большую сторону 
select product_name, ceiling(final_price)
from phones;

select * from phones;

-- Функции для работы со строками 
-- varchar/char

-- CONCAT: объединяет строки. В качестве параметра принимает от 2-х и более строк, которые надо соединить:
select concat('Tom', ' ', 'Smith');
select concat('Name', ' ', 'Tom',  ' ', 'Surname', ' ', 'Smith');

-- CONCAT_WS: также объединяет строки, но в качестве первого параметра принимает разделитель, 
-- который будет соединять строки:
select concat_ws(' ', 'Name', 'Tom', 'Surname', 'Smith');

select concat(first_name, ' ', last_name) as full_name
from employees;

-- LENGTH: возвращает количество символов в строке. 
-- В качестве параметра в функцию передается строка, для которой надо найти длину:
select length('Tom Smith'); -- 9


-- Вывести мейл сотрудников, где длина мейла = 8
select email, length(email) as email_lenght
from employees
where length(email) = 8;

-- TRIM: удаляет начальные и конечные пробелы из строки. В качестве параметра принимает строку:
select trim(' Tom Smith  '); -- 'Tom Smith'

-- LTRIM: удаляет начальные пробелы из строки. В качестве параметра принимает строку:
select ltrim(' Tom Smith  '); -- 'Tom Smith  '

-- RTRIM: удаляет конечные пробелы из строки. В качестве параметра принимает строку:
select rtrim(' Tom Smith  '); -- ' Tom Smith'

select concat(trim(first_name), ' ', trim(last_name)) as full_name
from employees;

-- LOCATE(find, search [, start]): возвращает позицию первого вхождения подстроки find в строку search. 
-- Дополнительный параметр start позволяет установить позицию в строке search, с которой начинается поиск подстроки find. 
-- Если подстрока search не найдена, то возвращается 0:

select locate('13', 'iPhone 13 pro max'); -- 8
select locate('13', 'iPhone 13 pro, iPhone 13 pro max'); -- 8
select locate('13', 'iPhone 13 pro, iPhone 13 pro max', locate('13', 'iPhone 13 pro, iPhone 13 pro max') + 1); -- 23
select locate('12', 'iPhone 13 pro max'); -- 0

-- LEFT: вырезает с начала строки определенное количество символов. 
-- Первый параметр функции - строка, а второй - количество символов, которые надо вырезать с начала строки:
select left('iPhone 13 pro max', 7); -- iPhone

select left(department, 3)
from employees;

-- RIGHT: вырезает с конца строки определенное количество символов. 
-- Первый параметр функции - строка, а второй - количество символов, которые надо вырезать с конца строки:

select right('iPhone 13 pro max', 7); -- pro max

select first_name, last_name, left(department, 3) as dep
from employees;

-- REPLACE(search, find, replace): заменяет в строке search подстроку find на подстроку replace. 
-- Первый параметр функции - строка, второй - подстрока, которую надо заменить, 
-- а третий - подстрока, на которую надо заменить:

select replace('iPhone 13 pro max', '13', '14');

-- LOWER: переводит строку в нижний регистр:
select lower('iPhone 13 pro max'); -- iphone 13 pro max

-- UPPER: переводит строку в верхний регистр
select upper('iPhone 13 pro max'); -- 'IPHONE 13 PRO MAX'

-- Создать новое поле full_name, вставить после employee_id, заполнить 'Имя Фамилия'.
-- Удалить поля first_name, last_name
-- before/after

alter table employees
add full_name varchar(128) after employee_id;

update employees
set full_name = concat(first_name, ' ', last_name);

alter table employees
drop first_name,
drop last_name;

select * from employees;

-- Из таблицы employees вывести первые четыре символа из email в нижнем регистре
select lower(left(email, 4))
from employees;

-- Из таблицы users1 изменить значение поля email(где указан) - .com заменяем .de и переводим сторку в верхний регистр
update users1
set email = case
				when email is null then null
                else upper(replace(email, '.com', '.de'))
			end;

select * from users1;

