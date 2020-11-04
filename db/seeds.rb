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

20.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create(name: name,
              email: email,
              password: password,
              password_confirmation: password)
end

2.times do |n|
  10.times do |n|
    title = Faker::Movie.title
    Task.create!(title: title,
                user_id: "#{n + 1}")
  end
end

users = User.all
user = users.first
followings = users[2..19]
followers = users[2..14]
followings.each { |following| user.follow(following)}
followers.each { |follower| follower.follow(user)}