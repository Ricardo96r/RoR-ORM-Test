require "faker"

data = []
10000.times do
  data.push({
                name: Faker::Name.name,
                lastname: Faker::Name.last_name,
                birthday: Faker::Date.backward(),
                address: Faker::Address.full_address
            })
end

Student.create(data)
Teacher.create(data)

data = []
i = 1
10000.times do
  data.push({
                name: Faker::Educator.course_name,
                teacher_id: i
            })
  i += 1
end

Lesson.create(data)

10000.times do
  lesson = Lesson.find(Faker::Number.between(from: 1, to: 10000))
  student = Student.find(Faker::Number.between(from: 1, to: 10000))
  student.lessons << lesson
end