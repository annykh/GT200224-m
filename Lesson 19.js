// Агрегация

// Кол/во элементов/документов в коллекции

// кол/во всех документов в коллекции
db.workers1.countDocuments()
db.workers1.find().count()

// кол/во сотрудников, которым больше 30
db.workers1.find({age: {$gt: 30}}).count()

// https://github.com/annykh/GenTech-171023/blob/main/MongoDB/employees.txt

// кол.во сотрудников из отдела 'Finance' пропуская первого
db.emp1.find({department: 'Finance'}).skip(1).count()

// Вывод уникальных значений

// Вывести список всех департаментов
db.emp1.distinct('department') // [ 'Finance', 'HR', 'IT' ]

// Агрегация и групировка

// db.collection_name.aggregate()

// $sum
// $avg
// $min
// $max

// $match - фильтрация
// $project - проекция, вывод конкретных полей
// $group - группировка
// $skip - пагинация
// $limit - пагинация
// $sort - сортировка

// Вывести имя и возраст сотрудников, где возраст больше 30 и сортировать по возрасту по убыв.

db.emp1.aggregate([
    {$match: {age: {$gt: 30}}}, // условие
    {$project: {name: 1, age: 1, _id: 0}}, // 1 - true, 0 - false
    {$sort: {age: -1}} // 1 - по возр. / -1 - по убыв.  
])

db.emp1.aggregate([
    {$match: {age: {$gt: 30}}},
    {$project: {name: 1, age: 1, _id: 0}},
    {$sort: {age: -1}} 
])

// Найти сумму зарплаты всех сотрудников.

// select sum(salary)
// from workers2;

// {$group: {_id: $название_поля/null, имя_нового_поля: {агрегатная_функция: {'$поле'}}}}
// название_поля - по которому группируем
// null - если нет группировки
// имя_нового_поля - в mysql команда [as new_column_name]
// агрегатная_функция - $sum, $avg, $min, $max
// $поле - поле по которому выполняется агрегатная функция

db.workers2.aggregate([
    {$group: {_id: null, total_sum: {$sum: '$salary'}}}
])

// Output
// {
//     _id: null,
//     total_sum: 27700
//   }

// Найти суммы зарплат по position.
db.workers2.aggregate([
    {$group: {_id: '$position', total_salary: {$sum: '$salary'}}}
])

// select sum(salary), position
// from workers2
// group by position;

// Найти суммы зарплат по position. Сотрировать по убыв. суммы.

db.workers2.aggregate([
    {$group: {_id: '$position', total_salary: {$sum: '$salary'}}},
    {$sort: {total_salary: -1}}
])

// select sum(salary) as total_salary, position
// from workers2
// group by position
// order by total_salary desc;

// Вывести сумму зарплат сотрудников с должностью(position) Server.

db.workers2.aggregate([
    {$match: {position: 'Server'}},
    {$group: {_id: '$position', total_salary: {$sum: '$salary'}}}
])

// select position, sum(salary)
// from workers2
// where position = 'Server'
// group by position;

// Найти среднее значение поля salary

db.workers2.aggregate([
    {$group: {_id: null, avg_salary: {$avg: '$salary'}}}
])

// select avg(salary)
// from workers2;

// Найти среднее значение поля salary. Вывести это занчение, если оно больше 0.

db.workers2.aggregate([
    {$group: {_id: null, avg_salary: {$avg: '$salary'}}},
    {$match: {avg_salary: {$gt: 0}}}
])

// select avg(salary) as avg_salary
// from workers2
// where avg_salary > 0;

// Вывести сумму зарплат сотрудников по position, если сумма больше 3000.

db.workers2.aggregate([
    {$group: {_id: '$position', total_salary: {$sum: '$salary'}}},
    {$match: {total_salary: {$gt: 3000}}}
])

// select position, sum(salary) as total_salary
// from workers2
// group by position
// having total_salary > 3000;

// https://github.com/annykh/GenTech-171023/blob/main/MongoDB/employees1.txt

// Найти среднее значение salary по департаментам для сотрудников старше 40.

db.employees3.aggregate([
    {$match: {age: {$gt: 40}}},
    {$group: {_id: '$department', avg_salary: {$avg: '$salary'}}}
])

// select department, avg(salary)
// from employees3
// where age > 40
// group by department;

// Найти среднюю зарплату среди среди сотрудников из департамента IT.

db.employees3.aggregate([
    {$match: {department: 'IT'}},
    {$group: {_id: '$department', avg_salary: {$avg: '$salary'}}}
])

// Output:
// {
//     _id: 'IT',
//     avg_salary: 4950
// }

db.employees3.aggregate([
    {$match: {department: 'IT'}},
    {$group: {_id: null, avg_salary: {$avg: '$salary'}}}
])

// Output: 
// {
//     _id: null,
//     avg_salary: 4950
//   }

// Найти максимальную зарплату в каждом департаменте.

db.employees3.aggregate([
    {$group: {_id: '$department', max_salary: {$max: '$salary'}}}
])

// Вывести кол/во документов в коллекции employees3
db.employees3.countDocuments()
db.employees3.find().count()

// Отобразить только имена и фамилии сотрудников, зарабатывающих больше 5000, и отсортировать их по зарплате по возрастанию.

db.employees3.aggregate([
    {$match: {salary: {$gt: 5000}}},
    {$project: {firstname: 1, lastname: 1, _id: 0}},
    {$sort: {salary: 1}}
])

// Найти средний возраст сотрудников по каждой должности(position) и отсортировать по среднему возрасту по убыванию.

db.employees3.aggregate([
    {$group: {_id: '$position', avg_age: {$avg: '$age'}}},
    {$sort: {avg_age: -1}}
])
