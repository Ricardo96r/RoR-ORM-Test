require "faker"

100000.times do
  Student.create([{
          name: Faker::Name.name,
          lastname: Faker::Name.last_name,
          birthday: Faker::Date.backward(),
          address: Faker::Address.full_address
      }])
end