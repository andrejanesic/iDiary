# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

### Users ###

User.first_or_create(
    email: 'adam@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: User.roles[:admin]
)

User.first_or_create(
    email: 'marie@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: User.roles[:user]
)

User.first_or_create(
    email: 'john@example.com',
    password: 'password',
    password_confirmation: 'password',
    role: User.roles[:user]
)

admn = User.where(id: 1).first
admn.role = User.roles[:admin]
admn.save