# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
require 'faker'

Faker::Config.locale = 'pt-BR'

address_sp = ["Praça Antônio Prado 33, SP", "R. do Comércio, 34, SP",
              "R. João Brícola, 24, SP", "R. Álvares Penteado, 221, SP", "Av. São João, 128, SP",
              "Av. Prestes Maia, 78 SP", "Av. São João, 677, SP", "Av. Cásper Líbero, 173, SP", "Rua Jericó, 193, SP",
              "Rua Adolfo Bergamini 173, SP"]

puts 'cleaning db...'
  Proposal.destroy_all
  Event.destroy_all
  Musician.destroy_all
  Company.destroy_all
  User.destroy_all

  puts "cleaned..."

puts 'Creating permanent fake users for companies and musicians...'
  User.create!(
    email:    "a@a.com",
    password: "123123",
    boolean_company: true
  )

  Company.create!(
    title: Faker::Company.name,
    address: Faker::Address.street_address,
    phone:Faker::Number.number(digits: 11) ,
    category: Faker::Music.genre,
    description: Faker::Lorem.sentence(word_count: 20),
    user: User.last
  )

  puts 'Creating permanent fake users for companies and musicians...'
  User.create!(
    email:    "company@company.com",
    password: "123123",
    boolean_company: true
  )
  
  Company.create!(
    title: Faker::Company.name,
    address: Faker::Address.street_address,
    phone:Faker::Number.number(digits: 11) ,
    category: Faker::Music.genre,
    description: Faker::Lorem.sentence(word_count: 20),
    user: User.last
  )
# ==============================================================================
  User.create!(
    email:    "musician@musician.com",
    password: "123123",
    boolean_company: false
  )

  Musician.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    nickname: Faker::Books::TheKingkillerChronicle.character,
    address: Faker::Address.street_address,
    category: Faker::Music.genre,
    birth_date: Date.new(1990,2,3),
    description: Faker::Quotes::Shakespeare.hamlet_quote,
    phone: Faker::Number.number(digits: 11),
    user: User.last,
    rating: Faker::Number.within(range: 1..5)
  )
# ==============================================================================
puts "creating 10 users and companies"
# CRIANDO EVENTS
events = 0
 10.times do
      User.create!(
      email: Faker::Internet.email,
      password: "123123",
      boolean_company: true
    )

    Company.create!(
      title: Faker::Company.name,
      address: address_sp[events],
      phone:Faker::Number.number(digits: 11),
      category: Faker::Music.genre,
      description: Faker::Lorem.sentence(word_count: 20),
      user: User.last
    )
  end


# 10.times do
#   User.create!(
#     email: Faker::Internet.email,
#     password: "123123",
#     boolean_company: true
#   )

#   Company.create!(
#     title: Faker::Company.name,
#     address: Faker::Address.street_address,
#     phone:Faker::Number.number(digits: 11),
#     category: Faker::Music.genre,
#     description: Faker::Lorem.sentence(word_count: 20),
#     user: User.last
#   )

# end
puts "creating 2 events"
  2.times do Event.create!(
    start_date: Date.new(1990, 2, 3),
    end_date: Date.new(1990, 2, 3),
    start_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    end_time: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now),
    price: 300,
    title_event: Faker::FunnyName.name,
    description_event: Faker::Lorem.sentence(word_count: 20),
    company: Company.last
  )
  events += 1
end
puts "creating 10 musicians"
  10.times do
    User.create!(
      email: Faker::Internet.email,
      password: "123123",
      boolean_company: false
    )
    Musician.create!(
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
      nickname: Faker::Books::TheKingkillerChronicle.character,
      address: Faker::Address.street_address,
      category: Faker::Music.genre,
      birth_date: Date.new(1990,2,3),
      description: Faker::Quotes::Shakespeare.hamlet_quote,
      phone: Faker::Number.number(digits: 11),
      user: User.last,
      rating: Faker::Number.within(range: 1..5)
    )
  end
puts "creating 2 proposals one for last musician, one for first"
  Proposal.create!(
    musician_id: Musician.last.id,
    event_id: Event.last.id,
    winner: nil
  )

  Proposal.create!(
    musician_id: Musician.first.id,
    event_id: Event.first.id,
    winner: nil
  )
puts 'Finished!'
