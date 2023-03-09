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
  User.create!(
    email:    Faker::Internet.email,
    password: "123123"
    )

  Company.create!(
    title: Faker::Company.name,
    address: Faker::Address.street_address,
    phone:Faker::Number.number(digits: 11) ,
    category: Faker::Music.genre,
    description: Faker::Lorem.sentence(word_count: 20),
    user: User.last
  )

10.times do
    User.create!(
      email:    Faker::Internet.email,
      password: "123123"
    )

    Company.create!(
      title: Faker::Company.name,
      address: Faker::Address.street_address,
      phone:Faker::Number.number(digits: 11) ,
      category: Faker::Music.genre,
      description: Faker::Lorem.sentence(word_count: 20),
      user: User.last
    )

    Musician.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      nickname: Faker::Books::TheKingkillerChronicle.character,
      address: Faker::Address.street_address,
      category: Faker::Music.genre,
      birth_date: Date.new(1990,2,3),
      description: Faker::Quotes::Shakespeare.hamlet_quote,
      phone: Faker::Number.number(digits: 11) ,
      user: User.last,
      rating: Faker::Number.within(range: 1..5)
)
end

puts 'Finished!'
