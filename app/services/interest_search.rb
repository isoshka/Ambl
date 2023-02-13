require 'open-uri'
require 'json'
require_relative '.google_api_key'

class InterestSearch
  def self.search
    # this is the url for a 'nearby search' using the Google Places API, specifying the Hub in Meguro as the location and 10km as the radius
    interests = %w(coffee cocktails nightclub ramen sushi izakaya records guitars books gift-store gallery museum park clothes plant-store design-store jewelry temple monument)
    puts interests
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=35.6345266519309,139.70829303068464&radius=10000&keyword=#{@keyword}&key=#{$google_maps_api_key}")
    interests.each do |interest|
      filepath = "./app/services/#{interest}.json"
      File.new(filepath, "w")
      @keyword = interest
      api_output_serialized = URI.open(url).read
      api_output = JSON.parse(api_output_serialized)
      File.open(filepath, "w") { |f| f.puts api_output.to_json }
    end
  end
end

InterestSearch.search