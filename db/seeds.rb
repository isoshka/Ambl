require 'json'

# USERS

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

puts "Creating users..."

User.create!(
  name: 'samschlicht',
  email: 'sam@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance: '500 meters',
  phone_number: '+61401788039',
)
#.photo.attach(io: File.open('app/assets/images/sam.jpg'), filename: 'sam.jpg', content_type: 'image/jpg')

User.create!(
  name: 'ander-lyle',
  email: 'james@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance: '500 meters',
  phone_number: '+818035702607',
)
#.photo.attach(io: File.open('app/assets/images/james.jpg'), filename: 'james.jpg', content_type: 'image/jpg')

User.create!(
  name: 'Isoshka',
  email: 'isabel@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance: '500 meters',
  phone_number: '+817083931377',
)
#.photo.attach(io: File.open('app/assets/images/isabel.png'), filename: 'isabel.png', content_type: 'image/png')

User.create!(
  name: 'ryankaimcclure',
  email: 'ryan@email.com',
  password: '123456',
  frequency: '30 minutes',
  distance: '500 meters',
  phone_number: '+818067915731',
)
#.photo.attach(io: File.open('app/assets/images/ryan.jpg'), filename: 'ryan.jpg', content_type: 'image/jpg')

puts "Created 4 unique users, one for each member of our team"

# INTERESTS

interests = %w(cafe cocktail-bar nightclub ramen sushi izakaya record-store guitar-store book-store gift-store gallery museum park clothes-store plant-store design-store jewelry-store temple monument)

interests.length.times do |i|
  Interest.create!(
    name: interests[i-1]
  )
end

puts "Created #{interests.length} interests"

puts "Creating places..."

# PLACES
# going to iterate over interests so that I can link the place to the interest from the start and do all the json files at once
interests.each do |interest|
  interest_id = (Interest.find_by name: "#{interest}").id
  file = File.read("app/services/#{interest}.json")
  places_hash = JSON.parse(file)
  places_hash["results"].each do |place|
    Place.create!({
                    name: place["name"],
                    address: place["vicinity"],
                    lng: place["geometry"]["location"]["lng"],
                    lat: place["geometry"]["location"]["lat"],
                    interest_id: interest_id,
                    google_place_id: place["place_id"],
                    google_rating: place["rating"],
                    google_photo_url: place["photos"][0]["photo_reference"]
    })
  end
end

puts "Created #{Place.count} places, all within 5km of the Hub in Meguro!"
