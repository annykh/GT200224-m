// db.collection_name.insertMany([
//     {...},
//     {...},
//     {...}
// ])

// db.collection_name.find({Условие})

// $eq
// $ne
// $lt
// $lte
// $gt
// $gte
// $in

// name: 'John'

// key: {$оператор: значение}
// key: {$in: [ , , , ]}

// db.collection_name.deleteOne({Условие})
// db.collection_name.deleteMany({Условие})

// 1. Создать коллекцию employees
// 2. Заполнить коллекцию свойствами _id, firstname, lastname, age, position, salary, skills.

    // 1. Inga Petrova, 27, Barista, 1500, [’preparing drinks’, ‘cleaning equipment’] 
    // 2. Boris Orlov, 36, Server, 2400, [’taking orders’, ‘suggesting meals’, ‘taking payments’]
    // 3. Ivan Demidov, 32, Chef, 3200, [’preparing food’, ‘baking bread’]
    // 4. Marina Sidorova, 22, Hostess, 1700, [’greeting guests’, ‘seating guests’, ‘answering phone calls’]
    // 5. Olga Ivanova, 43, Sommelier, 2500, [’curating a wine list’, ‘creating wine pairings’]

    db.employees.insertMany([
        {
          _id: 1,
          firstname: 'Inga',
          lastname: 'Petrova',
          age: 27,
          position: 'Barista',
          salary: 1500,
          skills: ['preparing drinks', 'cleaning equipment']
        },
        {
          _id: 2,
          firstname: 'Boris',
          lastname: 'Orlov',
          age: 36,
          position: 'Server',
          salary: 2400,
          skills: ['taking orders', 'suggesting meals', 'taking payments']
        },
        {
          _id: 3,
          firstname: 'Ivan',
          lastname: 'Demidov',
          age: 32,
          position: 'Chef',
          salary: 3200,
          skills: ['preparing food', 'baking bread']
        },
        {
          _id: 4,
          firstname: 'Marina',
          lastname: 'Sidorov',
          age: 22,
          position: 'Hostess',
          salary: 1700,
          skills: ['greeting guests', 'seating guests', 'answering phone calls']
        },
        {
          _id: 5,
          firstname: 'Olga',
          lastname: 'Ivanova',
          age: 43,
          position: 'Sommelier',
          salary: 2500,
          skills: ['curating a wine list', 'creating wine pairings']
        }
      ])


// Найти работников, чьи зарпалты больше 2000.
db.employees.find({salary: {$gt: 2000}})

// Найти работников младше 30 лет.
db.employees.find({age: {$lt: 30}})

// Логические операторы 
// $and: возвращает документы, в которых выполняются оба условия
// $or: возвращает документы, в которых выполняется хотя бы одно условие
// $not: возвращает документы, в которых условие не выполняется

// Найти работников, чьи возрасты находятся в диапазоне от 30 до 45(вкл. концы).
db.employees.find(
    {
        $and: [
            {age: {$gte: 30}},
            {age: {$lte: 45}}
        ]
    }
)

db.employees.find({age: {$gte: 30, $lte: 45}})

// Найти работников, чьи зарплаты либо меньше 2000, либо больше 3000(концы не вкл.).
db.employees.find(
    {
        $or: [
            {salary: {$lt: 2000}},
            {salary: {$gt: 3000}}
        ]
    }
)

// Найти работников, которым либо больше 35, либо меньше 25.
db.employees.find(
    {
        $or: [
            {age: {$gt: 35}},
            {age: {$lt: 25}}
        ]
    }
)

// Найти всех работников, у которых должность "Server" или "Chef".
db.employees.find(
    {
        $or: [
            {position: 'Server'},
            {position: 'Chef'}
        ]
    }
)

db.employees.find({position: {$in: ['Server', 'Chef']}})

// Найти всех работников, чья зарплата меньше 3000 или возраст больше 40.
db.employees.find(
    {
        $or: [
            {salary: {$lt: 3000}},
            {age: {$gt: 40}}
        ]
    }
)

// Найти работников, которым не больше 40
db.employees.find({age: {$not: {$gt: 40}}})


// Найти работников, которым либо больше 35, либо меньше 25. Решить через not.
// not 25-35
db.employees.find({age: {$not: {$gte: 25, $lte: 35}}})

