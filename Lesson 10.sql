use hr;

-- 8. Найти количество сотрудников из департамента с ID 60, которые зарабатывают больше средней зарплаты по компании.
select avg(salary) from employees;

select *
from employees
where department_id = 60 and salary > (select avg(salary) from employees);

select count(*)
from employees
where department_id = 60 and salary > (select avg(salary) from employees);

-- 9. Найти количество департаментов, в которых никто не работает.
select t1.department_name, t2.employee_id
from departments t1
left join employees t2
on t1.department_id = t2.department_id
where t2.employee_id is null;

select count(*)
from departments t1
left join employees t2
on t1.department_id = t2.department_id
where t2.employee_id is null;

-- 10. Найти количество сотрудников из департамента IT, которые зарабатывают больше средней зарплаты по компании.
select t1.first_name, t1.last_name
from employees t1
join departments t2
on t1.department_id = t2.department_id
where t2.department_name = 'IT' and t1.salary > (select avg(salary) from employees);

select count(*)
from employees t1
join departments t2
on t1.department_id = t2.department_id
where t2.department_name = 'IT' and t1.salary > (select avg(salary) from employees);

-- 11. Вывести имена и фамилии сотрудников с должностями IT_PROG и ST_MAN, которые получают либо самую низкую,
-- либо самую высокую зарплату.
select min(salary) from employees
where job_id in ('IT_PROG', 'ST_MAN');

select max(salary) from employees
where job_id in ('IT_PROG', 'ST_MAN');
                                                    
select first_name, last_name, salary, job_id
from employees
where job_id in ('IT_PROG', 'ST_MAN') and (salary = 4200 or salary = 9000);     

select first_name, last_name
from employees
where job_id in ('IT_PROG', 'ST_MAN') and (salary = (select min(salary) from employees
													where job_id in ('IT_PROG', 'ST_MAN'))
									   or salary = (select max(salary) from employees
													where job_id in ('IT_PROG', 'ST_MAN')));
                                                                                          

-- 12. Вывести имя и фамилию сотрудника с минимальной зарплатой, который работает в городе Seattle.
select min(salary) 
from employees t1
join departments t2
on t1.department_id = t2.department_id
join locations t3
on t2.location_id = t3.location_id
where t3.city = 'Seattle';

select first_name, last_name
from employees t1
join departments t2
on t1.department_id = t2.department_id
join locations t3
on t2.location_id = t3.location_id
where t3.city = 'Seattle' and t1.salary = (select min(salary) 
											from employees t1
											join departments t2
											on t1.department_id = t2.department_id
											join locations t3
											on t2.location_id = t3.location_id
											where t3.city = 'Seattle');

-- 13. Найти количество сотрудников из департамента Shipping, которые зарабатывают меньше средней 
-- зарплаты среди всех сотрудников этого департамента.
select avg(salary)
from employees t1
join departments t2
on t1.department_id = t2.department_id
where t2.department_name = 'Shipping';

select first_name, last_name, salary
from employees t1
join departments t2
on t1.department_id = t2.department_id
where t2.department_name = 'Shipping' and t1.salary < (select avg(salary)
													from employees t1
													join departments t2
													on t1.department_id = t2.department_id
													where t2.department_name = 'Shipping');
                                                    
select count(*)
from employees t1
join departments t2
on t1.department_id = t2.department_id
where t2.department_name = 'Shipping' and t1.salary < (select avg(salary)
													from employees t1
													join departments t2
													on t1.department_id = t2.department_id
													where t2.department_name = 'Shipping');                                                   

-- 14. Найти среднюю зарплату среди сотрудников, работающих в стране 'United Kingdom'.
select avg(t1.salary)
from employees t1
join departments t2
on t1.department_id = t2.department_id
join locations t3
on t2.location_id = t3.location_id
join countries t4
on t3.country_id = t4.country_id
where t4.country_name = 'United Kingdom';

-- 15. Найти сотрудников, работающих в стране 'United States of America', 
-- чья зарплата выше средней зарплаты сотрудников, работающих в стране 'United Kingdom'. 
-- Вывести их имена, фамилии и зарплаты.

