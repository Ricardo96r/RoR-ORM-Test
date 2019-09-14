require "faker"

data = []
100000.times do
  data.push({
              name: Faker::Name.name,
              lastname: Faker::Name.last_name,
              birthday: Faker::Date.backward(),
              address: Faker::Address.full_address
            })
end

Student.create(data)