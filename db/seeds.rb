# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

puts 'cleaning db...'
  Company.destroy_all
  User.destroy_all
  puts "cleaned..."

puts 'Creating 10 fake users and companies...'

  Company.create(
    title: Faker::Company.name,
    address: Faker::Address.street_address,
    phone: Faker::PhoneNumber.phone_number,
    user: User.last
  )

10.times do
    User.create(
    email:    Faker::Internet.email,
    password: "123123"
    )
    Company.create(
      title: Faker::Company.name,
      address: Faker::Address.street_address,
      phone: Faker::PhoneNumber.phone_number,
      user: User.last
    )
end

puts 'Finished!'
