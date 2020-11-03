# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "jason",
            email: "jason@icloud.com",
            password: "password",
            password_confirmation: "password")

9.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

Task.create!(title:"workout", user_id: 1)
9.times do |n|
  Task.create!(title:"test#{n}",
              user_id: "#{n + 1}")
end