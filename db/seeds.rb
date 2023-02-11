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
  name: 'samschlicht',
  email: 'sam@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false,
  phone_number: '+61401788039',
).photo.attach(io: File.open('app/assets/images/sam.jpg'), filename: 'sam.jpg', content_type: 'image/jpg')

User.create!(
  name: 'ander-lyle',
  email: 'james@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false,
  phone_number: '+818035702607',
).photo.attach(io: File.open('app/assets/images/james.jpg'), filename: 'james.jpg', content_type: 'image/jpg')

User.create!(
  name: 'Isoshka',
  email: 'isabel@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false,
  phone_number: '+817083931377',
).photo.attach(io: File.open('app/assets/images/isabel.png'), filename: 'isabel.png', content_type: 'image/png')

User.create!(
  name: 'ryankaimcclure',
  email: 'ryan@email.com',
  password: '123456',
  thirty_minutes: true,
  one_hour: false,
  two_hours: false,
  one_hundred_metres: true,
  five_hundred_metres: false,
  one_kilometer: false,
  phone_number: '+818067915731',
).photo.attach(io: File.open('app/assets/images/ryan.jpg'), filename: 'ryan.jpg', content_type: 'image/jpg')

puts "Created unique users, one for each member of our team"
