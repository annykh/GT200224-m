// https://github.com/annykh/GenTech-171023/blob/main/MongoDB/employees.txt

// updateOne
// updateMany

// $set
// $unset
// $inc

// Обновление массивов

// $push - добавление элемента в массив

// Добавить новый навык сотруднику Bob со значением 'team working'.
db.employees2.updateOne({name: 'Bob'}, {$push: {skills: 'team working'}})

// db.employees2.updateOne({name: 'Bob'}, {$push: {age: 36}})
// The field 'age' must be an array but is of type int in document {_id: ObjectId('66fba626db7a79a0b222b817')}


// Добавить новые навыки сотруднику John со значениями creativity, Javascript.
db.employees2.updateOne(
    {name: 'John'}, 
    {$push: 
        {skills: 
            {$each: 
                ['creativity', 'Javascript']
            }
        }
    }
)

db.employees2.updateOne(
    {name: 'John'}, 
    {$push: 
        {skills: 
            {$each: 
                ['creativity', 'Javascript']
            }
        }
    }
)

// $addToSet - Отличие от push в том, что addToSet добавляет данные, если их еще нет в массиве(через push данные дублируются)
db.employees2.updateOne(
    {name: 'John'}, 
    {$addToSet: 
        {skills: 
            {$each: 
                ['creativity', 'Javascript']
            }
        }
    }
)

// Добавить новый навык сотруднику Lucas со значением 'MongoDB'
db.employees2.updateOne({name: 'Lucas'}, {$addToSet: {skills: 'MongoDB'}})

// Добавить новые навыки сотруднику Maria со значениями 'teamwork', 'programming', 'Java'.
db.employees2.updateOne({name: 'Maria'}, {$addToSet: {skills: {$each: ['teamwork', 'programming', 'Java']}}})

// Добавить новый проект 'Project F' для всех сотрудников.
db.employees2.updateMany({}, {$addToSet: {projects: 'Project F'}})

// Добавить новые навыки "leadership", "creativity" для сотрудников из отдела "HR"
db.employees2.updateMany({department: 'HR'}, {$addToSet: {skills: {$each: ["leadership", "creativity"]}}})

// $position - задает позицию в массиве для вставки элементов
// $slice -  указывает, сколько элементов оставить в массиве после вставки

//Добавить новые проекты 'Project I', 'Project L' для сотурдников из отдела Finance. Вставить новые проекты начиная с 1-ого индекса и оставить 3 проекта в массиве.
db.employees2.updateMany({department: 'Finance'}, {$push: {projects: {$each: ['Project I', 'Project L'], $position: 1, $slice: 3}}})

//Добавить новые навыки 'budgeting', 'organization' для сотрудника Laura. Вставить новые навыки начиная со 1-ого индекса и оставить 4 навыка в массиве.
db.employees2.updateOne({name: 'Laura'}, {$push: {skills: {$each: ['budgeting', 'organization'], $position: 1, $slice: 4}}})

// $pop - позволяет удалить один эл. из массива либо первый, либо последний
// если значение 1 то удалет последний эл., если -1, то первый

// Удалить первый проект сотрудника Bob
db.employees2.updateOne({name: 'Bob'}, {$pop: {projects: -1}})

// Удалить последний проект сотрудника Alice
db.employees2.updateOne({name: 'Alice'}, {$pop: {projects: 1}})

// $pull - удаляет каждое вхождение эл. в массив (можно удалить только одно значение)

//Удалить навык creativity у John
db.employees2.updateOne({name: 'John'}, {$pull: {skills: 'creativity'}})

// $pullAll - удаляет несколько значений из массива

//Удалить навыки organization, teamwork у Maria.
db.employees2.updateOne({name: 'Maria'}, {$pullAll: {skills: ['organization', 'teamwork']}})

// Удалить навык(skills) "financial analysis" у сотрудника "Charlie".
db.employees2.updateOne({name: 'Charlie'}, {$pull: {skills: 'financial analysis'}})

// 1. В бд GT200224 создать коллекцию students и заполнить информацией о студенте.

// firstName - "Alice",
// lastName - "Johnson",
// age - 20,
// course - "Computer Science",
// subjects - ["Math", "Physics", "Programming"],
// averageGrade - 85

db.students.insertOne({
    firstName: "Alice",
    lastName: "Johnson",
    age: 20,
    course: "Computer Science",
    subjects: ["Math", "Physics", "Programming"],
    averageGrade: 85  
})


// 2. Изпользуя скрипт заполнить коллекцию данными об остальных студентах.
// https://github.com/annykh/GenTech-171023/blob/main/MongoDB/students.txt

// 3. Найти всех студентов, чей курс равен "Mathematics".
db.students.find({course: 'Mathematics'})

// 4. Найти всех студентов, чей курс не равен "Physics".
db.students.find({course: {$ne: 'Physics'}})

// 5. Найти всех студентов, чья средняя оценка больше 85.
db.students.find({averageGrade: {$gt: 85}})

// 6. Найти всех студентов, чья средняя оценка больше или равна 90.
db.students.find({averageGrade: {$gte: 90}})

// 7. Найти всех студентов, чей курс соответствует одному из значений в массиве ["Engineering", "Law"].
db.students.find({course: {$in : ["Engineering", "Law"]}})

// 8. Найти всех студентов, чья средняя оценка больше 80 и возраст меньше 23.
db.students.find({averageGrade: {$gt: 80}, age: {$lt: 23}})

// 9. Найти всех студентов, чей возраст меньше 20 или средняя оценка больше 90.
db.students.find({
    $or: [
        {age: {$lt: 20}},
        {averageGrade: {$gt: 90}}
    ]
})

// 10. Добавить предмет "Physics" студенту "Alice", если его там еще нет.
db.students.updateOne(
    {firstName: "Alice"},
    {$addToSet: {subjects: "Physics" }}
)

// 11. Добавить несколько предметов ("Robotics", "Machine Learning") студенту "Frank".
db.students.updateOne(
    {firstName: "Frank"},
    {$push: {subjects: {$each: ["Robotics", "Machine Learning"]}}}
)

// 12. Удалить последний предмет из списка предметов студента "Eva".
db.students.updateOne(
    {firstName: "Eva"},
    {$pop: {subjects: 1}}
)

// 13. Удалить предмет "Algebra" у студента "Bob".
db.students.updateOne(
    {firstName: "Bob"},
    {$pull: {subjects: "Algebra"}}
)

