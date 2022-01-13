# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)







99.times do
users=User.take(30);

users.each{ |user| UserTime.create(
    user_id: user.id,
    time: Faker::Number.between(from: 1, to:10),
    distance: Faker::Number.between(from: 1, to:20),
    date: Faker::Date.in_date_period
) }



end

