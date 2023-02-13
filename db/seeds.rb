require_relative 'books.json'
require_relative 'clothes.json'
require_relative 'cocktails.json'
require_relative 'coffee.json'
require_relative 'design-store.json'
require_relative 'gallery.json'
require_relative 'gift-store.json'
require_relative 'guitars.json'
require_relative 'izakaya.json'
require_relative 'jewelry.json'
require_relative 'monument.json'
require_relative 'museum.json'
require_relative 'nightclub.json'
require_relative 'park.json'
require_relative 'plant-store.json'
require_relative 'ramen.json'
require_relative 'records.json'
require_relative 'sushi.json'
require_relative 'temple.json'

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
  distance: '500 meters',
  phone_number: '+61401788039',
).photo.attach(io: File.open('app/assets/images/sam.jpg'), filename: 'sam.jpg', content_type: 'image/jpg')

User.create!(
  name: 'ander-lyle',
  email: 'james@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance: '500 meters',
  phone_number: '+818035702607',
).photo.attach(io: File.open('app/assets/images/james.jpg'), filename: 'james.jpg', content_type: 'image/jpg')

User.create!(
  name: 'Isoshka',
  email: 'isabel@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance: '500 meters',
  phone_number: '+817083931377',
).photo.attach(io: File.open('app/assets/images/isabel.png'), filename: 'isabel.png', content_type: 'image/png')

User.create!(
  name: 'ryankaimcclure',
  email: 'ryan@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance: '500 meters',
  phone_number: '+818067915731',
).photo.attach(io: File.open('app/assets/images/ryan.jpg'), filename: 'ryan.jpg', content_type: 'image/jpg')

puts "Created 4 unique users, one for each member of our team"

interests = %w(coffee cocktails nightclub ramen sushi izakaya records guitars books gift-store gallery museum park clothes plant-store design-store jewelry temple monument)

interests.length.times do |i|
  Interest.create!(
    name: interests[i-1]
  )
end

puts "Created #{interests.length} interests"


