# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Person.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

Person.create!(name:  "Beta Guest",
             email: "beta.guest@discover.hockey",
             password:              "betatest",
             password_confirmation: "betatest")

Person.create!(name:  "Trevor Linden",
             email: "trevor.linden@discover.hockey",
             password:              "betatest",
             password_confirmation: "betatest")
             
25.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  Person.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end

people = Person.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  people.each { |person| person.posts.create!(content: content) }
end

# Following relationships
people = Person.all
person  = people.first
following = people[8..25]
followers = people[3..17]
following.each { |followed| person.follow(followed) }
followers.each { |follower| follower.follow(person) }
