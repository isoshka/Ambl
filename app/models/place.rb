class Place < ApplicationRecord
  belongs_to :interest
  geocoded_by :address, latitude: 'lat', longitude: 'lng'
  after_validation :geocode, if: :will_save_change_to_address?
  acts_as_favoritable

  def image_url
    return nil unless photo_reference

    GooglePlaces.photo_url(
      photo_reference,
      max_width: 800,
      max_height: 800,
      api_key: ENV['GOOGLE_PLACES_API_KEY']
    )
  end
end
