-- INNER JOIN

use hr;

-- select t1.<column_name>, t2.<column_name>
-- from table1 t1
-- join table2 t2
-- on t1.column = t2.column;

select * from employees;
select * from departments;
select * from locations;

-- Вывести имя, фамилию сотрудников, имя и адресс(street_address, city) департамента, в котором они работают 

select t1.first_name, t1.last_name, t2.department_name, t3.street_address, t3.city
from employees t1
join departments t2
on t1.department_id = t2.department_id
join locations t3
on t2.location_id = t3.location_id;

-- Вывести имя и фамилию сотрудников из департамента "Sales", которые зарабатывают больше 8000.

select t1.first_name, t1.last_name
from employees t1
join departments t2
on t1.department_id = t2.department_id
where t2.department_name = 'Sales' and t1.salary > 8000;

-- Вывести имя и фамилию сотрудника с максимальной зарплатой из департамента "IT".
select t1.first_name, t1.last_name
from employees t1
join departments t2
on t1.department_id = t2.department_id
where department_name = 'IT'
order by salary desc
limit 1;

-- SELF JOIN

select first_name, last_name, salary
from employees
where first_name = 'Luis' and last_name = 'Popp';

-- Вывести имя, фамилию и зарпату сотрудников которые получают больше 'Luis', 'Popp'
select t1.first_name, t1.last_name, t1.salary
from employees t1
join employees t2
on t1.employee_id != t2.employee_id
where t2.first_name = 'Luis' and t2.last_name = 'Popp' and t1.salary > t2.salary;

-- Вывести имя, фамилию и зарплату первых трех сотрудников, которые зарабатывают меньше "Adam" "Fripp"
select t1.first_name, t1.last_name, t1.salary
from employees t1
join employees t2
on t1.employee_id != t2.employee_id
where t2.first_name = 'Adam' and t2.last_name = 'Fripp' and t1.salary < t2.salary
limit 3;

-- Вывести имя и фамилию сотрудника и имя и фамилию его менеджера
select t1.first_name, t1.last_name, t2.first_name as manager_name, t2.last_name as manager_last_name
from employees t1
join employees t2
on t1.manager_id = t2.employee_id;

select first_name, last_name, manager_id from employees;
select first_name, last_name, employee_id from employees;

-- Вывести имя и фамилию сотрудника, имя и фамилию его менеджера и имя департамента, в котором работает менеджер 
select t1.first_name, t1.last_name, t2.first_name as manager_name, t2.last_name as manager_last_name, t3.department_name
from employees t1
join employees t2
on t1.manager_id = t2.employee_id
join departments t3
on t2.department_id = t3.department_id;

-- Вывести имя и фамилию сотрудника, имя и фамилию его менеджера и имя департамента, в котором работает сотрудник
select t1.first_name, t1.last_name, t2.first_name as manager_name, t2.last_name as manager_last_name, t3.department_name
from employees t1
join employees t2
on t1.manager_id = t2.employee_id
join departments t3
on t1.department_id = t3.department_id;

-- OUTER JOIN 

-- Вывести все страны из таблицы countries и города из locations, если в locations нет города в этой стране, вывест null
select t1.country_name, t2.city
from countries t1
left join locations t2
on t1.country_id = t2.country_id;

select t2.country_name, t1.city
from locations t1
right join countries t2
on t1.country_id = t2.country_id;


-- Вывести те страны, которых нет в locations
select t1.country_name
from countries t1
left join locations t2
on t1.country_id = t2.country_id
where t2.country_id is null;

select t2.country_name
from locations t1
right join countries t2
on t1.country_id = t2.country_id
where t1.country_id is null;

select t1.country_name, t2.city
from countries t1
left join locations t2
on t1.country_id = t2.country_id
where t2.city is null;

select t1.country_name, t2.street_address
from countries t1
left join locations t2
on t1.country_id = t2.country_id
where t2.street_address is null;

select t1.country_name, t2.country_id
from countries t1
left join locations t2
on t1.country_id = t2.country_id
where t2.country_id is null;

-- Вывести имя и фамилию сотрудника из dependents и имя фамилию родителя из employees.
select t1.first_name, t1.last_name, t2.first_name as parent_name, t2.last_name as parent_last_name
from dependents t1
join employees t2
on t1.employee_id = t2.employee_id;

-- Вывести имя и фамилю всех сотрудников из employees, и имя и фамилию их детей из dependents если есть, если нет - null.
select t1.first_name, t1.last_name, t2.first_name, t2.last_name
from employees t1
left join dependents t2
on t1.employee_id = t2.employee_id;

-- Вывести имена и фамилии сотрудников у которых в компании нет детей.
select t1.first_name, t1.last_name, t2.first_name, t2.last_name
from employees t1
left join dependents t2
on t1.employee_id = t2.employee_id
where t2.first_name is null;
