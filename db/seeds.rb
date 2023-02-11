# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Destroying all users"
User.destroy_all
puts "Destroying all places"
Place.destroy_all
puts "Destroying all notifications"
Notification.destroy_all
puts "Destroying all bookmarks"
Bookmark.destroy_all
puts "Destroying all interests"
Interest.destroy_all

User.create!(
  email: 'sam@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false
)

User.create!(
  email: 'james@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false
)

User.create!(
  email: 'isabel@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false
)

User.create!(
  email: 'ryan@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false
)

puts "Created unique users, one for each member of our team"
