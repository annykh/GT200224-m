-- 7. Найдите департамент с самой высокой средней зарплатой сотрудников. Вывести имя департамента.
select t2.departmentname, avg(t1.salary) as avg_salary
from employees t1
join departments t2
on t1.departmentid = t2.DepartmentID
group by t1.DepartmentID
having avg_salary = (select max(t1.avg_salary)
						from (select DepartmentID, avg(salary) as avg_salary
								from employees 
								group by DepartmentID) t1);

-- 8. Найдите проект с наибольшим количеством сотрудников, проработавших на нем больше 100 часов. Вывести ProjectName.
-- 8.1.Вывести ИД проекта и кол/во сотрудников, которые поработали больше 100 часов.
select ep.ProjectID, count(ep.EmployeeID) 
from employeeProjects ep
where ep.HoursWorked > 100
group by ProjectID;
-- 8.2.Вывести максимальное кол/во сотрудников.
select max(employee_count) as max_employee
from  (select ep.ProjectID, count(ep.EmployeeID) as employee_count
		from employeeProjects ep
		where ep.HoursWorked > 100
		group by ProjectID) t2;

-- 8.3.Вывести ид проекта с наибольшим количеством сотрудников, проработавших на нем больше 100 часов.
select ep.ProjectID, count(ep.EmployeeID) as count
from employeeProjects ep
where ep.HoursWorked > 100
group by ProjectID
having count = (select max(employee_count) as max_employee
				from  (select ep.ProjectID, count(ep.EmployeeID) as employee_count
						from employeeProjects ep
						where ep.HoursWorked > 100
						group by ProjectID) t2);

-- 8.4. Вывести имя проекта...
select projectname
from projects p
join (select ep.ProjectID, count(ep.EmployeeID) as count
		from employeeProjects ep
		where ep.HoursWorked > 100
		group by ProjectID
		having count = (select max(employee_count) as max_employee
						from  (select ep.ProjectID, count(ep.EmployeeID) as employee_count
								from employeeProjects ep
								where ep.HoursWorked > 100
								group by ProjectID) t2)) t1
on p.ProjectID = t1.ProjectID;

-- 9. Найдите департамент с наименьшим количеством сотрудников. Выведите название департамента и количество сотрудников.
select DepartmentName, count_emp
from departments alles
join (select DepartmentID, count(*) as count_emp 
		from employees
		group by DepartmentID
		having count_emp = (select min(count_emp)
		from (select count(*) as count_emp, DepartmentID
		from employees
		group by DepartmentID) t1)) table1
on alles.DepartmentID = table1.DepartmentID;

-- 10. Определите департамент с наибольшим суммарным бюджетом проектов, на которых работают его сотрудники.
-- 10.1. Вывести ид департамента, имена и фамилии сотрудников, имена проектов и их бюджет.
select  t2.departmentid, t1.firstname, t1.lastname,t4.projectname,t4.budget
from employees as t1
join departments as t2
on t1.departmentid = t2.departmentid
join employeeprojects as t3
on t1.employeeid = t3.employeeid
join projects as t4
on t3.projectid = t4.projectid;

-- 10.2. Вывести ид депатамента и сумма бюджета проектов по департаментам.
select t1.departmentid ,sum(budget) as sum_budget
from employees as t1
join  employeeprojects as t2
on t1.employeeid = t2.employeeid
join projects as t3
on t2.projectid = t3.projectid
group by departmentid;

-- 10.3. Вывести маскимальную сумму бюджета проектов по департаментам.
select max(t1.sum_budget)
from (select t1.departmentid ,sum(budget) as sum_budget
		from employees as t1
		join  employeeprojects as t2
		on t1.employeeid = t2.employeeid
		join projects as t3
		on t2.projectid = t3.projectid
		group by departmentid) as t1;
-- 10.4. Вывести ид депатамента с максимальной суммой бюджета проектов по департаментам.
select t1.departmentid ,sum(budget) as sum_budget
from employees as t1
join  employeeprojects as t2
on t1.employeeid = t2.employeeid
join projects as t3
on t2.projectid = t3.projectid
group by departmentid
having sum_budget = (select max(t1.sum_budget)
					from (select t1.departmentid ,sum(budget) as sum_budget
					from employees as t1
					join  employeeprojects as t2
					on t1.employeeid = t2.employeeid
					join projects as t3
					on t2.projectid = t3.projectid
					group by departmentid) as t1);

-- 10.5. Вывести имя депатамента с максимальной суммой бюджета проектов по департаментам.
select departmentname
from departments d
join (select t1.departmentid ,sum(budget) as sum_budget
		from employees as t1
		join  employeeprojects as t2
		on t1.employeeid = t2.employeeid
		join projects as t3
		on t2.projectid = t3.projectid
		group by departmentid
		having sum_budget = (select max(t1.sum_budget)
							from (select t1.departmentid ,sum(budget) as sum_budget
							from employees as t1
							join  employeeprojects as t2
							on t1.employeeid = t2.employeeid
							join projects as t3
							on t2.projectid = t3.projectid
							group by departmentid) as t1)) t2
on d.DepartmentID = t2.DepartmentID;

-- Работа с датой и временем

-- Типы данных для даты и времени
-- date - 1 январа 1000 года до 31 декабря 9999(yyyy-mm-dd год:месяц:день). 1000-01-01 до 9999-12-31 (3 байт)
-- time - 838:59:59 до 838:59:59 - hh:mm:ss час:минуты:секунды (3 байт)
-- datetime - yyyy-mm-dd hh:mm:ss (8 байт)
-- timestamp - yyyy-mm-dd hh:mm:ss - 1970-01-10 00:00:01 до 2038-01-19 03:14:07 (4 байт)
-- year - yyyy 1901 до 2155 (1 байт)

-- Функции для работы с датой и временем
select now(); -- timestamp (4 байт) -- текущую дату и время
select sysdate(); -- datetime (8 байт) -- текущую дату и время
select current_timestamp(); -- datetime (8 байт) -- текущую дату и время
 
select current_date(); -- текущая дата date
select curdate(); -- текущая дата date

select current_time(); -- текущее время time
select curtime(); -- текущее время time

-- '2024-08-20'

select dayofmonth('2024-08-20'); -- день месяца(число)
select dayofmonth(current_date()); -- день месяца(число)

select dayofweek('2024-08-20'); -- 3 (1 - sunday) - день недели(число)

select dayofyear('2024-08-20'); -- номер дня в году (число)

select firstname, dayofmonth(hiredate), HireDate
from employees;

select month('2024-08-20'); -- Месяц (число)
select year('2024-08-20'); -- Год (число)

select firstname, HireDate
from employees
where month(hiredate) = 8;

select dayname('2024-08-20'); -- Название дня недели (строка)

select firstname, HireDate
from employees
where dayname(hiredate) = 'Tuesday';

select monthname('2024-08-20'); --  название месяца

select firstname, HireDate
from employees
where monthname(hiredate) = 'August';

-- hour
select hour('12:34:20'); -- час

-- minute
select minute('12:34:20'); -- минуты 

-- second
select second('12:34:20'); -- секунды 

-- extract(param from datetime/timestamp)

-- значение param:
-- second
-- minute
-- hour
-- day
-- month
-- year
-- minute_second
-- hour_minute
-- day_hour

select extract(day from '2024-08-20 11:23:34');
select extract(day from now());
select extract(minute from '2024-08-20 11:23:34');

-- str_to_date(string, format) varchar/char -> date(yyyy-mm-dd)

select str_to_date('August 20 2024', '%M %d %Y');

-- https://www.w3schools.com/sql/func_mysql_str_to_date.asp
