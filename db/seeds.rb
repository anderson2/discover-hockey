# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



Person.create!(name:  "Trevor Linden",
             email: "trevor.linden@discover-hockey.com",
             password:              "password",
             password_confirmation: "password")

Person.create!(name:  "Kevin Bieksa",
             email: "kevin.bieksa@discover-hockey.com",
             password:              "password",
             password_confirmation: "password")

Person.create!(name:  "Craig B",
             email: "craig@discover-hockey.com",
             password:              "password",
             password_confirmation: "password")

Person.create!(name:  "Henrik Sedin",
             email: "henrik.sedin@discover-hockey.com",
             password:              "password",
             password_confirmation: "password") 
             
Person.create!(name:  "Beta Guest",
             email: "beta.guest@discover-hockey.com",
             password:              "password",
             password_confirmation: "password")

Person.create!(name:  "Kyle Turris",
             email: "kyle.turris@discover-hockey.com",
             password:              "password",
             password_confirmation: "password")
             
Person.create!(name:  "Rob Anderson",
             email: "rob.anderson@discover-hockey.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)

Person.create!(name:  "Hockey Operations",
             email: "hockey.operations@discover-hockey.com",
             password:              "password",
             password_confirmation: "password",
             admin: true)
             
Person.create!(name:  "Roberto Luongo",
             email: "roberto.luongo@discover-hockey.com",
             password:              "password",
             password_confirmation: "password")

Person.create!(name:  "Daniel Sedin",
             email: "daniel.sedin@discover-hockey.com",
             password:              "password",
             password_confirmation: "password")
             
