// Проекция
// find({Условие}, {Проекция})

// Вывести только имена и фамилии сотрудников, которые получают больше 4000.
db.workers.find({salary: {$gt: 4000}}, {firstname: 1, lastname: 1, _id: 0})

//Вывести всю информацию о сотрудниках, кроме зарплаты.
db.workers.find({}, {salary: 0})

// Пагинации

// limit(кол/во строк, которое нужно вывести)
// skip(кол/во строк, которое нужно пропустить)

// Вывести первого работника
db.workers.find().limit(1)

// Вывести всех работников пропуская первых двух
db.workers.find().skip(2)

// Вывести двух работников пропуская первого
db.workers.find().skip(1).limit(2)

// Сортировка

// Вывести всех сотрудников и сортировать их по зарплате по убыванию
db.workers.find().sort({salary: -1})

// Вывести сотрудника с самой высокой зарплатой. Вывести только имя, фамилию и зарплату
db.workers.find({}, {firstname: 1, lastname: 1, salary: 1, _id: 0}).sort({salary: -1}).limit(1)

// Вывести трех сотрудников, которые зарабатывают меньше всего
db.workers.find().sort({salary: 1}).limit(3)


db.restaurants.insertMany([
    {
      "name": "Restaurant 1",
      "cuisine": "Italian",
      "location": "New York",
      "menu": [
        { "name": "Pizza Margherita", "price": 12 },
        { "name": "Spaghetti Carbonara", "price": 15 },
        { "name": "Tiramisu", "price": 8 }
      ]
    },
    {
      "name": "Restaurant 2",
      "cuisine": "Mexican",
      "location": "Los Angeles",
      "menu": [
        { "name": "Tacos", "price": 10 },
        { "name": "Burritos", "price": 12 },
        { "name": "Guacamole", "price": 6 }
      ]
    },
    {
      "name": "Restaurant 3",
      "cuisine": "Japanese",
      "location": "Tokyo",
      "menu": [
        { "name": "Sushi", "price": 20 },
        { "name": "Ramen", "price": 15 },
        { "name": "Matcha Ice Cream", "price": 7 }
      ]
    }
  ])


// array.obj1
// menu.name
// menu.price

// Вывести рестораны, где цены меню выше 15.
db.restaurants.find({'menu.price': {$gt: 15}})

// Вывести рестораны, где цены меню не выше 6 долларов
db.restaurants.find({'menu.price': {$lte: 6}})

// Получить первые два ресторана.
db.restaurants.find().limit(2)

// Получить рестораны, пропустив первый, и орграничить выборку двумя ресторанами.
db.restaurants.find().skip(1).limit(2)

// Получить рестораны, где цены меню выше 10 долларов, и отсортировать их по названию в обратном порядке.
db.restaurants.find({'menu.price': {$gt: 10}}).sort({name: -1})

// Пагинация массива

// $slice: limit
// $slice: [skip, limit]

// Получить рестораны с кухней "Italian" и вернуть первые два блюда из меню
db.restaurants.find({cuisine: 'Italian'}, {menu: {$slice: 2}})

// Вывести рестораны с куней 'Japanese' и 'Mexican', вернуть только первое блюдо из меню
db.restaurants.find({cuisine: {$in: ['Japanese', 'Mexican']}}, {menu: {$slice: 1}})


// Обновление данных
// https://github.com/annykh/GenTech-171023/blob/main/MongoDB/workers1.txt

// replaceOne
// Если нам нужно полностью заменить один документ другим, используем replaceOne.

// replaceOne(filter, update[, options])

// filter - Условие
// update - новый документ
// options - upsert: true/false(по умолч.)
// Если true: то mongodb будет обновлять документ, если он найден, и созвадавть новый, если такого докумнета нет.
// Если false: не будет созвадавть новый документ, если запрос на выборку не найдет ни одного документа

// Полностью заменить документ, где имя Boris, фамилия Orlov на:
// имя: 'Ben'
// фамилия: 'Ivanov'
// возраст: 36
// должность: 'HR'
// зарплата: 3500

db.workers1.replaceOne({firstname: 'Boris', lastname: 'Orlov'}, {firstname: 'Ben', lastname: 'Ivanov', age: 36, position: 'HR', salary: 3500})


// Нет сотрудника по такому условию, создаем нового сотрудника  {upsert: true}
db.workers1.replaceOne({firstname: 'Boris', lastname: 'Orlov'}, {firstname: 'Ben', lastname: 'Ivanov', age: 36, position: 'HR', salary: 3500}, {upsert: true})


// Полностью заменить документ, где имя ՛Ivan՛ на
// имя: ՛Den՛
// фамилия: ՛Jameson՛,
// возраст: 35,
// должность: 'server'
// зарплата: 3000
// upsert: false

db.workers1.replaceOne({firstname: 'Ivan'}, {firstname: 'Den', lastname: 'Jameson', age: 35, position: 'server', salary: 3000})


// updateOne
// updateMany

// Чтобы не обновлять весь документ, а только значение одного или нескольких свойств используем updateOne/updateMany. Если нужно обновить только один документ(первый по выборке) используем updateOne, если несколько документов(все по выборке), то используем updateMany

// $set - если нужно обновить отдельное поле, или если обновляемого поля нет, то оно создается
// $inc - для увеличения значения числового поля на определенное кол/во единиц, если обновляемого поля нет, то оно создается
// $unset  - для удаления поля

// db.collection_name.updateOne({filter}, {updated})

// Изменить должность на 'Sales manager' для сотрудника с именем Den и фамилией Jameson
db.workers1.updateOne({firstname: 'Den', lastname: 'Jameson'}, {$set: {position: 'Sales manager'}})

// Добавить свойство department со значением Sales для сотрудника с именем Den и фамилией Jameson
db.workers1.updateOne({firstname: 'Den', lastname: 'Jameson'}, {$set: {department: 'Sales'}})

// Увеличить зарплату сотрудника с именем Boris на 2000.
db.workers1.updateOne({firstname: 'Boris'}, {$inc: {salary: 2000}})

// Уменьшить зарплату сотрудника с именем Marina на 500
db.workers1.updateOne({firstname: 'Marina'}, {$inc: {salary: -500}})

// Удалить поле position для сотрудника с именем Olga
db.workers1.updateOne({firstname: 'Olga'}, {$unset: {position: 1}})
// 1 = true

// Удалить поля salary, skills для сотрудника Marina
db.workers1.updateOne({firstname: 'Marina'}, {$unset: {salary: 1, skills: 1}})

// Добавить новое поле commission со значением 0 для всех сотрудников.
db.workers1.updateMany({}, {$set: {commission: 0}})

// Изменить значение commission на 10 для сотрудников с зарплатой выше 3000.
db.workers1.updateMany({salary: {$gt: 3000}}, {$set: {commission: 10}})

// Увеличить зарплату на 1000 для сотрудников старше 30.
db.workers1.updateMany({age: {$gt: 30}}, {$inc: {salary: 1000}})

// Удалить поле commission для всех сотрудников, кроме Ivan
db.workers1.updateMany({firstname: {$ne: 'Ivan'}}, {$unset: {commission: 1}})
