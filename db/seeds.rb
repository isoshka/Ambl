# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
puts "Destroyed all users"
Place.destroy_all
puts "Destroyed all places"
Notification.destroy_all
puts "Destroyed all notifications"
Bookmark.destroy_all
puts "Destroyed all bookmarks"
Interest.destroy_all
puts "Destroyed all interests"

User.create!(
  name: 'samschlicht',
  email: 'sam@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance = '500 meters',
  phone_number: '+61401788039',
).photo.attach(io: File.open('app/assets/images/sam.jpg'), filename: 'sam.jpg', content_type: 'image/jpg')

User.create!(
  name: 'ander-lyle',
  email: 'james@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance = '500 meters',
  phone_number: '+818035702607',
).photo.attach(io: File.open('app/assets/images/james.jpg'), filename: 'james.jpg', content_type: 'image/jpg')

User.create!(
  name: 'Isoshka',
  email: 'isabel@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance = '500 meters',
  phone_number: '+817083931377',
).photo.attach(io: File.open('app/assets/images/isabel.png'), filename: 'isabel.png', content_type: 'image/png')

User.create!(
  name: 'ryankaimcclure',
  email: 'ryan@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance = '500 meters',
  phone_number: '+818067915731',
).photo.attach(io: File.open('app/assets/images/ryan.jpg'), filename: 'ryan.jpg', content_type: 'image/jpg')

puts "Created 4 unique users, one for each member of our team"

interests = %w(coffee cocktails ramen sushi izakayas records guitars books gifts art museums parks clothes plants design)

interests.length.times do |i|
  Interest.create!(
    name: interests[i-1]
  )
end

puts "Created #{interests.length} interests"

# getting places from the Google Places API
# below is code pasted from their documentation:

# require "uri"
# require "net/http"
#
# url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=-33.8670522%2C151.1957362&radius=1500&type=restaurant&keyword=cruise&key=AIzaSyAxwvCN31ixCApVWUY7L_b1N-qw2d0YpYM")
#
# https = Net::HTTP.new(url.host, url.port)
# https.use_ssl = true
#
# request = Net::HTTP::Get.new(url)
#
# response = https.request(request)
# puts response.read_body