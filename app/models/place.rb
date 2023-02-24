class Place < ApplicationRecord
  belongs_to :interest

  geocoded_by :address, latitude: 'lat', longitude: 'lng'
end