select first_name, last_name, salary
from employees t1
join departments t2
on t1.department_id = t2.department_id
join locations t3
on t2.location_id = t3.location_id
join countries t4
on t3.country_id = t4.country_id
where t4.country_name = 'United States of America' and salary > (select avg(t1.salary)
																from employees t1
																join departments t2
																on t1.department_id = t2.department_id
																join locations t3
																on t2.location_id = t3.location_id
																join countries t4
																on t3.country_id = t4.country_id
																where t4.country_name = 'United Kingdom');


-- GROUP BY
-- HAVING

-- select column_name,..
-- from table
-- [where condition...]
-- [joins...]
-- group by column_name
-- [having condition]
-- [order by ..]
-- [limit ..]


-- Посчитать кол/во людей в каждом департаменте
-- Вывести ид департамента и кол/во сотрудников
select department_id, count(*)
from employees
group by department_id;

-- Вывести кол/во сотрудников из департаментов 10, 20, 40, 100 по отдельности.
select department_id, count(*)
from employees
where department_id in (10, 20, 40, 100)
group by department_id;

-- Вывести кол/во сотрудников в каждом департаменте, если кол/во больше 10.
select department_id, count(*)
from employees
group by department_id
having count(*) > 10;

-- Вывести максимальные зарплаты каждого департамента
-- department_id, max_salary
select department_id, max(salary) as max_salary
from employees
where department_id is not null
group by department_id;

-- Вывести максимальные зарплаты каждого департамента. сортировать по зарплатам по возр.
select department_id, max(salary) as max_salary
from employees
where department_id is not null
group by department_id
order by max_salary;

-- Найти среднее зарплат по департаментам.
-- Вывести department_id, avg_salary
select department_id, avg(salary) as avg_salary
from employees
where department_id is not null
group by department_id;

-- Найти имена и фамилии сотрудников с максмальной зарплатой в каждом департаменте
select t1.first_name, t1.last_name, t1.salary, t1.department_id
from employees t1
join (select department_id, max(salary) as max_salary
	from employees
	where department_id is not null
	group by department_id) t2
on t1.department_id = t2.department_id
where t1.salary = t2.max_salary;

-- Найти минимальную зарплату для каждой должности. Вывести min_salary, job_id
select min(salary) as min_salary, job_id
from employees
group by job_id;

-- Найти сотрудников с минимальной зарплатой каждой должности. Вывести first_name, last_name, salary, job_id
select t1.first_name, t1.last_name, t1.salary, t1.job_id
from employees t1
join (select min(salary) as min_salary, job_id
		from employees
		group by job_id) t2
on t1.job_id = t2.job_id 
where t1.salary = t2.min_salary;

-- Посчитать кол/во городов в каждой стране из таблицы locations. Вывести city_count, country_id
select count(city) as city_count, country_id
from locations
group by country_id;

-- Вывести те депатраменты, в которых максимальная зарплата выше 10000
select department_id, max(salary) as max_salary
from employees
group by department_id
having max_salary > 10000;     

-- Посчитать кол/во городов в каждой стране из таблицы locations. 
-- Вывести только те страны(country_id), где кол/во городов больше 3.
select count(city) as city_count, country_id
from locations
group by country_id
having city_count > 3;

-- Найти департамент с наибольшим кол/вом сотрудников.
select department_id, count(employee_id) as emp_count
from employees
group by department_id
order by emp_count desc
limit 1;

-- 1. Найти кол/во сотрудников в каждом депатраменте.
select department_id, count(employee_id) as emp_count
from employees
group by department_id;

-- 2. Найти максимальное кол/во сотр. среди департаментов.
select max(t1.emp_count)
from (select department_id, count(employee_id) as emp_count
		from employees
		group by department_id) t1;
        
-- 3. Вывести ид департамента с макс. кол/вом сотрудников.
select department_id, count(employee_id) as emp_count
from employees
group by department_id
having emp_count = (select max(t1.emp_count)
					from (select department_id, count(employee_id) as emp_count
							from employees
							group by department_id) t1);
