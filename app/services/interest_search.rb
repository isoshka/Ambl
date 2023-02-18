require 'open-uri'
require 'json'
require 'yaml'

class InterestSearch
  def self.search
    # this is the url for a 'nearby search' using the Google Places API, specifying the Hub in Meguro as the location and 10km as the radius
    interests = %w(cafe cocktail-bar nightclub ramen)
    puts interests
    url = URI("https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=35.6345266519309,139.70829303068464&radius=5000&keyword=#{@keyword}&key=AIzaSyCqJKoNQrQGewoxaSaj6fTSinJLntgKNrI")
    interests.each do |interest|
      filepath = "./app/services/#{interest}.json"
      File.new(filepath, "w")
      @keyword = interest
      api_output = URI.open(url).read
      File.open(filepath, "w") { |f| f.puts api_output }
    end
  end
end

InterestSearch.search
