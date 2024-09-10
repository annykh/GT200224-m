// use db_name
// db.createCollection('collection_name')
// db.collection_name.insertOne({})
// db.collection_name.insertMany([{}, {}, {}, ...])

db.user.insertOne({
    first_name: 'Tom',
    last_name: 'Jameson',
    age: 25
})

db.user.insertMany([
    {
        first_name: 'James',
        last_name: 'Smith',
        age: 18
    },
    {
        first_name: 'Lily',
        last_name: 'Hardy',
        age: 24
    },
    {
        first_name: 'Ben',
        last_name: 'Brown',
        age: 38
    }
])

// Создать коллекцию workers и заполнить документами со следующими свойствами: _id, firstname, lastname, position, salary. Используйте следующие данные:
	
// 1 Петр Сергеев CEO 7000
// 2 Виктор Семенов Web-developer 5000
// 3 Никита Петров Assistant 3500
// 4 Инна Орлова Accountant 4500

db.createCollection('workers')

db.workers.insertMany([
    {
        _id: 1,
        firstname: 'Петр',
        lastname: 'Сергеев',
        position: 'CEO',
        salary: 7000
    },
    {
        _id: 2,
        firstname: 'Виктор',
        lastname: 'Семенов',
        position: ' Web-developer',
        salary: 5000
    },
    {
        _id: 3,
        firstname: 'Никита',
        lastname: 'Петров',
        position: 'Assistant',
        salary: 3500
    },
    {
        _id: 4,
        firstname: 'Инна',
        lastname: 'Орлова',
        position: 'Accountant',
        salary: 4500
    }
])

// Выборка - вывод всех данных
// select * from table_name;
db.workers.find()


// Выборка с условием
db.workers.find({условие})

// Операторы сравнения

// $eq : значения равны - equal
// $ne : значения не равны - not equal
// $gt : значение больше другого значения - greater than
// $gte : значение больше или равно другому значению - greater than equal
// $lt : значение меньше другого значения - less than
// $lte : значение меньше или равно другому значению - less than equal
// $in : значение соответствует одному из значений в массиве 

// Вывести сотрудника с именем Виктор.

// select * from workers
// where firstname = 'Виктор';

db.workers.find({firstname: 'Виктор'})
db.workers.find({firstname: {$eq: 'Виктор'}})

// Вывести сотрудника с ид 1
db.workers.find({_id: 1})
db.workers.find({_id: {$eq: 1}})

// Вывести сотруников с зарплатой выше 4000.
db.workers.find({salary: {$gt: 4000}})

// Вывести сотрудника с именем Никита.
db.workers.find({firstname: 'Никита'})

// Вывести сотрудников с зарплатой не больше 5000.
db.workers.find({salary: {$lte: 5000}})

// Вывести всех сотрудников кроме Никиты. 
db.workers.find({firstname: {$ne: 'Никита'}})

// Вывести сотруников с именами Петр, Виктор, Алекс
db.workers.find({firstname: {$in: ['Петр', 'Виктор', 'Алекс']}})

// Вывести сотрудников с зарплатой выше 10000
db.workers.find({salary: {$gt: 10000}})
// пустая выборка

// Создать новую бд tasks
// use tasks

// Создать коллекцию vegetables и заполнить документами со следующими свойствами: _id, title, price, count, country. Используйте следующие данные:
	
// 1 Potato 370 5 Germany
// 2 Onion 320 3 Poland
// 3 Tomato 210 9 Spain
// 4 Carrot 280 4 France

db.vegetables.insertMany([
    { _id: 1,
      title: 'Potato',
      price: 370,
      count: 5,
      country: 'Germany'
    },
    {   _id: 2,
        title: 'Onion',
        price: 320,
        count: 3,
        country: 'Poland'
    },
    {_id: 3,
        title: 'Tomato',
        price: 210,
        count: 9,
        country: 'Spain'
    },
    {_id: 4,
        title: 'Carrot',
        price: 280, 
        count: 4,
        country: 'France'
    }
])

// Вывести все данные из коллекции
db.vegetables.find()

// Вывести только те данные, где кол/во больше 5
db.vegetables.find({count: {$gt: 5}})

// Вывести данные, где цена меньше/равно 300
db.vegetables.find({price: {$lte: 300}})

// Вывести данные, где страна либо Испания, либо Франция
db.vegetables.find({country: {$in: ['Spain', 'France']}})

// cls - Очищает скрипт/консоль
// show databases - Показывает все бд
// show collections - Показывает все коллекции в бд
// db.dropDatabase() - Удалит бд
// db.collection_name.drop() - Удалит коллекцию
// db.collection_name.deleteOne({Условие}) - Удалит первую запись соответствующий запросу
// db.collection_name.deleteMany({Условие}) - - Удалит все записи соответствующие запросу

// Создать новую бд new_tasks
use new_tasks

// Создать коллекцию users. 

// _id, first_name, last_name, age

// 1 John Smith 30
// 2 Bob Brown 36
// 3 Derek Smith 27
// 4 Leo Brown 23
// 5 Lily Jonson 21
// 6 John King 27

db.users.insertMany([
    {
        _id: 1,
        first_name: 'John',
        last_name: 'Smith',
        age: 30
      },
      {
        _id: 2,
        first_name: 'Bob',
        last_name: 'Brown',
        age: 36
      },
      {
        _id: 3,
        first_name: 'Derek',
        last_name: 'Smith',
        age: 27
      },
      {
        _id: 4,
        first_name: 'Leo',
        last_name: 'Brown',
        age: 23
      },
      {
        _id: 5,
        first_name: 'Lily',
        last_name: 'Jonson',
        age: 21
      },
      {
        _id: 6,
        first_name: 'John',
        last_name: 'King',
        age: 27
      }
])


// Вывести всех пользователей
db.users.find()

// Вывести пользователей, которым больше 25
db.users.find({age: {$gt: 25}})

// Удалить первого пользователя, которому меньше 30
db.users.deleteOne({age: {$lt: 30}})

// Удалить всех пользователей, которым больше 25
db.users.deleteMany({age: {$gt: 25}})

// Удалить коллекцию users
db.users.drop()

// Удалить бд new_tasks
db.dropDatabase()
